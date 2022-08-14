import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

mixin NotificationServiceListener<T extends StatefulWidget> on State<T> {
  NotificationService get service => NotificationService.current;

  late final StreamSubscription<NotificationServiceEvent> subscription;

  @override
  void initState() {
    super.initState();
    subscription = service.events.listen(_notificationEventListener);
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  void _notificationEventListener(NotificationServiceEvent event) {
    switch (event.type) {
      case NotificationEventType.show:
        final ShowNotificationEvent showEvent = event as ShowNotificationEvent;
        final UserNotification? notification =
            service.getNotification(showEvent.id);

        if (notification == null) return;

        onNotificationAdded(notification);
        break;
      case NotificationEventType.close:
        final CloseNotificationEvent closeEvent =
            event as CloseNotificationEvent;

        onNotificationRemoved(closeEvent.id, closeEvent.reason);

        setState(() {});
        break;
      case NotificationEventType.replace:
        final ReplaceNotificationEvent replaceEvent =
            event as ReplaceNotificationEvent;

        onNotificationReplaced(replaceEvent.oldId, replaceEvent.id);
        break;
      default:
        break;
    }
  }

  void onNotificationAdded(UserNotification id);
  void onNotificationRemoved(int id, NotificationCloseReason reason);
  void onNotificationReplaced(int oldId, int id);
}
