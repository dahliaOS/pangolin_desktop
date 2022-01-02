import 'package:flutter/material.dart';
import 'package:pangolin/utils/wm/wm.dart';

class PangolinLayoutDelegate extends LayoutDelegate<FreeformLayoutInfo> {
  const PangolinLayoutDelegate();

  @override
  Widget layout(
    BuildContext context,
    List<LiveWindowEntry> entries,
    List<String> focusHierarchy,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: WindowEntryUtils.getEntriesByFocus(entries, focusHierarchy)
          .map((e) => _buildWindow(context, e))
          .toList(),
    );
  }

  static Widget _buildWindow(BuildContext context, LiveWindowEntry window) {
    final WindowHierarchyController hierarchy = WindowHierarchy.of(context);

    final Rect mqRect;
    final Widget Function(Widget child) builder;

    if (window.layoutState.fullscreen ||
        window.registry.extra.stableId == "shell") {
      mqRect = hierarchy.displayBounds;
      builder = (child) => Positioned.fill(child: child);
    } else if (window.layoutState.dock != WindowDock.none) {
      mqRect = _getRectForDock(window.layoutState.dock, hierarchy);
      builder = (child) => Positioned.fromRect(rect: mqRect, child: child);
    } else {
      mqRect = window.layoutState.rect;
      builder = (child) => Positioned.fromRect(rect: mqRect, child: child);
    }

    return builder(
      Offstage(
        offstage: window.layoutState.minimized,
        child: MediaQuery(
          data: MediaQueryData(size: mqRect.size),
          child: window.view,
        ),
      ),
    );
  }

  static Rect _getRectForDock(
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
