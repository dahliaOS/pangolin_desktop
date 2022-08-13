import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/other/log.dart';

abstract class NotificationService
    extends ListenableService<NotificationService> with LoggerProvider {
  NotificationService();

  static NotificationService get current {
    return ServiceManager.getService<NotificationService>()!;
  }

  static NotificationService build() {
    if (!Platform.isLinux) return _DummyNotificationService();

    return _DbusNotificationService();
  }

  factory NotificationService.fallback() = _DummyNotificationService;

  List<UserNotification> get notifications;
  Stream<NotificationServiceEvent> get events;

  void closeNotification(int id, NotificationCloseReason reason);
}

class _DbusNotificationService extends NotificationService {
  final DBusServer _server = DBusServer();
  final List<UserNotification> _notifications = [];
  final StreamController<NotificationServiceEvent> _controller =
      StreamController.broadcast();

  late _DBusNotificationBackend backend = _DBusNotificationBackend(this);

  DBusClient? _client;
  int _lastId = 0;

  @override
  List<UserNotification> get notifications => _notifications;

  @override
  Stream<NotificationServiceEvent> get events => _controller.stream;

  @override
  void closeNotification(int id, NotificationCloseReason reason) {
    final UserNotification? notif =
        _notifications.firstWhereOrNull((e) => e.id == id);

    if (notif == null) return;

    notif.sendClose(reason);
    _notifications.remove(notif);
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

  void addNotification(UserNotification notification) {
    _notifications.add(notification);
    notifyListeners();
    _sendEvent(ShowNotificationEvent(id: notification.id));
  }

  bool replaceNotification(int replaces, UserNotification notification) {
    final int indexOf = _notifications.indexWhere((e) => e.id == replaces);

    if (indexOf == -1) {
      logger.warning(
        "Tried replacing a non existing notification $replaces",
      );
      return false;
    }

    _notifications[indexOf] = notification;
    notifyListeners();
    _sendEvent(ReplaceNotificationEvent(oldId: replaces, id: notification.id));

    return true;
  }

  void removeNotification(int id, NotificationCloseReason reason) {
    _notifications.removeWhere((e) => e.id == id);
    notifyListeners();
    _sendEvent(CloseNotificationEvent(id: id, reason: reason));
  }

  Future<bool> _registerClient(DBusClient client) async {
    try {
      await client.requestName(
        'org.freedesktop.Notifications',
        flags: {
          DBusRequestNameFlag.allowReplacement,
          DBusRequestNameFlag.replaceExisting,
        },
      );
      await client.registerObject(backend);
      _client = client;
      return true;
    } catch (e) {
      logger.warning(
        "Could not register client $client for notification service, unregistering",
      );
      if (backend.client != null) {
        await client.unregisterObject(backend);
      }
      await client.releaseName("org.freedesktop.Notifications");
      await client.close();
      _client = null;
      return false;
    }
  }

  int getId() => _lastId += 1;

  @override
  Future<void> stop() async {
    await _server.close();
    if (backend.client != null) {
      await _client?.unregisterObject(backend);
    }
    await _client?.releaseName("org.freedesktop.Notifications");
    await _client?.close();
    _client = null;
  }

  void _sendEvent(NotificationServiceEvent event) {
    _controller.add(event);
  }
}

class _DummyNotificationService extends NotificationService {
  @override
  List<UserNotification> get notifications => [];

  @override
  Stream<NotificationServiceEvent> get events => const Stream.empty();

  @override
  void closeNotification(int id, NotificationCloseReason reason) {
    // living the stub life
  }

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

class _DBusNotificationBackend extends DBusObject {
  final _DbusNotificationService service;

  _DBusNotificationBackend(this.service)
      : super(DBusObjectPath('/org/freedesktop/Notifications'));

  @override
  List<DBusIntrospectInterface> introspect() {
    return [
      DBusIntrospectInterface(
        'org.freedesktop.Notifications',
        methods: [
          DBusIntrospectMethod(
            'GetServerInformation',
            args: [
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'name',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'vendor',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'version',
              ),
              DBusIntrospectArgument(
                DBusSignature('s'),
                DBusArgumentDirection.out,
                name: 'specVersion',
              ),
            ],
          ),
          DBusIntrospectMethod(
            'GetCapabilities',
            args: [
              DBusIntrospectArgument(
                DBusSignature("as"),
                DBusArgumentDirection.out,
                name: 'capabilities',
              ),
            ],
          ),
          DBusIntrospectMethod(
            'CloseNotification',
            args: [
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.in_,
                name: 'notificationId',
              ),
            ],
          ),
          DBusIntrospectMethod(
            'Notify',
            args: [
              DBusIntrospectArgument(
                DBusSignature("s"),
                DBusArgumentDirection.in_,
                name: 'appName',
              ),
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.in_,
                name: 'replacesId',
              ),
              DBusIntrospectArgument(
                DBusSignature("s"),
                DBusArgumentDirection.in_,
                name: 'appIcon',
              ),
              DBusIntrospectArgument(
                DBusSignature("s"),
                DBusArgumentDirection.in_,
                name: 'summary',
              ),
              DBusIntrospectArgument(
                DBusSignature("s"),
                DBusArgumentDirection.in_,
                name: 'body',
              ),
              DBusIntrospectArgument(
                DBusSignature("as"),
                DBusArgumentDirection.in_,
                name: 'actions',
              ),
              DBusIntrospectArgument(
                DBusSignature("a{sv}"),
                DBusArgumentDirection.in_,
                name: 'hints',
              ),
              DBusIntrospectArgument(
                DBusSignature("i"),
                DBusArgumentDirection.in_,
                name: 'timeoutMs',
              ),
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.out,
                name: 'notificationId',
              ),
            ],
          ),
        ],
        signals: [
          DBusIntrospectSignal(
            'NotificationClosed',
            args: [
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.out,
                name: 'notificationId',
              ),
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.out,
                name: 'reason',
              ),
            ],
          ),
          DBusIntrospectSignal(
            'ActionInvoked',
            args: [
              DBusIntrospectArgument(
                DBusSignature("u"),
                DBusArgumentDirection.out,
                name: 'notificationId',
              ),
              DBusIntrospectArgument(
                DBusSignature("s"),
                DBusArgumentDirection.out,
                name: 'action',
              ),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall methodCall) async {
    switch (methodCall.name) {
      case 'GetServerInformation':
        return DBusMethodSuccessResponse([
          const DBusString("pangolin"),
          const DBusString("dahliaOS"),
          const DBusString("1.0"),
          const DBusString("1.2"),
        ]);
      case 'GetCapabilities':
        return DBusMethodSuccessResponse([
          DBusArray.string([
            "actions",
            "body",
            "body-hyperlinks",
            "body-markup",
            "icon-static",
            "persistence",
          ]),
        ]);
      case 'Notify':
        if (methodCall.signature != DBusSignature("susssasa{sv}i")) {
          return DBusMethodErrorResponse.invalidArgs();
        }

        final int id = service.getId();
        final String appName = methodCall.values[0].asString();
        final int replacesId = methodCall.values[1].asUint32();
        final String appIcon = methodCall.values[2].asString();
        final String summary = methodCall.values[3].asString();
        final String body = methodCall.values[4].asString();
        final List<DBusValue> actions = methodCall.values[5].asArray();
        final Map<String, DBusValue> hints =
            methodCall.values[6].asStringVariantDict();
        final int expireTimeout = methodCall.values[7].asInt32();

        final UserNotification notification = UserNotification(
          owner: this,
          id: id,
          appName: appName,
          appIcon: appIcon.isNotEmpty ? appIcon : null,
          summary: summary,
          body: body,
          actions: _parseReceivedActions(actions),
          expireTimeout: expireTimeout,
          image: _getImage(hints),
        );

        if (replacesId > 0) {
          final bool replaced =
              service.replaceNotification(replacesId, notification);

          if (!replaced) service.addNotification(notification);
        } else {
          service.addNotification(notification);
        }

        return DBusMethodSuccessResponse([DBusUint32(id)]);
      case 'CloseNotification':
        if (methodCall.signature != DBusSignature("u")) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        final DBusUint32 id = methodCall.values[0] as DBusUint32;
        service.closeNotification(
          id.value,
          NotificationCloseReason.closed,
        );

        return DBusMethodSuccessResponse([]);
    }

    return DBusMethodErrorResponse.unknownMethod();
  }

  DBusImage? _getImage(Map<String, DBusValue> hints) {
    DBusImage? image;

    image ??= _getRawImage(hints["image-data"]);
    image ??= _getRawImage(hints["image_data"]);
    image ??= _getPathImage(hints["image-path"]);
    image ??= _getPathImage(hints["image_path"]);
    image ??= _getRawImage(hints["icon_data"]);

    return image;
  }

  RawDBusImage? _getRawImage(DBusValue? data) {
    if (data == null) return null;

    if (data.signature != DBusSignature("(iiibiiay)")) {
      return null;
    }

    final List<DBusValue> struct = data.asStruct();

    final int width = struct[0].asInt32();
    final int height = struct[1].asInt32();
    final int rowStride = struct[2].asInt32();
    final bool hasAlpha = struct[3].asBoolean();
    final Uint8List bytes =
        Uint8List.fromList(struct[6].asByteArray().toList());

    return RawDBusImage(
      width: width,
      height: height,
      rowStride: rowStride,
      hasAlpha: hasAlpha,
      bytes: bytes,
    );
  }

  NameDBusImage? _getPathImage(DBusValue? data) {
    if (data == null) return null;

    if (data.signature != DBusSignature.string) {
      return null;
    }

    return NameDBusImage(data.asString());
  }

  List<NotificationAction> _parseReceivedActions(List<DBusValue> array) {
    if (array.length % 2 != 0) {
      throw DBusMethodErrorResponse.invalidArgs();
    }
    final List<String> stringActions =
        array.map((e) => (e as DBusString).value).toList();

    final List<NotificationAction> actions = [];
    for (int i = 0; i < stringActions.length; i += 2) {
      actions.add(NotificationAction(stringActions[i], stringActions[i + 1]));
    }

    return actions;
  }
}

class UserNotification {
  final DBusObject owner;
  final int id;
  final String appName;
  final String? appIcon;
  final String summary;
  final String body;
  final List<NotificationAction> actions;
  final int expireTimeout;
  final DBusImage? image;

  const UserNotification({
    required this.owner,
    required this.id,
    required this.appName,
    required this.appIcon,
    required this.summary,
    required this.body,
    required this.actions,
    required this.expireTimeout,
    required this.image,
  });

  void sendClose(NotificationCloseReason reason) {
    owner.emitSignal(
      'org.freedesktop.Notifications',
      'NotificationClosed',
      [DBusUint32(id), DBusUint32(reason.index + 1)],
    );
  }

  void invokeAction(String action) {
    owner.emitSignal(
      'org.freedesktop.Notifications',
      'ActionInvoked',
      [DBusUint32(id), DBusString(action)],
    );
  }
}

class NotificationAction {
  final String key;
  final String label;

  const NotificationAction(this.key, this.label);

  @override
  int get hashCode => Object.hash(key, label);

  @override
  bool operator ==(Object other) {
    if (other is NotificationAction) {
      return key == other.key && label == other.label;
    }
    return true;
  }
}

enum NotificationCloseReason {
  expired,
  dismissed,
  closed,
  unknown,
}

abstract class NotificationServiceEvent {
  final int id;
  final NotificationEventType type;

  const NotificationServiceEvent({
    required this.id,
    required this.type,
  });
}

class ShowNotificationEvent extends NotificationServiceEvent {
  const ShowNotificationEvent({required super.id})
      : super(type: NotificationEventType.show);
}

class ReplaceNotificationEvent extends NotificationServiceEvent {
  final int oldId;

  const ReplaceNotificationEvent({required this.oldId, required super.id})
      : super(type: NotificationEventType.replace);
}

class CloseNotificationEvent extends NotificationServiceEvent {
  final NotificationCloseReason reason;

  const CloseNotificationEvent({
    required super.id,
    required this.reason,
  }) : super(type: NotificationEventType.close);
}

enum NotificationEventType {
  show,
  replace,
  close,
}
