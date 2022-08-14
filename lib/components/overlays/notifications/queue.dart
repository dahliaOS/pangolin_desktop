import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/overlay.dart';
import 'package:pangolin/components/overlays/notifications/widgets/listener.dart';
import 'package:pangolin/components/overlays/notifications/widgets/wrapper.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pausable_timer/pausable_timer.dart';

class NotificationQueue extends StatefulWidget {
  const NotificationQueue({super.key});

  @override
  _NotificationQueueState createState() => _NotificationQueueState();
}

class _NotificationQueueState extends State<NotificationQueue>
    with TickerProviderStateMixin, NotificationServiceListener {
  final Map<int, NotificationWrapperData> incomingNotifications = {};
  bool listeningForShelf = false;

  @override
  void dispose() {
    for (final int id in incomingNotifications.keys) {
      onNotificationRemoved(id, NotificationCloseReason.closed);
    }
    incomingNotifications.clear();

    Shell.of(context, listen: false)
        .getShowingNotifier(NotificationsOverlay.overlayId)
        .removeListener(_dismissNotificationsOptionally);

    super.dispose();
  }

  @override
  void onNotificationAdded(UserNotification notification) {
    final ShellState shell = Shell.of(context, listen: false);
    final bool showingShelf =
        shell.currentlyShownOverlays.contains(NotificationsOverlay.overlayId);

    if (showingShelf) return;

    final AnimationController controller = _newController();
    final PausableTimer timer = _newTimer(notification.id);

    incomingNotifications[notification.id] = NotificationWrapperData.incoming(
      notification: notification,
      controller: controller,
      timer: timer,
    );

    setState(() {});
    controller.forward();
    timer.start();

    // kinda ugly but it seems to work so it's fine?
    if (incomingNotifications.length > 5) {
      final List<NotificationWrapperData> notifications =
          incomingNotifications.values.toList();
      final List<NotificationWrapperData> notifsToHide =
          notifications.sublist(0, notifications.length - 5);

      for (final NotificationWrapperData notif in notifsToHide) {
        _dismissNotification(notif.notification.id);
      }
    }
  }

  @override
  void onNotificationReplaced(int oldId, int id) {
    final ShellState shell = Shell.of(context, listen: false);
    final bool showingShelf =
        shell.currentlyShownOverlays.contains(NotificationsOverlay.overlayId);

    if (showingShelf) return;

    final NotificationWrapperData? notification = incomingNotifications[oldId];
    final UserNotification? newNotification = service.getNotification(id);

    if (newNotification == null) return;

    if (notification == null) {
      onNotificationAdded(newNotification);
      return;
    }

    incomingNotifications[id] = NotificationWrapperData.incoming(
      notification: newNotification,
      controller: notification.controller,
      timer: _newTimer(id),
    );

    setState(() {});
  }

  @override
  Future<void> onNotificationRemoved(
    int id,
    NotificationCloseReason reason,
  ) async {
    final NotificationWrapperData? notif = incomingNotifications[id];

    if (notif == null) return;

    switch (reason) {
      case NotificationCloseReason.dismissed:
        await notif.controller.reverse();
        break;
      case NotificationCloseReason.closed:
      case NotificationCloseReason.expired:
      case NotificationCloseReason.unknown:
        notif.controller.value = 0;
    }

    notif.controller.dispose();
    notif.timer?.cancel();

    incomingNotifications.remove(id);
  }

  Future<void> _dismissNotification(int id) async {
    final NotificationWrapperData? notif = incomingNotifications[id];

    if (notif == null) return;

    await notif.controller.reverse();
    onNotificationRemoved(id, NotificationCloseReason.dismissed);
  }

  void _dismissNotificationImmediately(int id) {
    final NotificationWrapperData? notif = incomingNotifications[id];

    if (notif == null) return;

    notif.controller.value = 0;
    onNotificationRemoved(id, NotificationCloseReason.closed);
  }

  AnimationController _newController() => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

  PausableTimer _newTimer(int id) => PausableTimer(
        const Duration(seconds: 5),
        () => _dismissNotification(id),
      );

  @override
  void didChangeDependencies() {
    if (listeningForShelf) return;

    final ShellState shell = Shell.of(context);
    shell
        .getShowingNotifier(NotificationsOverlay.overlayId)
        .addListener(_dismissNotificationsOptionally);

    listeningForShelf = true;

    super.didChangeDependencies();
  }

  void _dismissNotificationsOptionally() {
    final ShellState shell = Shell.of(context, listen: false);

    if (shell.currentlyShownOverlays.contains(NotificationsOverlay.overlayId)) {
      final List<int> ids = List.from(incomingNotifications.keys);
      ids.forEach(_dismissNotificationImmediately);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final NotificationWrapperData notification =
            incomingNotifications.values.toList()[index];

        return NotificationViewWrapper(
          notification: notification,
          onClose: (id) async {
            await _dismissNotification(id);
            service.closeNotification(id, NotificationCloseReason.dismissed);
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: incomingNotifications.length,
    );
  }
}
