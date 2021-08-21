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

import 'package:calculator/calculator.dart';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:dahlia_clock/main.dart';
import 'package:files/main.dart';
import 'package:flutter/material.dart';
import 'package:graft/main.dart';
import 'package:media/main.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/error_window.dart';
import 'package:system_logs/main.dart';
import 'package:task_manager/monitor.dart';
import 'package:terminal/main.dart';
import 'package:text_editor/editor.dart';
import 'package:web_browser/main.dart';
import 'package:welcome/main.dart';

List<Application> applications = [
  Application(
    color: Colors.deepOrange.shade500,
    packageName: "io.dahlia.settings",
    app: Settings(),
    name: "Settings",
    iconName: "settings",
    category: ApplicationCategory.SYSTEM,
    description: "Change system setting",
  ),
  Application(
      color: Colors.green,
      packageName: "io.dahlia.calculator",
      app: Calculator(),
      name: "Calculator",
      iconName: "calculator",
      category: ApplicationCategory.OFFICE,
      description: "Solve mathematic calculations"),
  Application(
      color: Colors.grey,
      packageName: "io.dahlia.terminal",
      app: Terminal(),
      name: "Terminal",
      iconName: "terminal",
      category: ApplicationCategory.SYSTEM,
      description: "Execute commands",
      breaksWeb: true),
  Application(
      color: Colors.amber,
      packageName: "io.dahlia.editor",
      app: TextEditorApp(),
      name: "Text Editor",
      iconName: "notes",
      category: ApplicationCategory.OFFICE,
      description: "Write texts and notes"),
  Application(
      color: Colors.blue,
      packageName: "io.dahlia.graft",
      app: Graft(),
      name: "Graft",
      iconName: "graft",
      category: ApplicationCategory.SYSTEM,
      description: "Manager your containers"),
  Application(
      color: Colors.deepOrange,
      packageName: "io.dahlia.web",
      app: Browser(),
      name: "Web Browser",
      iconName: "web",
      category: ApplicationCategory.INTERNET,
      description: "Search and browse the web"),
  Application(
      color: Colors.deepOrange,
      packageName: "io.dahlia.files",
      app: Files(),
      name: "Files",
      iconName: "files",
      category: ApplicationCategory.SYSTEM,
      description: "Browse your local files",
      breaksWeb: true),
  Application(
      color: Colors.blueAccent,
      packageName: "io.dahlia.media",
      app: Media(),
      name: "Media",
      iconName: "photos",
      category: ApplicationCategory.MEDIA,
      description: "View photos and play videos"),
  Application(
      color: Colors.lightBlue,
      packageName: "io.dahlia.clock",
      app: Clock(),
      name: "Clock",
      iconName: "clock",
      category: ApplicationCategory.SYSTEM,
      description: "Manage timers"),
  Application(
      color: Colors.red,
      packageName: "io.dahlia.logs",
      app: Logs(),
      name: "System Logs",
      iconName: "logs",
      category: ApplicationCategory.SYSTEM,
      description: "Check the system logs"),
  Application(
      color: Colors.lime,
      packageName: "io.dahlia.welcome",
      app: Welcome(),
      name: "Welcome",
      iconName: "welcome-info",
      category: ApplicationCategory.SYSTEM,
      description: "Welcome screen with more information"),
  Application(
      color: Colors.cyanAccent,
      packageName: "io.dahlia.taskmanager",
      app: Tasks(),
      name: "Task Manager",
      iconName: "task",
      category: ApplicationCategory.SYSTEM,
      description: "Manager running apps"),
];

Application getApp(String packageName) {
  return applications
      .firstWhere((element) => element.packageName == packageName);
}

Application get fallbackApp {
  return Application(
      app: ErrorWindow(), name: "Error", packageName: "io.dahlia.error");
}
