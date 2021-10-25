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

import 'dart:math';

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/launcher_overlay.dart';
import '../shell/shell.dart';
import 'package:pangolin/components/taskbar/taskbar_item.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/utils/extensions/preference_extension.dart';

class Taskbar extends StatefulWidget {
  final List<Widget>? leading, trailing;
  Taskbar({@required this.leading, @required this.trailing});

  @override
  _TaskbarState createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar> {
  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);
    final _pref = Provider.of<PreferenceProvider>(context);
    List<String> _pinnedApps = _pref.pinnedApps;
    List<String> _taskbarApps = _pinnedApps.toList()
      ..addAll(WindowHierarchy.of(context)
          .entries
          .map<String>(
            (e) => _pinnedApps.contains(e.registry.extra.stableId)
                ? ""
                : e.registry.extra.stableId,
          )
          .toList());

    Widget items = ReorderableListView(
      shrinkWrap: true,
      primary: true,
      physics: BouncingScrollPhysics(),
      scrollDirection:
          _pref.isTaskbarHorizontal ? Axis.horizontal : Axis.vertical,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _taskbarApps.removeAt(oldIndex);
          _taskbarApps.insert(newIndex, item);
          if (_pinnedApps.contains(item)) {
            DatabaseManager.set("pinnedApps", _pinnedApps);
          } else {
            setState(() {
              _pinnedApps.add(item);
              DatabaseManager.set("pinnedApps", _pinnedApps);
            });
          }
        });
      },
      children: _taskbarApps
          .map<Widget>(
            (e) => e != ""
                ? TaskbarItem(key: ValueKey(e), packageName: e)
                : SizedBox.shrink(
                    key: ValueKey(Random()),
                  ),
          )
          .toList(),
    );
    double _scroll = 0;
    return Positioned(
      left: !_pref.isTaskbarRight ? 0 : null,
      right: !_pref.isTaskbarLeft ? 0 : null,
      bottom: !_pref.isTaskbarTop ? 0 : null,
      top: !_pref.isTaskbarBottom ? 0 : null,
      height: _pref.isTaskbarHorizontal ? 48 : null,
      width: _pref.isTaskbarVertical
          ? 48
          : null, //height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
      child: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            // do something when scrolled
            setState(() {
              _scroll = _scroll + pointerSignal.scrollDelta.dy;
            });
            if (_scroll > 500) {
              Shell.of(context).dismissOverlay(LauncherOverlay.overlayId);
            }
          }
        },
        // TODO Fix taskbar background position
        child: ContextMenuRegion(
          contextMenu: ContextMenu(
            items: [
              ContextMenuItem(
                icon: Icons.power_input_sharp,
                title: "Taskbar Position",
                onTap: null,
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_drop_down_rounded,
                title: "Bottom",
                onTap: () {
                  _pref.taskbarPosition = 2.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_drop_up_rounded,
                title: "Top",
                onTap: () {
                  _pref.taskbarPosition = 0.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_left_rounded,
                title: "Left",
                onTap: () {
                  _pref.taskbarPosition = 1.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_right_rounded,
                title: "Right",
                onTap: () {
                  _pref.taskbarPosition = 3.0;
                },
                shortcut: "",
              ),
            ],
          ),
          child: ValueListenableBuilder<bool>(
              valueListenable:
                  _shell.getShowingNotifier(LauncherOverlay.overlayId),
              builder: (context, shown, child) {
                return Material(
                  color: shown
                      ? Colors.black.withOpacity(0.05)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Stack(
                      children: [
                        _pref.centerTaskbar
                            ? Positioned.fill(
                                child: listenerWrapper(Center(child: items)),
                              )
                            : SizedBox.shrink(),
                        _pref.isTaskbarHorizontal
                            ? Row(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        widget.leading ?? [SizedBox.shrink()],
                                  ),
                                  Expanded(
                                    child: _pref.centerTaskbar
                                        ? Container()
                                        : listenerWrapper(items),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        widget.trailing ?? [SizedBox.shrink()],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        widget.leading ?? [SizedBox.shrink()],
                                  ),
                                  Expanded(
                                    child: _pref.centerTaskbar
                                        ? Container()
                                        : listenerWrapper(items),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        widget.trailing ?? [SizedBox.shrink()],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget listenerWrapper(Widget child) {
    return SizedBox.expand(
      child: Listener(
        onPointerDown: (event) {
          Shell.of(context, listen: false).dismissEverything();
        },
        behavior: HitTestBehavior.translucent,
        child: SizedBox.shrink(child: child),
      ),
    );
  }
}

extension JoinList<T> on List<T> {
  List<T> joinType(T separator) {
    List<T> workList = [];

    for (int i = 0; i < (length * 2) - 1; i++) {
      if (i % 2 == 0) {
        workList.add(this[i ~/ 2]);
      } else {
        workList.add(separator);
      }
    }

    return workList;
  }
}
