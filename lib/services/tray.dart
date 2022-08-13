import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:pangolin/services/dbus.dart';
import 'package:pangolin/services/dbus/objects/remote/status_item.dart';
import 'package:pangolin/services/dbus/objects/status_watcher.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/services/service.dart';

abstract class TrayService extends ListenableService<TrayService> {
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

class _DbusTrayService extends TrayService with DBusService {
  final List<StatusNotifierItem> _items = [];

  @override
  late final _DBusTrayBackend backend = _DBusTrayBackend(this);

  List<String> get _dbusItems =>
      _items.map((e) => '${e.object.name}${e.object.path.value}').toList();

  StreamSubscription? _nameSubscription;

  @override
  List<StatusNotifierItem> get items => List.from(_items);

  Future<void> registerItem(String name, String path) async {
    final StatusNotifierItemObject object =
        StatusNotifierItemObject(client!, name, DBusObjectPath(path));

    final StatusNotifierItem item = await StatusNotifierItem.fromObject(object);
    _items.add(item);
    backend.emitStatusNotifierItemRegistered("$name$path");
    backend.emitPropertiesChanged(
      backend.interface,
      changedProperties: {
        'RegisteredStatusNotifierItems': DBusArray.string(_dbusItems),
      },
    );
    logger.info("Registered tray item $name$path");
    notifyListeners();
  }

  void unregisterItem(StatusNotifierItem item) {
    _items.remove(item);
    backend.emitStatusNotifierItemUnregistered(
      "${item.object.name}${item.object.path.value}",
    );
    logger.info(
      "Unregistered tray item ${item.object.name}${item.object.path}",
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
  FutureOr<void> onClientRegistered() {
    _nameSubscription = client!.nameOwnerChanged.listen(_nameOwnerChanged);
    backend.emitStatusNotifierHostRegistered();
    backend.emitPropertiesChanged(
      backend.interface,
      changedProperties: {
        'IsStatusNotifierHostRegistered': const DBusBoolean(true),
        'ProtocolVersion': const DBusInt32(0),
        'RegisteredStatusNotifierItems': DBusArray.string([]),
      },
    );
  }

  @override
  FutureOr<void> onClientUnregistering() {
    backend.emitStatusNotifierHostUnregistered();
    _nameSubscription?.cancel();
    _nameSubscription = null;
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

class _DBusTrayBackend extends StatusNotifierWatcherBase
    with DBusServiceBackend {
  @override
  String interface = "org.kde.StatusNotifierWatcher";

  final _DbusTrayService service;

  _DBusTrayBackend(this.service)
      : super(path: DBusObjectPath('/StatusNotifierWatcher'));

  @override
  Future<DBusMethodResponse> doRegisterStatusNotifierItem(
    String sender,
    String service,
  ) async {
    final String serviceValue = service;

    final String name;
    final String path;

    if (serviceValue.startsWith("/")) {
      name = sender;
      path = serviceValue;
    } else {
      name = serviceValue;
      path = "/StatusNotifierItem";
    }

    this.service.registerItem(name, path);

    return DBusMethodSuccessResponse();
  }

  @override
  Future<DBusMethodResponse> doRegisterStatusNotifierHost(
    String service,
  ) async {
    // We don't actually do anything
    return DBusMethodSuccessResponse();
  }

  @override
  Future<DBusMethodResponse> getIsStatusNotifierHostRegistered() async {
    return DBusMethodSuccessResponse([const DBusBoolean(true)]);
  }

  @override
  Future<DBusMethodResponse> getProtocolVersion() async {
    return DBusMethodSuccessResponse([const DBusInt32(0)]);
  }

  @override
  Future<DBusMethodResponse> getRegisteredStatusNotifierItems() async {
    return DBusMethodSuccessResponse([DBusArray.string(service._dbusItems)]);
  }
}

class SystemTrayItem {
  final DBusRemoteObject owner;

  const SystemTrayItem(this.owner);
}
