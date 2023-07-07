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
    switch (event) {
      case ShowNotificationEvent(id: final id):
        final UserNotification? notification = service.getNotification(id);

        if (notification == null) return;

        onNotificationAdded(notification);
      case CloseNotificationEvent(id: final id, reason: final reason):
        onNotificationRemoved(id, reason);

        setState(() {});
      case ReplaceNotificationEvent(id: final id, oldId: final oldId):
        onNotificationReplaced(oldId, id);
      default:
        break;
    }
  }

  void onNotificationAdded(UserNotification notification);
  void onNotificationRemoved(int id, NotificationCloseReason reason);
  void onNotificationReplaced(int oldId, int id);
}
