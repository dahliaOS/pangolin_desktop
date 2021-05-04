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
import 'package:pangolin/desktop/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/desktop/taskbar/taskbar_item.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';
import 'package:pangolin/utils/preference_extension.dart';

class Taskbar extends StatefulWidget {
  final List<Widget>? leading, trailing;
  Taskbar({@required this.leading, @required this.trailing});

  @override
  _TaskbarState createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar> {
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    List<String> _pinnedApps = _pref.pinnedApps;
    List<String> _taskbarApps = _pinnedApps.toList()
      ..addAll(Provider.of<WindowHierarchyState>(context)
          .windows
          .map<String>(
              (e) => _pinnedApps.contains(e.packageName) ? "" : e.packageName)
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
            .map<Widget>((e) => e != ""
                ? TaskbarItem(key: ValueKey(e), packageName: e)
                : SizedBox.shrink(
                    key: ValueKey(Random()),
                  ))
            .toList());
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
              WmAPI.of(context).pushOverlayEntry(
                DismissibleOverlayEntry(
                    uniqueId: "launcher",
                    content: LauncherOverlay(),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut),
              );
            }
            print(_scroll);
            print('Scrolled');
          }
        },
        child: BoxContainer(
            //height: 48,
            //height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
            useSystemOpacity: true,
            color: Theme.of(context).backgroundColor,
            child: Stack(
              children: [
                _pref.centerTaskbar ? Center(child: items) : SizedBox.shrink(),
                _pref.isTaskbarHorizontal
                    ? Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.leading ?? [SizedBox.shrink()],
                          ),
                          Expanded(
                            child: _pref.centerTaskbar ? Container() : items,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.trailing ?? [SizedBox.shrink()],
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.leading ?? [SizedBox.shrink()],
                          ),
                          Expanded(
                            child: _pref.centerTaskbar ? Container() : items,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.trailing ?? [SizedBox.shrink()],
                          ),
                        ],
                      ),
                /* Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
                  child: Row(
                    children: widget.leading ?? [SizedBox.shrink()],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.trailing ?? [SizedBox.shrink()],
                  ),
                ) */
              ],
            )),
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
