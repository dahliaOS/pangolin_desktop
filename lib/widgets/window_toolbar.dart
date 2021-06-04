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
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class PangolinWindowToolbar extends StatefulWidget {
  @override
  _PangolinWindowToolbarState createState() => _PangolinWindowToolbarState();
}

class _PangolinWindowToolbarState extends State<PangolinWindowToolbar> {
  SystemMouseCursor _cursor = SystemMouseCursors.move;
  late DragUpdateDetails _lastDetails;

  @override
  Widget build(BuildContext context) {
    final entry = context.watch<WindowEntry>();
    final _data = context.watch<PreferenceProvider>();
    final fgColor = !_data.darkMode ? Colors.grey[900]! : Colors.white;

    return GestureDetector(
      child: ContextMenuRegion(
        contextMenu: ContextMenu(
          items: [
            ContextMenuItem(
              icon: Icons.close,
              title: "Close Window",
              onTap: onClose,
              shortcut: "",
            ),
            ContextMenuItem(
              icon: Icons.minimize,
              title: "Minimize Window",
              onTap: onMinimize,
              shortcut: "",
            ),
            ContextMenuItem(
              icon: Icons.info_outline_rounded,
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
                        entry.icon != null
                            ? Image(image: entry.icon!)
                            : Icon(Icons.apps),
                        SizedBox(
                          height: 16,
                        ),
                        Text(entry.title ?? "")
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
          child: BoxContainer(
            useAccentBG: true,
            cursor: _cursor,
            customBorderRadius:
                entry.maximized || entry.windowDock != WindowDock.NORMAL
                    ? BorderRadius.circular(0)
                    : BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
            useBlur: true,
            color: _data.useColoredTitlebar
                ? entry.toolbarColor
                : (_data.darkMode ? Color(0xff0a0a0a) : Color(0xfff0f8ff)),
            useSystemOpacity: true,
            child: Material(
              color: Colors.transparent,
              child: IconTheme.merge(
                data: IconThemeData(
                  color: fgColor,
                  size: 20,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          entry.icon != null
                              ? Image(
                                  image: entry.icon!,
                                  width: 20,
                                  height: 20,
                                )
                              : Icon(
                                  Icons.apps,
                                  size: 20,
                                  color: fgColor,
                                ),
                          SizedBox(width: 8),
                          Spacer(),
                          WindowToolbarButton(
                            icon: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Icon(Icons.minimize),
                            ),
                            onTap: onMinimize,
                            hoverColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                          ),
                          WindowToolbarButton(
                            icon: entry.maximized
                                ? Icon(_ToolbarIcons.minimize)
                                : Icon(_ToolbarIcons.maximize),
                            onTap: () {
                              context
                                  .read<WindowHierarchyState>()
                                  .requestWindowFocus(entry);
                              entry.toggleMaximize();
                              if (!entry.maximized) {
                                entry.windowDock = WindowDock.NORMAL;
                              }
                            },
                            hoverColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                          ),
                          WindowToolbarButton(
                            icon: Icon(Icons.close),
                            onTap: onClose,
                            hoverColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                          ),
                          SizedBox(width: 2),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        entry.title ?? "",
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
                              onClose();
                            });
                          },
                          onTap: onTap,
                          onDoubleTap: onDoubleTap,
                          onPanUpdate: onDrag,
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
      ),
    );
  }

  void onClose() {
    final entry = context.read<WindowEntry>();
    final hierarchy = context.read<WindowHierarchyState>();
    hierarchy.popWindowEntry(entry);
  }

  void onMinimize() {
    final entry = context.read<WindowEntry>();
    final hierarchy = context.read<WindowHierarchyState>();
    final windows = hierarchy.entriesByFocus;

    entry.minimized = true;
    if (windows.length > 1) {
      hierarchy.requestWindowFocus(windows[windows.length - 2]);
    }
  }

  void onDrag(details) {
    setState(() {
      _cursor = SystemMouseCursors.move;
    });
    _lastDetails = details;
    final entry = context.read<WindowEntry>();
    final hierarchy = context.read<WindowHierarchyState>();
    final docked = entry.maximized || entry.windowDock != WindowDock.NORMAL;
    double dockedToolbarOffset;

    switch (entry.windowDock) {
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
    entry.windowDock = WindowDock.NORMAL;

    entry.windowRect = base.translate(
      details.delta.dx,
      details.delta.dy,
    );
    setState(() {});
  }

  void onDragEnd(details) {
    setState(() {
      _cursor = SystemMouseCursors.click;
    });
    final entry = context.read<WindowEntry>();
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
    }
  }

  void onTap() {
    final entry = context.read<WindowEntry>();
    context.read<WindowHierarchyState>().requestWindowFocus(entry);
  }

  void onDoubleTap() {
    final entry = context.read<WindowEntry>();
    final hierarchy = context.read<WindowHierarchyState>();
    hierarchy.requestWindowFocus(entry);
    entry.toggleMaximize();
  }
}

class WindowToolbarButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final Color? hoverColor;

  WindowToolbarButton({
    required this.icon,
    required this.onTap,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(40),
      child: Center(
        child: SizedBox.fromSize(
          size: Size.square(32),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
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
