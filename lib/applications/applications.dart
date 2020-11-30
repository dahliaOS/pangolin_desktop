/*
Copyright 2019 The dahliaOS Authors

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

import 'package:Pangolin/applications/clock/main.dart';
import 'package:Pangolin/internal/locales/locale_strings.g.dart';
import 'package:Pangolin/utils/applicationdata.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:flutter/material.dart';
import 'package:Pangolin/applications/calculator/calculator.dart';
import 'package:Pangolin/applications/containers/containers.dart';
import 'package:Pangolin/applications/files/main.dart';
import 'package:Pangolin/applications/editor/editor.dart';
import 'package:Pangolin/applications/terminal/main.dart';
import 'package:Pangolin/applications/browser/main.dart';
import 'package:Pangolin/applications/terminal/root/main.dart';
import 'package:Pangolin/applications/developer/developer.dart';
import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/applications/monitor/monitor.dart';
import 'package:Pangolin/utils/widgets/app_launcher.dart';
import 'package:Pangolin/applications/welcome/welcome.dart';
import 'package:Pangolin/utils/others/functions.dart';
import 'package:Pangolin/applications/logging/logging.dart';

Expanded tileSection(BuildContext context) {
  double _width() {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1920) {
      return HiveManager.get("launcherWideMode") ? 100 : 350;
    } else if (width >= 1500 && width < 1920) {
      return HiveManager.get("launcherWideMode") ? 80 : 250;
    } else if (width >= 1200 && width < 1500) {
      return HiveManager.get("launcherWideMode") ? 50 : 100;
    } else if (width < 1200) {
      return HiveManager.get("launcherWideMode") ? 20 : 50;
    } else if (width < 600) {
      return HiveManager.get("launcherWideMode") ? 10 : 20;
    }
  }

  return Expanded(
    child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(horizontal: _width()),
        child: SingleChildScrollView(
          child: Wrap(
              spacing: 18.0,
              children: applicationsData
                  .map<Widget>((e) => AppLauncherButton(
                        icon: "assets/images/icons/PNG/" + e.icon + ".png",
                        app: e.app,
                        label: e.appName,
                        appExists: e.appExists,
                        callback: toggleCallback,
                        color: e.color,
                        type: AppLauncherButtonType.Drawer,
                      ))
                  .toList()),
        )),
  );
}
