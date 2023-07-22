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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pangolin/components/shell/effects.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:zenit_ui/zenit_ui.dart';

class PangolinWindowToolbar extends StatefulWidget {
  static const double dockEdgeSize = 40;

  const PangolinWindowToolbar({
    super.key,
    required this.barColor,
    required this.textColor,
  });

  final Color barColor;
  final Color textColor;

  @override
  _PangolinWindowToolbarState createState() => _PangolinWindowToolbarState();
}

class _PangolinWindowToolbarState extends State<PangolinWindowToolbar> {
  SystemMouseCursor _cursor = SystemMouseCursors.move;
  // ignore: unused_field
  late DragUpdateDetails _lastDetails;
  WindowDock? _draggingDock;

  @override
  Widget build(BuildContext context) {
    final hierarchy = WindowHierarchy.of(context);
    final properties = WindowPropertyRegistry.of(context);
    final layout = LayoutState.of(context);
    final fgColor =
        !Theme.of(context).darkMode ? Colors.grey[900]! : Colors.white;

    return GestureDetector(
      child: ContextMenu(
        entries: [
          ContextMenuItem(
            leading: const Icon(Icons.close),
            //TODO Localize
            child: const Text("Close Window"),
            onTap: () => onClose(properties),
          ),
          ContextMenuItem(
            leading: const Icon(Icons.minimize),
            //TODO Localize
            child: const Text("Minimize Window"),
            onTap: () => onMinimize(properties, layout),
          ),
          ContextMenuItem(
            leading: const Icon(Icons.info_outline_rounded),
            //TODO Localize
            child: const Text("App Info"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 1.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (properties.info.icon != null)
                        Image(image: properties.info.icon!)
                      else
                        const Icon(Icons.apps),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(properties.info.title)
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Close"),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
        child: SizedBox(
          height: 40,
          child: Material(
            type: MaterialType.transparency,
            child: IconTheme.merge(
              data: IconThemeData(
                color: fgColor,
                size: 20,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        if (properties.info.icon != null)
                          Image(
                            image: properties.info.icon!,
                            width: 20,
                            height: 20,
                          )
                        else
                          Icon(
                            Icons.apps,
                            size: 20,
                            color: fgColor,
                          ),
                        const SizedBox(width: 8),
                        const Spacer(),
                        WindowToolbarButton(
                          icon: const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(Icons.minimize),
                          ),
                          onTap: () => onMinimize(properties, layout),
                        ),
                        WindowToolbarButton(
                          icon: layout.dock == WindowDock.maximized
                              ? const Icon(_ToolbarIcons.minimize)
                              : const Icon(_ToolbarIcons.maximize),
                          onTap: () {
                            if (layout.dock == WindowDock.maximized) {
                              layout.dock = WindowDock.none;
                            } else {
                              layout.dock = WindowDock.maximized;
                            }
                            /* if (!entry.maximized) {
                              layout.dock = WindowDock.NORMAL;
                            } */
                          },
                        ),
                        WindowToolbarButton(
                          icon: const Icon(Icons.close),
                          onTap: () => onClose(properties),
                        ),
                        const SizedBox(width: 2),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      properties.info.title,
                      style: TextStyle(
                        color: fgColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 40.0 * 3,
                    bottom: 0,
                    child: MouseRegion(
                      cursor: _cursor,
                      child: GestureDetector(
                        onTertiaryTapUp: (details) {
                          setState(() {
                            onClose(properties);
                          });
                        },
                        onPanStart: (details) {
                          _draggingDock = WindowDock.none;
                          final layer = EffectsLayer.of(context);
                          layer?.startDockEffect(layout);

                          if (layout.dock != WindowDock.none) {
                            layout.dock = WindowDock.none;
                            layout.position = details.globalPosition +
                                Offset(
                                  -layout.size.width / 2,
                                  -properties.toolbar.size / 2,
                                );
                          }
                        },
                        onDoubleTap: () => onDoubleTap(layout),
                        onPanUpdate: (details) =>
                            onDrag(details, properties, layout),
                        onPanEnd: (details) => onDragEnd(
                          details,
                          hierarchy,
                          properties,
                          layout,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClose(WindowPropertyRegistry properties) {
    final hierarchy = WindowHierarchy.of(context, listen: false);
    hierarchy.removeWindowEntry(properties.info.id);
  }

  void onMinimize(WindowPropertyRegistry properties, LayoutState layout) {
    final hierarchy = WindowHierarchy.of(context, listen: false);
    final windows = hierarchy.entriesByFocus;

    layout.minimized = true;
    if (windows.length > 1) {
      hierarchy.requestEntryFocus(windows[windows.length - 2].registry.info.id);
    }
  }

  void onDrag(
    DragUpdateDetails details,
    WindowPropertyRegistry properties,
    LayoutState layout,
  ) {
    final hierarchy = WindowHierarchy.of(context, listen: false);
    setState(() {
      _cursor = SystemMouseCursors.move;
    });
    _lastDetails = details;
    final WindowDock dock =
        _getDockForPosition(hierarchy.wmBounds, details.globalPosition);
    if (_draggingDock != dock) {
      _draggingDock = dock;
      final layer = EffectsLayer.of(context);
      layer?.updateDockEffect(dock);
    }

    layout.position += details.delta;
    layout.position = Offset(
      layout.position.dx,
      layout.position.dy.clamp(
        0,
        hierarchy.wmBounds.bottom - properties.toolbar.size,
      ),
    );
    setState(() {});
  }

  WindowDock _getDockForPosition(Rect bounds, Offset position) {
    final Rect topLeft = Rect.fromLTWH(
      bounds.left,
      bounds.top,
      PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
    );
    final Rect left = Rect.fromLTWH(
      bounds.left,
      bounds.top + PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
      bounds.height - PangolinWindowToolbar.dockEdgeSize * 2,
    );
    final Rect bottomLeft = Rect.fromLTWH(
      bounds.left,
      bounds.bottom - PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
    );
    final Rect topRight = Rect.fromLTWH(
      bounds.right - PangolinWindowToolbar.dockEdgeSize,
      bounds.top,
      PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
    );
    final Rect right = Rect.fromLTWH(
      bounds.right - PangolinWindowToolbar.dockEdgeSize,
      bounds.top + PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
      bounds.height - PangolinWindowToolbar.dockEdgeSize * 2,
    );
    final Rect bottomRight = Rect.fromLTWH(
      bounds.right - PangolinWindowToolbar.dockEdgeSize,
      bounds.bottom - PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
      PangolinWindowToolbar.dockEdgeSize,
    );
    final Rect maximized = Rect.fromLTWH(
      bounds.left + PangolinWindowToolbar.dockEdgeSize,
      bounds.top,
      bounds.width - PangolinWindowToolbar.dockEdgeSize * 2,
      PangolinWindowToolbar.dockEdgeSize,
    );

    if (topLeft.contains(position)) return WindowDock.topLeft;
    if (left.contains(position)) return WindowDock.left;
    if (bottomLeft.contains(position)) return WindowDock.bottomLeft;

    if (topRight.contains(position)) return WindowDock.topRight;
    if (right.contains(position)) return WindowDock.right;
    if (bottomRight.contains(position)) return WindowDock.bottomRight;

    if (maximized.contains(position)) return WindowDock.maximized;

    return WindowDock.none;
  }

  void onDragEnd(
    DragEndDetails details,
    WindowHierarchyController hierarchy,
    WindowPropertyRegistry properties,
    LayoutState layout,
  ) {
    setState(() {
      _cursor = SystemMouseCursors.click;
    });
    final WindowDock dock =
        _getDockForPosition(hierarchy.wmBounds, _lastDetails.globalPosition);
    layout.dock = dock;
    final layer = EffectsLayer.of(context);
    layer?.endDockEffect();
    _draggingDock = null;
  }

  void onDoubleTap(LayoutState layout) {
    if (layout.dock == WindowDock.maximized) {
      layout.dock = WindowDock.none;
    } else {
      layout.dock = WindowDock.maximized;
    }
  }
}

class WindowToolbarButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final Color? hoverColor;

  const WindowToolbarButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.square(40),
      child: Center(
        child: SizedBox.fromSize(
          size: const Size.square(32),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              hoverColor: hoverColor,
              splashColor: hoverColor,
              onTap: onTap,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolbarIcons {
  _ToolbarIcons._();

  static const String _kFontFam = 'CustomIcons';

  static const IconData maximize = IconData(0xe800, fontFamily: _kFontFam);
  static const IconData minimize = IconData(0xe801, fontFamily: _kFontFam);
}
