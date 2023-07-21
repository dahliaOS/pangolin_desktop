import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:utopia_wm/wm.dart';

class WindowManagerServiceFactory extends ServiceFactory<WindowManagerService> {
  const WindowManagerServiceFactory();

  @override
  WindowManagerService build() {
    return _WindowManagerServiceImpl();
  }
}

abstract class WindowManagerService extends Service {
  WindowManagerService();

  static WindowManagerService get current {
    return ServiceManager.getService<WindowManagerService>()!;
  }

  WindowHierarchyController get controller;

  void push(LiveWindowEntry entry);
  void pop(String id);

  void minimizeEverything();
  void unminimizeEverything();
}

class _WindowManagerServiceImpl extends WindowManagerService {
  WindowHierarchyController? _controller;
  final Map<String, bool> _minimizedCache = {};

  @override
  WindowHierarchyController get controller {
    if (_controller == null) {
      throw Exception(
        "The window manager service is not currently running, can't obtain the controller",
      );
    }

    return _controller!;
  }

  @override
  void start() {
    _controller = WindowHierarchyController();
  }

  @override
  void stop() {
    _controller = null;
  }

  @override
  void push(LiveWindowEntry entry) {
    unminimizeEverything();
    controller.addWindowEntry(entry);
  }

  @override
  void pop(String id) {
    controller.removeWindowEntry(id);
  }

  @override
  void minimizeEverything() {
    _minimizedCache.addEntries(
      controller.entries.map(
        (e) => MapEntry(e.registry.info.id, e.layoutState.minimized),
      ),
    );

    for (final LiveWindowEntry e in controller.entries) {
      e.layoutState.minimized = true;
    }
  }

  @override
  void unminimizeEverything() {
    for (final LiveWindowEntry entry in controller.entries) {
      final bool? cachedStatus = _minimizedCache[entry.registry.info.id];

      entry.layoutState.minimized = cachedStatus ?? false;
    }

    _minimizedCache.clear();
  }
}
