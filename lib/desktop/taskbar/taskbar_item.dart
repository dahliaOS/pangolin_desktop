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
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class TaskbarItem extends StatelessWidget {
  final String packageName;
  TaskbarItem({required this.packageName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Running apps
    //// ITS FAILING HERE
    final windows = Provider.of<WindowHierarchyState>(context, listen: false)
        .entriesByFocus;
    //Selected App
    final _app = applications
        .firstWhere((element) => element.packageName == packageName);
    //Check if App is running or just pinned
    bool appIsRunning =
        windows.any((element) => element.packageName == packageName);
    //get the WindowEntry when the App is running
    late WindowEntry? entry = appIsRunning
        ? windows.firstWhere((element) => element.packageName == packageName)
        : null;
    //check if the App is focused
    bool focused = windows.length > 1
        ? windows.last.packageName == packageName && !windows.last.minimized
        : true;

    //Build Widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: SizedBox(
        height: 48,
        width: 52,
        child: Material(
          //set a background colour if the app is running or focused
          color: appIsRunning
              ? (focused
                  ? Theme.of(context).accentColor.withOpacity(0.5)
                  : Theme.of(context).backgroundColor.withOpacity(0.5))
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              //open the app or toggle
              if (appIsRunning) {
                _onTap(context, entry);
              } else {
                WmAPI.of(context).openApp(packageName);
                //print(packageName);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image(
                  image: appIsRunning
                      ? entry?.icon ?? NetworkImage("https://google.com")
                      : AssetImage("assets/icons/${_app.iconName}.png")),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, WindowEntry? entry) {
    //final entry = Provider.of<WindowEntry>(context, listen: false);
    final hierarchy = context.read<WindowHierarchyState>();
    final windows = hierarchy.entriesByFocus;

    bool focused = windows.last.id == entry!.id;

    /* _overlayTimer?.cancel();
    _overlayTimer = null;
    _showOverlay = false;
    setState(() {}); */
    if (focused && !entry.minimized) {
      entry.minimized = true;
      if (windows.length > 1) {
        hierarchy.requestWindowFocus(
          windows[windows.length - 2],
        );
      }
    } else {
      entry.minimized = false;
      hierarchy.requestWindowFocus(entry);
    }
  }
}
