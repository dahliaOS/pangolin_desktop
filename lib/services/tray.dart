import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/other/log.dart';

abstract class TrayService extends ListenableService<TrayService>
    with LoggerProvider {
  TrayService();

  static TrayService get current {
    return ServiceManager.getService<TrayService>()!;
  }

  static TrayService build() {
    if (!Platform.isLinux) return _DummyTrayService();

    return _DbusTrayService();
  }

  factory TrayService.fallback() = _DummyTrayService;

  List<StatusNotifierItem> get items;
}

class _DbusTrayService extends TrayService {
  final DBusServer _server = DBusServer();
  final List<StatusNotifierItem> _items = [];
  late final _DBusTrayBackend backend = _DBusTrayBackend(this);

  List<String> get _dbusItems =>
      _items.map((e) => '${e.object.name}${e.object.path.value}').toList();

  StreamSubscription? _nameSubscription;
  DBusClient? _client;

  @override
  List<StatusNotifierItem> get items => List.from(_items);

  Future<void> registerItem(String name, String path) async {
    final StatusNotifierItemObject object =
        StatusNotifierItemObject(_client!, name, DBusObjectPath(path));
    final StatusNotifierItem item = await StatusNotifierItem.fromObject(object);
    _items.add(item);
    backend.emitStatusNotifierItemRegistered("$name$path");
    backend.emitPropertiesChanged(
      _DBusTrayBackend.interface,
      changedProperties: {
        'RegisteredStatusNotifierItems': DBusArray.string(_dbusItems),
      },
    );
    notifyListeners();
  }

  void unregisterItem(StatusNotifierItem item) {
    _items.remove(item);
    backend.emitStatusNotifierItemUnregistered(
      "${item.object.name}${item.object.path.value}",
    );
    notifyListeners();
  }

  void _nameOwnerChanged(DBusNameOwnerChangedEvent event) {
    final StatusNotifierItem? obj =
        _items.firstWhereOrNull((e) => e.object.name == event.name);

    if (obj != null) {
      if (event.newOwner != null && event.newOwner!.isNotEmpty) return;

      unregisterItem(obj);
    }
  }

  @override
  Future<void> start() async {
    if (await _registerClient(DBusClient.session())) return;

    final DBusAddress address = await _server.listenAddress(
      DBusAddress.unix(
        path: "${Directory.systemTemp.path}/pangolin-dbus",
      ),
    );

    if (await _registerClient(DBusClient(address))) return;

    throw Exception(
      "Could not connect to a DBus instance, crashing the service to get fallback",
    );
  }

  @override
  Future<void> stop() async {
    backend.emitStatusNotifierHostUnregistered();
    if (backend.client != null) {
      await _client?.unregisterObject(backend);
    }
    await _client?.releaseName(_DBusTrayBackend.interface);
    await _client?.close();
    _client = null;
    await _server.close();
  }

  Future<bool> _registerClient(DBusClient client) async {
    try {
      _client = client;
      await _client!.requestName(_DBusTrayBackend.interface);
      await _client!.registerObject(backend);
      _nameSubscription = _client!.nameOwnerChanged.listen(_nameOwnerChanged);
      backend.emitStatusNotifierHostRegistered();
      backend.emitPropertiesChanged(
        _DBusTrayBackend.interface,
        changedProperties: {
          'IsStatusNotifierHostRegistered': const DBusBoolean(true),
          'ProtocolVersion': const DBusInt32(0),
          'RegisteredStatusNotifierItems': DBusArray.string([]),
        },
      );
      return true;
    } catch (e) {
      logger.warning(
        "Could not register client $client for tray service, unregistering",
      );
      backend.emitStatusNotifierHostUnregistered();
      if (backend.client != null) {
        await client.unregisterObject(backend);
      }
      await client.releaseName(_DBusTrayBackend.interface);
      await client.close();
      _nameSubscription?.cancel();
      _nameSubscription = null;
      _client = null;
      return false;
    }
  }

  // Reserved for future use eventually
  // ignore: unused_element
  Future<void> _seekWanderingNotifierItems(DBusClient client) async {
    final List<String> names = await client.listNames();

    for (final String name in names) {
      final DBusMethodSuccessResponse response = await client
          .callMethod(
            destination: name,
            path: DBusObjectPath.root,
            interface: 'org.freedesktop.DBus.Introspectable',
            name: 'Introspect',
            replySignature: DBusSignature.string,
          )
          .timeout(
            const Duration(seconds: 1),
            onTimeout: () => DBusMethodSuccessResponse([
              const DBusString(""),
            ]),
          );

      final String contents = response.returnValues[0].asString();

      if (contents.isEmpty) continue;

      final DBusIntrospectNode node =
          parseDBusIntrospectXml(response.returnValues[0].asString());

      final DBusIntrospectInterface? interface = node.interfaces
          .firstWhereOrNull((e) => e.name == "org.kde.StatusNotifierItem");

      if (interface != null) {
        registerItem(name, "/");
      }
    }
  }
}

class _DummyTrayService extends TrayService {
  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }

  @override
  List<StatusNotifierItem> get items => [];
}

class _DBusTrayBackend extends DBusObject {
  static const String interface = "org.kde.StatusNotifierWatcher";

  final _DbusTrayService service;

  _DBusTrayBackend(this.service)
      : super(DBusObjectPath('/StatusNotifierWatcher'));

  @override
  List<DBusIntrospectInterface> introspect() {
    return [
      DBusIntrospectInterface(
        'org.kde.StatusNotifierWatcher',
        methods: [
          DBusIntrospectMethod(
            'RegisterStatusNotifierItem',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'service',
              ),
            ],
          ),
          DBusIntrospectMethod(
            'RegisterStatusNotifierHost',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.in_,
                name: 'service',
              ),
            ],
          )
        ],
        signals: [
          DBusIntrospectSignal(
            'StatusNotifierItemRegistered',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'service',
              ),
            ],
          ),
          DBusIntrospectSignal(
            'StatusNotifierItemUnregistered',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'service',
              ),
            ],
          ),
          DBusIntrospectSignal('StatusNotifierHostRegistered'),
          DBusIntrospectSignal('StatusNotifierHostUnregistered')
        ],
        properties: [
          DBusIntrospectProperty(
            'RegisteredStatusNotifierItems',
            DBusSignature('as'),
            access: DBusPropertyAccess.read,
          ),
          DBusIntrospectProperty(
            'IsStatusNotifierHostRegistered',
            DBusSignature('b'),
            access: DBusPropertyAccess.read,
          ),
          DBusIntrospectProperty(
            'ProtocolVersion',
            DBusSignature('i'),
            access: DBusPropertyAccess.read,
          ),
        ],
      ),
    ];
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall methodCall) async {
    switch (methodCall.name) {
      case 'RegisterStatusNotifierItem':
        if (methodCall.signature != DBusSignature.string) {
          return DBusMethodErrorResponse.invalidArgs();
        }

        final String serviceValue = methodCall.values[0].asString();

        final String name;
        final String path;

        if (serviceValue.startsWith("/")) {
          name = methodCall.sender;
          path = serviceValue;
        } else {
          name = serviceValue;
          path = "/StatusNotifierItem";
        }

        service.registerItem(name, path);

        return DBusMethodSuccessResponse([]);
      case 'RegisterStatusNotifierHost':
        if (methodCall.signature != DBusSignature.string) {
          return DBusMethodErrorResponse.invalidArgs();
        }

        // We don't actually do anything
        return DBusMethodSuccessResponse();
    }

    return DBusMethodErrorResponse.unknownMethod();
  }

  @override
  Future<DBusMethodResponse> getProperty(String interface, String name) async {
    switch (name) {
      case 'IsStatusNotifierHostRegistered':
        return DBusMethodSuccessResponse([const DBusBoolean(true)]);
      case 'ProtocolVersion':
        return DBusMethodSuccessResponse([const DBusInt32(0)]);
      case 'RegisteredStatusNotifierItems':
        return DBusMethodSuccessResponse(
          [DBusArray.string(service._dbusItems)],
        );
    }

    return DBusMethodErrorResponse.unknownProperty();
  }

  @override
  Future<DBusMethodResponse> setProperty(
    String interface,
    String name,
    DBusValue value,
  ) async {
    switch (name) {
      case 'RegisteredStatusNotifierItems':
      case 'IsStatusNotifierHostRegistered':
      case 'ProtocolVersion':
        return DBusMethodErrorResponse.propertyReadOnly();
    }

    return DBusMethodErrorResponse.unknownProperty();
  }

  Future<void> emitStatusNotifierItemRegistered(String service) async {
    await emitSignal(
      'org.kde.StatusNotifierWatcher',
      'StatusNotifierItemRegistered',
      [DBusString(service)],
    );
  }

  Future<void> emitStatusNotifierItemUnregistered(String service) async {
    await emitSignal(
      'org.kde.StatusNotifierWatcher',
      'StatusNotifierItemUnregistered',
      [DBusString(service)],
    );
  }

  Future<void> emitStatusNotifierHostRegistered() async {
    await emitSignal(
      'org.kde.StatusNotifierWatcher',
      'StatusNotifierHostRegistered',
      [],
    );
  }

  Future<void> emitStatusNotifierHostUnregistered() async {
    await emitSignal(
      'org.kde.StatusNotifierWatcher',
      'StatusNotifierHostUnregistered',
      [],
    );
  }
}

class SystemTrayItem {
  final DBusRemoteObject owner;

  const SystemTrayItem(this.owner);
}
