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

import 'package:flutter/services.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/wm/wm.dart';

class PangolinWindowToolbar extends StatefulWidget {
  const PangolinWindowToolbar({
    Key? key,
    required this.barColor,
    required this.textColor,
  }) : super(key: key);

  final Color barColor;
  final Color textColor;

  @override
  _PangolinWindowToolbarState createState() => _PangolinWindowToolbarState();
}

class _PangolinWindowToolbarState extends State<PangolinWindowToolbar> {
  SystemMouseCursor _cursor = SystemMouseCursors.move;
  // ignore: unused_field
  late DragUpdateDetails _lastDetails;

  @override
  Widget build(BuildContext context) {
    final properties = WindowPropertyRegistry.of(context);
    final layout = LayoutState.of(context);
    final fgColor = !context.theme.darkMode ? Colors.grey[900]! : Colors.white;
    final _customizationProvider = CustomizationProvider.of(context);

    return GestureDetector(
      child: ContextMenuRegion(
        contextMenu: ContextMenu(
          items: [
            ContextMenuItem(
              icon: Icons.close,
              //TODO Localize
              title: "Close Window",
              onTap: () => onClose(properties),
              shortcut: "",
            ),
            ContextMenuItem(
              icon: Icons.minimize,
              //TODO Localize
              title: "Minimize Window",
              onTap: () => onMinimize(properties, layout),
              shortcut: "",
            ),
            ContextMenuItem(
              icon: Icons.info_outline_rounded,
              //TODO Localize
              title: "App Info",
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
              shortcut: "",
            ),
          ],
        ),
        child: SizedBox(
          height: 40,
          child: Material(
            color: _customizationProvider.coloredTitlebars
                ? widget.barColor.op(
                    _customizationProvider.transparentColoredTitlebars
                        ? 0.5
                        : 1.0,
                  )
                : Colors.transparent,
            child: IconTheme.merge(
              data: IconThemeData(
                color: _customizationProvider.coloredTitlebars
                    ? widget.textColor
                    : fgColor,
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
                        color: _customizationProvider.coloredTitlebars
                            ? widget.textColor
                            : fgColor,
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
                        onPanEnd: onDragEnd,
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
    /* final hierarchy = context.read<WindowHierarchyState>();
    final docked = entry.maximized || layout.dock != WindowDock.NORMAL;
    double dockedToolbarOffset;

    switch (layout.dock) {
      case WindowDock.TOP:
      case WindowDock.TOP_LEFT:
      case WindowDock.TOP_RIGHT:
      case WindowDock.LEFT:
      case WindowDock.RIGHT:
        dockedToolbarOffset = 0;
        break;
      case WindowDock.BOTTOM:
      case WindowDock.BOTTOM_LEFT:
      case WindowDock.BOTTOM_RIGHT:
        dockedToolbarOffset =
            hierarchy.wmRect.top + hierarchy.wmRect.height / 2;
        break;
      case WindowDock.NORMAL:
      default:
        dockedToolbarOffset = 0;
        break;
    }

    Rect base = Rect.fromLTWH(
      docked
          ? details.globalPosition.dx - entry.windowRect.width / 2
          : entry.windowRect.left,
      docked ? dockedToolbarOffset : entry.windowRect.top,
      entry.windowRect.width,
      entry.windowRect.height,
    );
    hierarchy.requestWindowFocus(entry);
    entry.maximized = false;
    layout.dock = WindowDock.NORMAL; */

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

  void onDragEnd(DragEndDetails details) {
    setState(() {
      _cursor = SystemMouseCursors.click;
    });
    /* final entry = context.read<WindowEntry>();
    final rect = context.read<WindowHierarchyState>().wmRect;
    final topEdge = _lastDetails.globalPosition.dy <= rect.top + 2;
    final leftEdge = _lastDetails.globalPosition.dx <= rect.left + 2;
    final rightEdge = _lastDetails.globalPosition.dx >= rect.right - 2;

    if (topEdge && _lastDetails.globalPosition.dx <= rect.left + 2 ||
        _lastDetails.globalPosition.dy <= rect.top + 50 && leftEdge) {
      entry.windowDock = WindowDock.TOP_LEFT;
      return;
    }

    if (topEdge && _lastDetails.globalPosition.dx >= rect.right - 50 ||
        _lastDetails.globalPosition.dy <= rect.top + 50 && rightEdge) {
      entry.windowDock = WindowDock.TOP_RIGHT;
      return;
    }

    if (topEdge && _lastDetails.globalPosition.dx <= rect.left + 2 ||
        _lastDetails.globalPosition.dy <= rect.top + 50 && leftEdge) {
      entry.windowDock = WindowDock.TOP_LEFT;
      return;
    }

    if (leftEdge && _lastDetails.globalPosition.dy >= rect.bottom - 50) {
      entry.windowDock = WindowDock.BOTTOM_LEFT;
      return;
    }

    if (rightEdge && _lastDetails.globalPosition.dy >= rect.bottom - 50) {
      entry.windowDock = WindowDock.BOTTOM_RIGHT;
      return;
    }

    if (topEdge) {
      entry.maximized = true;
      return;
    }

    if (leftEdge) {
      entry.windowDock = WindowDock.LEFT;
      return;
    }

    if (rightEdge) {
      entry.windowDock = WindowDock.RIGHT;
      return;
    } */
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
    Key? key,
    required this.icon,
    required this.onTap,
    this.hoverColor,
  }) : super(key: key);

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

  static const _kFontFam = 'CustomIcons';
  static const _kFontPkg = 'utopia_wm';

  static const IconData maximize =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData minimize =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
