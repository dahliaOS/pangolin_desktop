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
import 'package:pangolin/desktop/taskbar/clock.dart';
import 'package:pangolin/desktop/taskbar/quick_settings.dart';
import 'package:pangolin/desktop/taskbar/launcher.dart';
import 'package:pangolin/desktop/taskbar/notifications.dart';
import 'package:pangolin/desktop/taskbar/overview.dart';
import 'package:pangolin/desktop/taskbar/search.dart';
import 'package:pangolin/desktop/taskbar/taskbar.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:utopia_wm/wm.dart';

// ignore: must_be_immutable
class Desktop extends StatelessWidget {
  static final GlobalKey<WindowHierarchyState> wmKey =
      GlobalKey<WindowHierarchyState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PreferenceProvider>(context, listen: false)
                  .centerTaskbar =
              !Provider.of<PreferenceProvider>(context, listen: false)
                  .centerTaskbar;
        },
      ), */
      body: WindowHierarchy(
          key: wmKey,
          rootWindow: Wallpaper(),
          alwaysOnTopWindows: [
            Taskbar(
              leading: [
                SizedBox(
                  width: 4,
                ),
                LauncherButton(),
                SearchButton(),
                OverviewButton(),
              ],
              trailing: [
                //NotificationsButton(),
                QuickSettingsButton(),
                DateClockWidget(),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ],
          margin: EdgeInsets.only(
            bottom: 48,
          )),
    );
  }
}
