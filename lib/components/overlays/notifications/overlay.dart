import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/widgets/listener.dart';
import 'package:pangolin/components/overlays/notifications/widgets/wrapper.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/widgets/separated_flex.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';

class NotificationsOverlay extends ShellOverlay {
  static const String overlayId = "notifications";

  NotificationsOverlay({super.key}) : super(id: overlayId);

  @override
  ShellOverlayState<NotificationsOverlay> createState() =>
      _NotificationsOverlayState();
}

class _NotificationsOverlayState extends ShellOverlayState<NotificationsOverlay>
    with
        StateServiceListener<NotificationService, NotificationsOverlay>,
        NotificationServiceListener {
  final Map<int, NotificationWrapperData> notifications = {};

  @override
  void initState() {
    super.initState();
    for (final notification in NotificationService.current.notifications) {
      onNotificationAdded(notification);
    }
  }

  @override
  void dispose() {
    for (final int id in notifications.keys) {
      onNotificationRemoved(id, NotificationCloseReason.closed);
    }
    notifications.clear();

    super.dispose();
  }

  @override
  void onNotificationAdded(UserNotification notification) {
    final AnimationController animationController = _newController();
    notifications[notification.id] = NotificationWrapperData(
      notification: notification,
      controller: animationController,
    );

    if (controller.showing) {
      animationController.forward();
    } else {
      animationController.value = 1;
    }
  }

  @override
  Future<void> onNotificationRemoved(
    int id,
    NotificationCloseReason reason,
  ) async {
    final NotificationWrapperData? notif = notifications[id];

    if (notif == null) return;

    switch (reason) {
      case NotificationCloseReason.dismissed:
        await notif.controller.reverse();
      case NotificationCloseReason.closed:
      case NotificationCloseReason.expired:
      case NotificationCloseReason.unknown:
        notif.controller.value = 0;
    }

    notif.controller.dispose();
    notif.timer?.cancel();

    notifications.remove(id);
    setState(() {});
  }

  @override
  void onNotificationReplaced(int oldId, int id) {
    final NotificationWrapperData? notification = notifications[oldId];
    final UserNotification? newNotification = service.getNotification(id);

    if (newNotification == null || notification == null) return;

    notifications[id] = NotificationWrapperData(
      notification: newNotification,
      controller: notification.controller,
    );

    notifications.remove(oldId);
    setState(() {});
  }

  AnimationController _newController() => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    animationController.forward();
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    controller.showing = false;
    animationController.reverse();
  }

  Future<void> _dismissNotification(int id) async {
    final NotificationWrapperData? notif = notifications[id];

    if (notif == null) return;

    await notif.controller.reverse();
    onNotificationRemoved(id, NotificationCloseReason.dismissed);
  }

  @override
  Widget buildChild(BuildContext context, NotificationService service) {
    if (shouldHide) return const SizedBox();

    final EdgeInsets wmInsets = WindowHierarchy.of(context).wmInsets;

    return Positioned(
      right: wmInsets.right + 8,
      bottom: wmInsets.bottom + 8,
      width: 420,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: SeparatedFlex(
            separator: const SizedBox(height: 8),
            mainAxisSize: MainAxisSize.min,
            children: [
              _NotificationHeaderBar(service: service),
              if (notifications.isNotEmpty)
                ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: context.mSize.height * 2 / 3),
                  child: ClipPath(
                    clipper:
                        const ShapeBorderClipper(shape: Constants.mediumShape),
                    child: ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final NotificationWrapperData notification =
                            notifications.values
                                .toList()
                                .reversed
                                .toList()[index];

                        return NotificationViewWrapper(
                          notification: notification,
                          onClose: (id) async {
                            await _dismissNotification(id);
                            service.closeNotification(
                              id,
                              NotificationCloseReason.dismissed,
                            );
                          },
                          clipChild: true,
                        );
                      },
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationHeaderBar extends StatelessWidget {
  final NotificationService service;

  const _NotificationHeaderBar({required this.service});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Material(
        type: MaterialType.transparency,
        child: SurfaceLayer(
          shape: Constants.smallShape,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SeparatedFlex(
              axis: Axis.horizontal,
              separator: const Spacer(),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Notifications (${service.notifications.length})"),
                TextButton(
                  onPressed: service.notifications.isNotEmpty
                      ? _clearNotifications
                      : null,
                  child: const Text("Clear all"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _clearNotifications() async {
    final List<int> ids = List.from(service.notifications.map((e) => e.id));

    for (final int id in ids) {
      service.closeNotification(id, NotificationCloseReason.dismissed);
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }
}
