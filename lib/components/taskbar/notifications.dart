/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/overlay.dart';
import 'package:pangolin/components/overlays/notifications/widgets/listener.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/services/shell.dart';
import 'package:zenit_ui/zenit_ui.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskbarElement(
      shrinkWrap: true,
      height: 40.0,
      overlayID: NotificationsOverlay.overlayId,
      child: _NotificationIcon(),
    );
  }
}

class _NotificationIcon extends StatefulWidget {
  const _NotificationIcon();

  @override
  State<_NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<_NotificationIcon>
    with
        NotificationServiceListener,
        StateServiceListener<NotificationService, _NotificationIcon> {
  bool _shellListenerInit = false;
  bool _unreadNotifs = false;

  ValueNotifier<bool> get notifier =>
      ShellService.current.getShowingNotifier(NotificationsOverlay.overlayId);

  @override
  void initState() {
    super.initState();
    _unreadNotifs = NotificationService.current.notifications.isNotEmpty;
  }

  @override
  void didChangeDependencies() {
    if (!_shellListenerInit) {
      _shellListenerInit = true;
      notifier.addListener(_resetIndicator);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    notifier.removeListener(_resetIndicator);
    super.dispose();
  }

  void _resetIndicator() {
    _unreadNotifs = false;
    setState(() {});
  }

  @override
  Widget buildChild(BuildContext context, NotificationService service) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 20, maxHeight: 20),
          child: ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, showing, _) {
              return service.notifications.isNotEmpty
                  ? Material(
                      color: _unreadNotifs
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).surfaceColor,
                      type: showing
                          ? MaterialType.transparency
                          : MaterialType.canvas,
                      shape: Constants.circularShape,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            service.notifications.length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: _unreadNotifs || showing
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.notifications,
                      size: 18,
                    );
            },
          ),
        ),
      ),
    );
  }

  @override
  void onNotificationAdded(UserNotification notification) {
    _unreadNotifs = true;
    setState(() {});
  }

  @override
  void onNotificationRemoved(int id, NotificationCloseReason reason) {}

  @override
  void onNotificationReplaced(int oldId, int id) {}
}
