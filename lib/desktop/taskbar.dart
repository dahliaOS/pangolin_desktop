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
import 'package:flutter/material.dart';
import 'package:pangolin/desktop/taskbar_elements/taskbar_item.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class Taskbar extends StatelessWidget {
  final List<Widget>? leading, trailing;
  Taskbar({@required this.leading, @required this.trailing});

  @override
  Widget build(BuildContext context) {
    List<String> _pinnedApps =
        Provider.of<PreferenceProvider>(context).pinnedApps;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
      child: BoxContainer(
          height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
          useSystemOpacity: true,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(DatabaseManager.get('taskbarRounding')),
                topRight:
                    Radius.circular(DatabaseManager.get('taskbarRounding'))),
          ),
          color: Theme.of(context).backgroundColor,
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
                child: Row(
                  children: leading ?? [SizedBox.shrink()],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _pinnedApps
                            .map<Widget>((e) => TaskbarItem(packageName: e))
                            .toList()
                            .joinType(SizedBox(
                              width: 4,
                            ))
                              ..addAll(
                                  Provider.of<WindowHierarchyState>(context)
                                      .windows
                                      .map<Widget>((e) =>
                                          _pinnedApps.contains(e.packageName)
                                              ? SizedBox.shrink()
                                              : TaskbarItem(
                                                  packageName: e.packageName))
                                      .toList())),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: DatabaseManager.get('taskbarHeight').toDouble() ?? 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: trailing ?? [SizedBox.shrink()],
                ),
              )
            ],
          )),
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
