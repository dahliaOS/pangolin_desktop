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
import 'dart:io';

import 'package:app_store/main.dart';
import 'package:calculator/calculator.dart';
import 'package:dahlia_clock/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graft/main.dart';
import 'package:media/main.dart';
import 'package:pangolin/components/settings/settings.dart';
import 'package:pangolin/utils/data/models/application.dart';
// Stub import
import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:terminal/main.dart';
// ignore: duplicate_import
import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:files/main.dart';
import 'package:pangolin/utils/other/webapp_manager.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:system_logs/main.dart';
import 'package:task_manager/monitor.dart';
import 'package:text_editor/editor.dart';
import 'package:welcome/main.dart';

List<Application> get applications => <Application>[
      Application(
        color: Colors.blue.shade700,
        packageName: "io.dahlia.store",
        app: webAppManager(),
        name: "Web App Manager",
        description: "Install and manage web apps",
        iconName: "store",
        category: ApplicationCategory.internet,
        supportsWeb: false,
      ),
      Application(
        color: Colors.transparent,
        packageName: "io.dahlia.settings",
        app: const Settings(),
        name: strings.apps.settings,
        description: strings.apps.settingsDescription,
        iconName: "settings",
        category: ApplicationCategory.system,
      ),
      Application(
        color: Colors.green,
        packageName: "io.dahlia.calculator",
        app: Calculator(),
        name: strings.apps.calculator,
        description: strings.apps.calculatorDescription,
        iconName: "calculator",
        category: ApplicationCategory.office,
      ),
      Application(
        color: Colors.grey.shade900,
        packageName: "io.dahlia.terminal",
        app: const Terminal(),
        name: strings.apps.terminal,
        description: strings.apps.terminalDescription,
        iconName: "terminal",
        category: ApplicationCategory.system,
        supportsWeb: false,
      ),
      Application(
        color: Colors.amber.shade800,
        packageName: "io.dahlia.editor",
        app: TextEditorApp(),
        name: strings.apps.notes,
        description: strings.apps.notesDescription,
        iconName: "notes",
        category: ApplicationCategory.office,
      ),
      Application(
        color: Colors.blue.shade800,
        packageName: "io.dahlia.graft",
        app: Graft(),
        name: strings.apps.containers,
        description: strings.apps.containersDescription,
        iconName: "graft",
        category: ApplicationCategory.system,
      ),
      /*Application(
    color: Colors.deepOrange,
    packageName: "io.dahlia.web",
    app: Browser(),
    name: strings.apps.web,
    description: strings.apps.webDescription,
    iconName: "web",
    category: ApplicationCategory.internet,
  ),*/
      Application(
        color: Colors.deepOrange.shade800,
        packageName: "io.dahlia.files",
        app: const Files(),
        name: strings.apps.files,
        description: strings.apps.filesDescription,
        iconName: "files",
        category: ApplicationCategory.system,
        supportsWeb: false,
      ),
      Application(
        color: Colors.blueAccent,
        packageName: "io.dahlia.media",
        app: Media(),
        name: strings.apps.media,
        description: strings.apps.mediaDescription,
        iconName: "photos",
        category: ApplicationCategory.media,
      ),
      Application(
        color: Colors.lightBlue,
        packageName: "io.dahlia.clock",
        app: Clock(),
        name: strings.apps.clock,
        description: strings.apps.clockDescription,
        iconName: "clock",
        category: ApplicationCategory.system,
      ),
      Application(
        color: Colors.red.shade800,
        packageName: "io.dahlia.logs",
        app: Logs(),
        name: strings.apps.systemlogs,
        description: strings.apps.systemlogsDescription,
        iconName: "logs",
        category: ApplicationCategory.system,
      ),
      Application(
        color: Colors.white,
        appBarTextColor: Colors.black,
        packageName: "io.dahlia.welcome",
        app: const Welcome(),
        name: strings.apps.welcome,
        description: strings.apps.welcomeDescription,
        iconName: "welcome-info",
        category: ApplicationCategory.system,
      ),
      Application(
        color: Colors.white,
        appBarTextColor: Colors.black,
        packageName: "io.dahlia.appstore",
        app: const AppStore(),
        name: strings.apps.appStore,
        description: strings.apps.appStoreDescription,
        iconName: "store",
        category: ApplicationCategory.system,
      ),
      Application(
        color: Colors.cyan.shade900,
        packageName: "io.dahlia.taskmanager",
        app: Tasks(),
        name: strings.apps.taskmanager,
        description: strings.apps.taskmanagerDescription,
        iconName: "task",
        category: ApplicationCategory.system,
      ),
    ];

Application getApp(String packageName) {
  return applications
      .firstWhere((element) => element.packageName == packageName);
}

Widget getAppIcon({
  String? iconPath,
  bool usesRuntime = false,
  double height = 24,
}) {
  return Image(
    image: getAppIconProvider(
      usesRuntime: usesRuntime,
      iconPath: iconPath,
    ),
    height: height,
  );
}

ImageProvider getAppIconProvider({
  String? iconPath,
  bool usesRuntime = false,
}) {
  if (iconPath == null) {
    return const AssetImage('assets/icons/null.png');
  }
  if (usesRuntime == true) {
    return FileImage(File(iconPath));
  } else {
    return AssetImage("assets/icons/$iconPath.png");
  }
}

extension AppWebExtension on Application {
  bool get canBeOpened {
    if (kIsWeb) return supportsWeb;
    return true;
  }
}
