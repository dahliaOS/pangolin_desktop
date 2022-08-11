import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/widgets/notification.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pausable_timer/pausable_timer.dart';

class NotificationQueue extends StatefulWidget {
  const NotificationQueue({super.key});

  @override
  _NotificationQueueState createState() => _NotificationQueueState();
}

class _NotificationQueueState extends State<NotificationQueue>
    with TickerProviderStateMixin {
  NotificationService get service => NotificationService.current;

  final Map<int, _IncomingNotification> incomingNotifications = {};
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = service.events.listen(_notificationEventListener);
  }

  @override
  void dispose() {
    subscription.cancel();
    for (final int id in incomingNotifications.keys) {
      _clearNotif(id);
    }
    incomingNotifications.clear();

    super.dispose();
  }

  void _notificationEventListener(NotificationServiceEvent event) {
    switch (event.type) {
      case NotificationEventType.show:
        final ShowNotificationEvent showEvent = event as ShowNotificationEvent;
        final UserNotification? notification =
            service.getNotification(showEvent.id);

        if (notification == null) return;

        _addNotif(notification);
        break;
      case NotificationEventType.close:
        final CloseNotificationEvent closeEvent =
            event as CloseNotificationEvent;

        _clearNotif(closeEvent.id);

        setState(() {});
        break;
      case NotificationEventType.replace:
        final ReplaceNotificationEvent replaceEvent =
            event as ReplaceNotificationEvent;

        _replaceNotif(replaceEvent.oldId, replaceEvent.id);
        break;
      default:
        break;
    }
  }

  void _addNotif(UserNotification notification) {
    final AnimationController controller = _newController();
    final PausableTimer timer = _newTimer(notification.id);

    incomingNotifications[notification.id] = _IncomingNotification(
      notification: notification,
      controller: controller,
      timer: timer,
    );

    setState(() {});
    controller.forward();
    timer.start();

    // kinda ugly but it seems to work so it's fine?
    if (incomingNotifications.length > 5) {
      final List<_IncomingNotification> notifications =
          incomingNotifications.values.toList();
      final List<_IncomingNotification> notifsToHide =
          notifications.sublist(0, notifications.length - 5);

      for (final _IncomingNotification notif in notifsToHide) {
        _dismissNotification(notif.notification.id);
      }
    }
  }

  void _replaceNotif(int oldId, int id) {
    final _IncomingNotification? notification = incomingNotifications[oldId];
    final UserNotification? newNotification = service.getNotification(id);

    if (newNotification == null) {
      return;
    }

    if (notification == null) {
      _addNotif(newNotification);
      return;
    }

    incomingNotifications[id] = _IncomingNotification(
      notification: newNotification,
      controller: notification.controller,
      timer: _newTimer(id),
    );

    setState(() {});
  }

  void _clearNotif(int id) {
    final _IncomingNotification? notif = incomingNotifications[id];

    if (notif == null) return;

    notif.controller.dispose();
    notif.timer.cancel();

    incomingNotifications.remove(id);
  }

  Future<void> _dismissNotification(int id) async {
    final _IncomingNotification? notif = incomingNotifications[id];

    if (notif == null) return;

    await notif.controller.reverse();
    _clearNotif(id);
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
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final _IncomingNotification notification =
            incomingNotifications.values.toList()[index];

        return _NotificationWrapper(
          notification: notification.notification,
          animation: notification.controller,
          onClose: (id) async {
            await _dismissNotification(id);
            service.closeNotification(id, NotificationCloseReason.dismissed);
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: incomingNotifications.length,
    );
  }
}

class _NotificationWrapper extends StatelessWidget {
  final UserNotification notification;
  final Animation<double> animation;
  final ValueChanged<int>? onClose;

  const _NotificationWrapper({
    required this.notification,
    required this.animation,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutQuad,
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        return Visibility(
          visible: curved.value > 0,
          child: child!,
        );
      },
      child: FadeTransition(
        opacity: curved,
        child: SizeTransitionWithBehavior(
          sizeFactor: curved,
          clipBehavior: Clip.none,
          axisAlignment: 1,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curved),
            child: NotificationView(
              key: ValueKey(notification.hashCode),
              notification: notification,
              onClose: onClose,
            ),
          ),
        ),
      ),
    );
  }
}

class SizeTransitionWithBehavior extends AnimatedWidget {
  final Axis axis;
  Animation<double> get sizeFactor => listenable as Animation<double>;
  final double axisAlignment;
  final Clip clipBehavior;
  final Widget? child;

  const SizeTransitionWithBehavior({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.clipBehavior = Clip.hardEdge,
    this.child,
  }) : super(listenable: sizeFactor);

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }
    return ClipRect(
      clipBehavior: clipBehavior,
      child: Align(
        alignment: alignment,
        heightFactor: axis == Axis.vertical ? max(sizeFactor.value, 0.0) : null,
        widthFactor:
            axis == Axis.horizontal ? max(sizeFactor.value, 0.0) : null,
        child: child,
      ),
    );
  }
}

class _IncomingNotification {
  final UserNotification notification;
  final AnimationController controller;
  final PausableTimer timer;

  const _IncomingNotification({
    required this.notification,
    required this.controller,
    required this.timer,
  });
}
