import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/effects.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:provider/provider.dart';

class PangolinLayoutDelegate extends LayoutDelegate<FreeformLayoutInfo> {
  static final EffectsLayerController _effectsController =
      EffectsLayerController();

  const PangolinLayoutDelegate();

  @override
  Widget layout(
    BuildContext context,
    List<LiveWindowEntry> entries,
    List<String> focusHierarchy,
  ) {
    final List<LiveWindowEntry> liveEntries =
        WindowEntryUtils.getEntriesByFocus(entries, focusHierarchy);

    final LiveWindowEntry? entry = liveEntries.firstWhereOrNull(
      (e) => e.layoutState.fullscreen || e.registry.extra.appId == "shell",
    );
    final int effectLayerIndex;
    if (entry != null && liveEntries.indexOf(entry) > 0) {
      effectLayerIndex = liveEntries.indexOf(entry) - 1;
    } else {
      effectLayerIndex = -1;
    }

    final List<Widget> children = [];
    for (int i = 0; i < liveEntries.length; i++) {
      final LiveWindowEntry entry = liveEntries[i];

      if (effectLayerIndex == i) {
        final Widget layer = EffectsLayer(controller: _effectsController);
        children.add(layer);
      }

      if (entry.registry.extra.appId != "shell") {
        children.add(
          _WindowLayoutBuilder(
            window: entry,
            key: ValueKey(entry.registry.info.id),
          ),
        );
      } else {
        children.add(
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) => MediaQuery(
                data: MediaQueryData(size: constraints.biggest),
                child: entry.view,
              ),
            ),
          ),
        );
      }
    }

    return Provider.value(
      value: _effectsController,
      child: Stack(
        clipBehavior: Clip.none,
        children: children,
      ),
    );
  }

  static Rect getRectForDock(
    WindowDock dock,
    WindowHierarchyController hierarchy,
  ) {
    switch (dock) {
      case WindowDock.maximized:
        return hierarchy.wmBounds;
      case WindowDock.left:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left,
          hierarchy.wmBounds.top,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height,
        );
      case WindowDock.right:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left + hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.top,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height,
        );
      case WindowDock.topLeft:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left,
          hierarchy.wmBounds.top,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height / 2,
        );
      case WindowDock.topRight:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left + hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.top,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height / 2,
        );
      case WindowDock.bottomLeft:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left,
          hierarchy.wmBounds.top + hierarchy.wmBounds.height / 2,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height / 2,
        );
      case WindowDock.bottomRight:
        return Rect.fromLTWH(
          hierarchy.wmBounds.left + hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.top + hierarchy.wmBounds.height / 2,
          hierarchy.wmBounds.width / 2,
          hierarchy.wmBounds.height / 2,
        );
      default:
        throw Exception();
    }
  }
}

class _WindowLayoutBuilder extends StatefulWidget {
  final LiveWindowEntry window;

  const _WindowLayoutBuilder({required this.window, super.key});

  @override
  State<_WindowLayoutBuilder> createState() => _WindowLayoutBuilderState();
}

class _WindowLayoutBuilderState extends State<_WindowLayoutBuilder>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Rect _rect = window.layoutState.rect;
  late Rect _actualRect = _getWindowRect();
  late WindowDock _dock = window.layoutState.dock;
  late bool _fullscreen = window.layoutState.fullscreen;
  late Size _mqSize = MediaQuery.of(context).size;

  late final RectTween _rectTween = RectTween(begin: _actualRect);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void didUpdateWidget(_WindowLayoutBuilder old) {
    super.didUpdateWidget(old);

    if (window.layoutState.fullscreen != _fullscreen) {
      _fullscreen = window.layoutState.fullscreen;
      _animateWindow();
      return;
    }

    if (window.layoutState.dock != _dock) {
      _dock = window.layoutState.dock;
      _animateWindow();
      return;
    }

    if (window.layoutState.rect != _rect) {
      _rectTween.begin = window.layoutState.rect;
      _rectTween.end = null;
      _controller.value = 0;
      _rect = _rectTween.begin!;
      _actualRect = _rectTween.begin!;
      return;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_mqSize != MediaQuery.of(context).size) {
      _mqSize = MediaQuery.of(context).size;
      _actualRect = _getWindowRect();
      setState(() {});
    }
  }

  Future<void> _animateWindow() async {
    _rectTween.end = _getWindowRect();
    await _controller.animateTo(1);
    _actualRect = _getWindowRect();
    _rectTween.begin = _rectTween.end;
    _controller.value = 0;
    _rectTween.end = null;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LiveWindowEntry get window => widget.window;
  CurvedAnimation get animation => CurvedAnimation(
        parent: _controller,
        curve: decelerateEasing,
      );

  Rect _getWindowRect() {
    final WindowHierarchyController hierarchy =
        WindowHierarchy.of(context, listen: false);

    if (window.layoutState.fullscreen) {
      return hierarchy.displayBounds;
    } else if (window.layoutState.dock != WindowDock.none) {
      return PangolinLayoutDelegate.getRectForDock(
        window.layoutState.dock,
        hierarchy,
      );
    } else {
      return window.layoutState.rect;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final Rect rect = _controller.value > 0
            ? _rectTween.evaluate(animation)!
            : _actualRect;

        return Positioned.fromRect(
          rect: rect,
          child: child!,
        );
      },
      child: Offstage(
        offstage: window.layoutState.minimized,
        child: MediaQuery(
          data: MediaQueryData(size: _actualRect.size),
          child: window.view,
        ),
      ),
    );
  }
}
