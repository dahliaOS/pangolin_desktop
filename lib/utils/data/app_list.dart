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

import 'package:calculator/calculator.dart';
import 'package:dahlia_clock/main.dart';
import 'package:flutter/foundation.dart';
import 'package:graft/main.dart';
import 'package:media/main.dart';
import 'package:pangolin/components/settings/settings.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
// Stub import
import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:terminal/main.dart';
// ignore: duplicate_import
import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:files/main.dart';
import 'package:pangolin/utils/other/webapp_manager.dart';
import 'package:system_logs/main.dart';
import 'package:task_manager/monitor.dart';
import 'package:text_editor/editor.dart';
import 'package:welcome/main.dart';

List<Application> applications = [
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
    name: LSX.apps.settings,
    description: LSX.apps.settingsDescription,
    iconName: "settings",
    category: ApplicationCategory.system,
  ),
  Application(
    color: Colors.green,
    packageName: "io.dahlia.calculator",
    app: Calculator(),
    name: LSX.apps.calculator,
    description: LSX.apps.calculatorDescription,
    iconName: "calculator",
    category: ApplicationCategory.office,
  ),
  Application(
    color: Colors.grey.shade900,
    packageName: "io.dahlia.terminal",
    app: const Terminal(),
    name: LSX.apps.terminal,
    description: LSX.apps.terminalDescription,
    iconName: "terminal",
    category: ApplicationCategory.system,
    supportsWeb: false,
  ),
  Application(
    color: Colors.amber.shade800,
    packageName: "io.dahlia.editor",
    app: TextEditorApp(),
    name: LSX.apps.notes,
    description: LSX.apps.notesDescription,
    iconName: "notes",
    category: ApplicationCategory.office,
  ),
  Application(
    color: Colors.blue.shade800,
    packageName: "io.dahlia.graft",
    app: Graft(),
    name: LSX.apps.containers,
    description: LSX.apps.containersDescription,
    iconName: "graft",
    category: ApplicationCategory.system,
  ),
  /*Application(
    color: Colors.deepOrange,
    packageName: "io.dahlia.web",
    app: Browser(),
    name: LSX.apps.web,
    description: LSX.apps.webDescription,
    iconName: "web",
    category: ApplicationCategory.internet,
  ),*/
  Application(
    color: Colors.deepOrange.shade800,
    packageName: "io.dahlia.files",
    app: const Files(),
    name: LSX.apps.files,
    description: LSX.apps.filesDescription,
    iconName: "files",
    category: ApplicationCategory.system,
    supportsWeb: false,
  ),
  Application(
    color: Colors.blueAccent,
    packageName: "io.dahlia.media",
    app: Media(),
    name: LSX.apps.media,
    description: LSX.apps.mediaDescription,
    iconName: "photos",
    category: ApplicationCategory.media,
  ),
  Application(
    color: Colors.lightBlue,
    packageName: "io.dahlia.clock",
    app: Clock(),
    name: LSX.apps.clock,
    description: LSX.apps.clockDescription,
    iconName: "clock",
    category: ApplicationCategory.system,
  ),
  Application(
    color: Colors.red.shade800,
    packageName: "io.dahlia.logs",
    app: Logs(),
    name: LSX.apps.systemlogs,
    description: LSX.apps.systemlogsDescription,
    iconName: "logs",
    category: ApplicationCategory.system,
  ),
  Application(
    color: Colors.white,
    appBarTextColor: Colors.black,
    packageName: "io.dahlia.welcome",
    app: const Welcome(),
    name: LSX.apps.welcome,
    description: LSX.apps.welcomeDescription,
    iconName: "welcome-info",
    category: ApplicationCategory.system,
  ),
  Application(
    color: Colors.cyan.shade900,
    packageName: "io.dahlia.taskmanager",
    app: Tasks(),
    name: LSX.apps.taskmanager,
    description: LSX.apps.taskmanagerDescription,
    iconName: "task",
    category: ApplicationCategory.system,
  ),
];

Application getApp(String packageName) {
  return applications
      .firstWhere((element) => element.packageName == packageName);
}

Widget getAppIcon(bool usesRuntime, String? iconPath, double height) {
  return Image(
    image: getAppIconProvider(usesRuntime, iconPath),
    height: height,
  );
}

ImageProvider getAppIconProvider(bool usesRuntime, String? iconPath) {
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
