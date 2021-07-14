import 'dart:async';

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/desktop/taskbar/clock.dart';
import 'package:pangolin/desktop/taskbar/launcher.dart';
import 'package:pangolin/desktop/taskbar/overview.dart';
import 'package:pangolin/desktop/taskbar/quick_settings.dart';
import 'package:pangolin/desktop/taskbar/search.dart';
import 'package:pangolin/desktop/taskbar/taskbar.dart';
import 'package:provider/provider.dart';

class Shell extends StatefulWidget {
  final List<ShellOverlay> overlays;

  const Shell({required this.overlays});

  @override
  _ShellState createState() => _ShellState();

  static _ShellState of(BuildContext context, {bool listen: true}) {
    return Provider.of<_ShellState>(context, listen: listen);
  }
}

class _ShellState extends State<Shell> {
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
    widget.overlays.forEach((o) {
      if (o._controller.showing) shownIds.add(o.id);
    });
    return shownIds;
  }

  void dismissEverything() {
    currentlyShownOverlays.forEach((id) => dismissOverlay(id));
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
            Taskbar(
              leading: [
                LauncherButton(),
                SearchButton(),
                OverviewButton(),
              ],
              trailing: [
                //TODO: here is the keyboard button
                //KeyboardButton(),
                QuickSettingsButton(),
                DateClockWidget(),
              ],
            ),
            ...widget.overlays,
            Positioned.fill(
              child: Listener(
                onPointerDown: (event) {
                  WindowHierarchy.of(context, listen: false)
                      .removeFromStableId("shell:context_menu");
                },
                behavior: HitTestBehavior.translucent,
              ),
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
    Key? key,
  }) : super(key: key);

  @override
  ShellOverlayState createState();
}

mixin ShellOverlayState<T extends ShellOverlay> on State<T> {
  ShellOverlayController get controller => widget._controller;

  @override
  void initState() {
    controller._overlay = this;
    controller.showingNotifier.addListener(_showListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.showingNotifier.removeListener(_showListener);
    super.dispose();
  }

  FutureOr<void> requestShow(Map<String, dynamic> args);

  FutureOr<void> requestDismiss(Map<String, dynamic> args);

  void _showListener() {
    setState(() {});
  }
}
