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

import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/queue.dart';
import 'package:pangolin/components/taskbar/app_list.dart';
import 'package:pangolin/components/taskbar/launcher.dart';
import 'package:pangolin/components/taskbar/notifications.dart';
import 'package:pangolin/components/taskbar/overview.dart';
import 'package:pangolin/components/taskbar/quick_settings.dart';
import 'package:pangolin/components/taskbar/search.dart';
import 'package:pangolin/components/taskbar/show_desktop.dart';
import 'package:pangolin/components/taskbar/taskbar.dart';
import 'package:pangolin/components/taskbar/tray.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:provider/provider.dart';

typedef ShellShownCallback = void Function(ShellState shell);

class Shell extends StatefulWidget {
  final List<ShellOverlay> overlays;
  final ShellShownCallback? onShellShown;

  const Shell({
    required this.overlays,
    this.onShellShown,
    super.key,
  });

  @override
  ShellState createState() => ShellState();

  static ShellState of(BuildContext context, {bool listen = true}) {
    return Provider.of<ShellState>(context, listen: listen);
  }
}

class ShellState extends State<Shell> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onShellShown?.call(this);
    });
  }

  Future<void> showOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
    bool dismissEverything = true,
  }) async {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    if (dismissEverything) this.dismissEverything();
    await overlay._controller.requestShow(args);
  }

  Future<void> dismissOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  }) async {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    await overlay._controller.requestDismiss(args);
  }

  Future<void> toggleOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  }) async {
    if (!currentlyShown(overlayId)) {
      await showOverlay(overlayId, args: args);
    } else {
      await dismissOverlay(overlayId, args: args);
    }
  }

  bool currentlyShown(String overlayId) {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showing;
  }

  ValueNotifier<bool> getShowingNotifier(String overlayId) {
    final ShellOverlay overlay =
        widget.overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showingNotifier;
  }

  List<String> get currentlyShownOverlays {
    final List<String> shownIds = [];
    for (final ShellOverlay o in widget.overlays) {
      if (o._controller.showing) shownIds.add(o.id);
    }
    return shownIds;
  }

  void dismissEverything() {
    for (final String id in currentlyShownOverlays) {
      dismissOverlay(id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Listener(
                onPointerDown: (event) {
                  dismissEverything();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
            const Taskbar(
              leading: [
                LauncherButton(),
                SearchButton(),
                OverviewButton(),
              ],
              centerRelativeToScreen: true,
              center: [AppListElement()],
              trailing: [
                //TODO: here is the keyboard button
                //KeyboardButton(),
                TrayMenuButton(),
                QuickSettingsButton(),
                NotificationsButton(),
                ShowDesktopButton(),
              ],
            ),
            ...widget.overlays,
            Positioned(
              width: 420,
              right: WindowHierarchy.of(context).wmInsets.right + 8,
              bottom: WindowHierarchy.of(context).wmInsets.bottom + 8,
              child: const NotificationQueue(),
            ),
          ],
        ),
      ),
    );
  }
}

class ShellOverlayController<T extends ShellOverlayState> {
  T? _overlay;
  final ValueNotifier<bool> showingNotifier = ValueNotifier(false);

  bool get showing => showingNotifier.value;
  set showing(bool value) => showingNotifier.value = value;

  Future<void> requestShow(Map<String, dynamic> args) async {
    _requireOverlayConnection();
    await _overlay!.requestShow(args);
  }

  Future<void> requestDismiss(Map<String, dynamic> args) async {
    _requireOverlayConnection();
    await _overlay!.requestDismiss(args);
  }

  void _requireOverlayConnection() {
    if (_overlay == null) {
      throw Exception(
        "The controller is not connected to any overlay or it had no time to connect yet.",
      );
    }
  }
}

abstract class ShellOverlay extends StatefulWidget {
  final String id;
  final ShellOverlayController _controller = ShellOverlayController();

  ShellOverlay({
    required this.id,
    super.key,
  });

  @override
  ShellOverlayState createState();
}

abstract class ShellOverlayState<T extends ShellOverlay> extends State<T>
    with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Constants.animationDuration,
  );
  ShellOverlayController get controller => widget._controller;

  Animation<double> get animation => CurvedAnimation(
        parent: animationController,
        curve: Constants.animationCurve,
      );

  @override
  void initState() {
    controller._overlay = this;
    controller.showingNotifier.addListener(_showListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.showingNotifier.removeListener(_showListener);
    animationController.dispose();
    super.dispose();
  }

  FutureOr<void> requestShow(Map<String, dynamic> args);

  FutureOr<void> requestDismiss(Map<String, dynamic> args);

  void _showListener() {
    setState(() {});
  }

  bool get shouldHide => !controller.showing && animationController.value == 0;
}
