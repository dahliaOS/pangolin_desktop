import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/widgets.dart';
import 'package:pangolin/components/shell/shell.dart';

class ShellServiceFactory extends ServiceFactory<ShellService> {
  const ShellServiceFactory();

  @override
  ShellService build() => _ShellServiceImpl();
}

abstract class ShellService extends ListenableService {
  ShellService();

  static ShellService get current {
    return ServiceManager.getService<ShellService>()!;
  }

  void registerShell(ShellState shell, List<ShellOverlay> overlays);
  void onShellReadyCallback(void Function() callback);
  void notifyStartupComplete();

  Future<void> showOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
    bool dismissEverything = true,
  });

  Future<void> dismissOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  });

  Future<void> toggleOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  });

  bool currentlyShown(String overlayId);

  ValueNotifier<bool> getShowingNotifier(String overlayId);

  List<String> get currentlyShownOverlays;

  void dismissEverything();

  void showInformativeDialog(String title, String message);
}

class _ShellServiceImpl extends ShellService {
  late final List<ShellOverlay> overlays;
  ShellState? state;
  bool shellStarted = false;

  final List<void Function()> callbacks = [];

  @override
  void registerShell(ShellState shell, List<ShellOverlay> overlays) {
    if (state != null) throw Exception("Shell already registered");

    state = shell;
    this.overlays = overlays;
  }

  @override
  void onShellReadyCallback(void Function() callback) {
    if (shellStarted) {
      callback();
      return;
    }
    callbacks.add(callback);
  }

  @override
  void notifyStartupComplete() {
    if (shellStarted) throw Exception("Shell already started up and notified");

    shellStarted = true;
    for (final callback in callbacks) {
      callback();
    }
    callbacks.clear();
  }

  @override
  Future<void> showOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
    bool dismissEverything = true,
  }) async {
    final ShellOverlay overlay = overlays.firstWhere((o) => o.id == overlayId);
    if (dismissEverything) this.dismissEverything();
    await overlay._controller.requestShow(args);
  }

  @override
  Future<void> dismissOverlay(
    String overlayId, {
    Map<String, dynamic> args = const {},
  }) async {
    final ShellOverlay overlay = overlays.firstWhere((o) => o.id == overlayId);
    await overlay._controller.requestDismiss(args);
  }

  @override
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

  @override
  bool currentlyShown(String overlayId) {
    final ShellOverlay overlay = overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showing;
  }

  @override
  ValueNotifier<bool> getShowingNotifier(String overlayId) {
    final ShellOverlay overlay = overlays.firstWhere((o) => o.id == overlayId);
    return overlay._controller.showingNotifier;
  }

  @override
  List<String> get currentlyShownOverlays {
    final List<String> shownIds = [];
    for (final ShellOverlay o in overlays) {
      if (o._controller.showing) shownIds.add(o.id);
    }
    return shownIds;
  }

  @override
  void dismissEverything() {
    for (final String id in currentlyShownOverlays) {
      dismissOverlay(id);
    }
    state?.notify();
    notifyListeners();
  }

  @override
  void showInformativeDialog(String title, String message) =>
      state?.showInformativeDialog(title, message);

  @override
  FutureOr<void> start() {}

  @override
  FutureOr<void> stop() {
    overlays.clear();
    callbacks.clear();
    shellStarted = false;
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
