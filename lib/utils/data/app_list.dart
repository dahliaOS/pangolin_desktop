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

import 'package:pangolin/utils/data/models/application.dart';

import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:files/main.dart';
// ignore: duplicate_import
import 'package:pangolin/utils/other/apps_stub.dart'
    if (dart.library.io) 'package:terminal/main.dart';

import 'package:calculator/calculator.dart';
import 'package:dahlia_clock/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graft/main.dart';
import 'package:media/main.dart';
import 'package:pangolin/components/settings/settings.dart';
import '../../components/window/error_window.dart';
import 'package:system_logs/main.dart';
import 'package:task_manager/monitor.dart';
import 'package:text_editor/editor.dart';
import 'package:web_browser/main.dart';
import 'dart:io';
import 'package:welcome/main.dart';
import 'dap_index.dart';

List<Application> applications = [
  Application(
    color: Colors.transparent,
    packageName: "io.dahlia.settings",
    app: Settings(),
    name: "Settings",
    iconName: "settings",
    category: ApplicationCategory.system,
    description: "Manage and customize the system",
  ),
  Application(
      color: Colors.green,
      packageName: "io.dahlia.calculator",
      app: Calculator(),
      name: "Calculator",
      iconName: "calculator",
      category: ApplicationCategory.office,
      description: "Perform arithmetic and scientific calculations"),
  Application(
      color: Colors.grey.shade900,
      packageName: "io.dahlia.terminal",
      app: Terminal(),
      name: "Terminal",
      iconName: "terminal",
      category: ApplicationCategory.system,
      description: "Access the system shell",
      supportsWeb: false),
  Application(
      color: Colors.amber.shade800,
      packageName: "io.dahlia.editor",
      app: TextEditorApp(),
      name: "Text Editor",
      iconName: "notes",
      category: ApplicationCategory.office,
      description: "View and edit documents"),
  Application(
      color: Colors.blue.shade800,
      packageName: "io.dahlia.graft",
      app: Graft(),
      name: "Graft",
      iconName: "graft",
      category: ApplicationCategory.system,
      description: "Manage virtual machines and containers"),
  Application(
      color: Colors.deepOrange,
      packageName: "io.dahlia.web",
      app: Browser(),
      name: "Web Browser",
      iconName: "web",
      category: ApplicationCategory.internet,
      description: "Browse the web"),
  Application(
      color: Colors.deepOrange.shade800,
      packageName: "io.dahlia.files",
      app: Files(),
      name: "Files",
      iconName: "files",
      category: ApplicationCategory.system,
      description: "Browse and manage files",
      supportsWeb: false),
  Application(
      color: Colors.blueAccent,
      packageName: "io.dahlia.media",
      app: Media(),
      name: "Media",
      iconName: "photos",
      category: ApplicationCategory.media,
      description: "View and edit media"),
  Application(
      color: Colors.lightBlue,
      packageName: "io.dahlia.clock",
      app: Clock(),
      name: "Clock",
      iconName: "clock",
      category: ApplicationCategory.system,
      description: "Manage timers and clocks"),
  Application(
      color: Colors.red.shade800,
      packageName: "io.dahlia.logs",
      app: Logs(),
      name: "System Logs",
      iconName: "logs",
      category: ApplicationCategory.system,
      description: "View and report system information"),
  Application(
      color: Colors.white,
      appBarTextColor: Colors.black,
      packageName: "io.dahlia.welcome",
      app: Welcome(),
      name: "Welcome",
      iconName: "welcome-info",
      category: ApplicationCategory.system,
      description: "Get started with dahliaOS"),
  Application(
      color: Colors.cyan.shade900,
      packageName: "io.dahlia.taskmanager",
      app: Tasks(),
      name: "Task Manager",
      iconName: "task",
      category: ApplicationCategory.system,
      description: "View and manage processes"),
];

Application getApp(String packageName) {
  return applications
      .firstWhere((element) => element.packageName == packageName);
}

Application get fallbackApp {
  return Application(
    color: Colors.red,
    app: ErrorWindow(),
    name: "Error",
    packageName: "io.dahlia.error",
  );
}

extension AppWebExtension on Application {
  bool get canBeOpened {
    if (kIsWeb) return supportsWeb;
    return true;
  }
}
