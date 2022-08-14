import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/dbus/image.dart';
import 'package:pangolin/widgets/global/markup.dart';
import 'package:pangolin/widgets/global/separated_flex.dart';

class NotificationView extends StatelessWidget {
  final UserNotification notification;
  final ValueChanged<int>? onClose;

  const NotificationView({
    required this.notification,
    this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NotificationAction? defaultAction =
        notification.actions.firstWhereOrNull((e) => e.key == "default");
    final List<NotificationAction> actions = List.from(notification.actions)
      ..remove(defaultAction);

    return Material(
      type: MaterialType.transparency,
      shape: Constants.mediumShape,
      clipBehavior: Clip.antiAlias,
      child: SeparatedFlex(
        separator: const SizedBox(height: 2),
        children: [
          _NotificationBody(notification: notification, onClose: onClose),
          if (actions.isNotEmpty)
            SeparatedFlex(
              axis: Axis.horizontal,
              separator: const SizedBox(width: 2),
              children: actions
                  .map(
                    (e) => Expanded(
                      child: _NotificationActionButton(
                        notification: notification,
                        action: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _NotificationBody extends StatelessWidget {
  final UserNotification notification;
  final ValueChanged<int>? onClose;

  const _NotificationBody({
    required this.notification,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return BoxSurface(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            if (!notification.actions.any((e) => e.key == "default")) return;
            notification.invokeAction("default");
            NotificationService.current.closeNotification(
              notification.id,
              NotificationCloseReason.closed,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SeparatedFlex(
              axis: Axis.horizontal,
              separator: const SizedBox(width: 12),
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration:
                      const ShapeDecoration(shape: Constants.smallShape),
                  clipBehavior: Clip.antiAlias,
                  child: DBusImageWidget(
                    image: notification.image ??
                        notification.appImage ??
                        const IconDataDBusImage(
                          Icons.notifications_active,
                        ),
                    width: 56,
                    height: 56,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeparatedFlex(
                            axis: Axis.horizontal,
                            separator: const SizedBox(width: 4),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (notification.image != null &&
                                  notification.appImage != null)
                                DBusImageWidget(
                                  image: notification.appImage!,
                                  width: 16,
                                  height: 16,
                                ),
                              Text(
                                notification.appName,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SeparatedFlex(
                            separator: const SizedBox(height: 2),
                            children: [
                              Text(
                                notification.summary,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (notification.body.trim().isNotEmpty)
                                MarkupText(
                                  notification.body,
                                  style: const TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                      onClose != null ? () => onClose!(notification.id) : null,
                  icon: const Icon(Icons.close),
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tight(const Size.square(32)),
                  splashRadius: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationActionButton extends StatelessWidget {
  final UserNotification notification;
  final NotificationAction action;

  const _NotificationActionButton({
    required this.notification,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BoxSurface(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            notification.invokeAction(action.key);
            NotificationService.current.closeNotification(
              notification.id,
              NotificationCloseReason.closed,
            );
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                action.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on UserNotification {
  DBusImage? get appImage => appIcon != null ? NameDBusImage(appIcon!) : null;
}
