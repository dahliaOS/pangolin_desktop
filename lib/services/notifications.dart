import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';
import 'package:pangolin/services/dbus.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/objects/notifications.dart';

class NotificationServiceFactory extends ServiceFactory<NotificationService> {
  const NotificationServiceFactory();

  @override
  NotificationService build() {
    if (!Platform.isLinux) return _DummyNotificationService();

    return _DbusNotificationService();
  }

  @override
  NotificationService? fallback() => _DummyNotificationService();
}

abstract class NotificationService extends ListenableService {
  NotificationService();

  static NotificationService get current {
    return ServiceManager.getService<NotificationService>()!;
  }

  List<UserNotification> get notifications;
  Stream<NotificationServiceEvent> get events;

  void pushNotification(ShellNotification notification);
  void closeNotification(int id, NotificationCloseReason reason);
}

class _DbusNotificationService extends NotificationService
    with DBusService<NotificationService> {
  final List<UserNotification> _notifications = [];
  final StreamController<NotificationServiceEvent> _controller =
      StreamController.broadcast();

  @override
  late final _DBusNotificationBackend backend = _DBusNotificationBackend(this);

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
    _sendEvent(CloseNotificationEvent(id: id, reason: reason));
    notifyListeners();
  }

  @override
  Set<DBusRequestNameFlag> get nameFlags => {
        DBusRequestNameFlag.allowReplacement,
        DBusRequestNameFlag.replaceExisting,
      };

  @override
  void pushNotification(ShellNotification notification) {
    if (notification.id >= 0) {
      replaceNotification(notification.id, notification);
    } else {
      addNotification(notification.copyWith(id: getId()));
    }
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

  int getId() => _lastId += 1;

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
  void pushNotification(ShellNotification notification) {
    // living the stub life
  }

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

class _DBusNotificationBackend extends NotificationsBase
    with DBusServiceBackend {
  final _DbusNotificationService service;

  _DBusNotificationBackend(this.service)
      : super(path: DBusObjectPath('/org/freedesktop/Notifications'));

  @override
  Future<DBusMethodResponse> doGetServerInformation() async {
    return DBusMethodSuccessResponse([
      const DBusString("pangolin"),
      const DBusString("dahliaOS"),
      const DBusString("1.0"),
      const DBusString("1.2"),
    ]);
  }

  @override
  Future<DBusMethodResponse> doGetCapabilities() async {
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
  }

  @override
  Future<DBusMethodResponse> doNotify(
    String appName,
    int replaces,
    String icon,
    String summary,
    String body,
    List<String> actions,
    Map<String, DBusValue> hints,
    int timeout,
  ) async {
    final int id = service.getId();

    final UserNotification notification = UserNotification(
      owner: this,
      id: id,
      appName: appName,
      appIcon: icon.isNotEmpty ? icon : null,
      summary: summary,
      body: body,
      actions: _parseReceivedActions(actions),
      expireTimeout: timeout,
      image: _getImage(hints),
    );

    if (replaces > 0) {
      final bool replaced = service.replaceNotification(replaces, notification);

      if (!replaced) service.addNotification(notification);
    } else {
      service.addNotification(notification);
    }

    return DBusMethodSuccessResponse([DBusUint32(id)]);
  }

  @override
  Future<DBusMethodResponse> doCloseNotification(int id) async {
    service.closeNotification(id, NotificationCloseReason.closed);

    return DBusMethodSuccessResponse([]);
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

  List<NotificationAction> _parseReceivedActions(List<String> array) {
    if (array.length % 2 != 0) {
      throw DBusMethodErrorResponse.invalidArgs();
    }

    final List<NotificationAction> actions = [];
    for (int i = 0; i < array.length; i += 2) {
      actions.add(NotificationAction(array[i], array[i + 1]));
    }

    return actions;
  }

  @override
  String get interface => 'org.freedesktop.Notifications';
}

class UserNotification {
  final DBusObject? owner;
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
    owner?.emitSignal(
      'org.freedesktop.Notifications',
      'NotificationClosed',
      [DBusUint32(id), DBusUint32(reason.index + 1)],
    );
  }

  bool invokeAction(String action) {
    owner?.emitSignal(
      'org.freedesktop.Notifications',
      'ActionInvoked',
      [DBusUint32(id), DBusString(action)],
    );
    return true;
  }

  UserNotification copyWith({
    DBusObject? owner,
    int? id,
    String? appName,
    String? appIcon,
    String? summary,
    String? body,
    List<NotificationAction>? actions,
    int? expireTimeout,
    DBusImage? image,
  }) {
    return UserNotification(
      owner: owner ?? this.owner,
      id: id ?? this.id,
      appName: appName ?? this.appName,
      appIcon: appIcon ?? this.appIcon,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      actions: actions ?? this.actions,
      expireTimeout: expireTimeout ?? this.expireTimeout,
      image: image ?? this.image,
    );
  }
}

typedef OnNotificationCloseCallback = void Function(
  NotificationCloseReason reason,
);
typedef OnNotificationActionCallback = void Function(String action);

class ShellNotification extends UserNotification {
  final OnNotificationCloseCallback? onClose;
  final OnNotificationActionCallback? onAction;

  ShellNotification({
    super.id = -1,
    super.appName = "",
    super.appIcon,
    super.summary = "",
    super.body = "",
    super.actions = const [],
    super.expireTimeout = -1,
    super.image,
    this.onClose,
    this.onAction,
  }) : super(owner: null);

  @override
  void sendClose(NotificationCloseReason reason) {
    onClose?.call(reason);
  }

  @override
  bool invokeAction(String action) {
    onAction?.call(action);
    return false;
  }

  @override
  ShellNotification copyWith({
    DBusObject? owner,
    int? id,
    String? appName,
    String? appIcon,
    String? summary,
    String? body,
    List<NotificationAction>? actions,
    int? expireTimeout,
    DBusImage? image,
    OnNotificationCloseCallback? onClose,
    OnNotificationActionCallback? onAction,
  }) {
    return ShellNotification(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      appIcon: appIcon ?? this.appIcon,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      actions: actions ?? this.actions,
      expireTimeout: expireTimeout ?? this.expireTimeout,
      image: image ?? this.image,
      onClose: onClose ?? this.onClose,
      onAction: onAction ?? this.onAction,
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

sealed class NotificationServiceEvent {
  final int id;

  const NotificationServiceEvent({required this.id});
}

class ShowNotificationEvent extends NotificationServiceEvent {
  const ShowNotificationEvent({required super.id});
}

class ReplaceNotificationEvent extends NotificationServiceEvent {
  final int oldId;

  const ReplaceNotificationEvent({required this.oldId, required super.id});
}

class CloseNotificationEvent extends NotificationServiceEvent {
  final NotificationCloseReason reason;

  const CloseNotificationEvent({required super.id, required this.reason});
}
