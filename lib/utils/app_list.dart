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

import 'package:Media/main.dart';
import 'package:calculator/calculator.dart';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:dahlia_clock/main.dart';
import 'package:files/main.dart';
import 'package:graft/main.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/error_window.dart';
import 'package:system_logs/main.dart';
import 'package:task_manager/monitor.dart';
import 'package:terminal/terminal-widget.dart';
import 'package:text_editor/editor.dart';
import 'package:web_browser/main.dart';
import 'package:welcome/main.dart';

Map<String, Application> applications = {
  "io.dahlia.settings": Application(
      app: Settings(),
      name: "Settings",
      iconName: "settings",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.calculator": Application(
      app: Calculator(),
      name: "Calculator",
      iconName: "calculator",
      category: ApplicationCategory.OFFICE,
      description: ""),
  "io.dahlia.terminal": Application(
      app: Terminal(),
      name: "Terminal",
      iconName: "terminal",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.editor": Application(
      app: TextEditorApp(),
      name: "Text Editor",
      iconName: "notes",
      category: ApplicationCategory.OFFICE,
      description: ""),
  "io.dahlia.graft": Application(
      app: Graft(),
      name: "Graft",
      iconName: "graft",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.web": Application(
      app: Browser(),
      name: "Web Browser",
      iconName: "web",
      category: ApplicationCategory.INTERNET,
      description: ""),
  "io.dahlia.files": Application(
      app: Files(),
      name: "Files",
      iconName: "files",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.media": Application(
      app: Media(),
      name: "Media",
      iconName: "photos",
      category: ApplicationCategory.MEDIA,
      description: ""),
  "io.dahlia.clock": Application(
      app: Clock(),
      name: "Clock",
      iconName: "clock",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.logs": Application(
      app: Logs(),
      name: "System Logs",
      iconName: "logs",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.welcome": Application(
      app: Welcome(),
      name: "Welcome",
      iconName: "welcome-info",
      category: ApplicationCategory.SYSTEM,
      description: ""),
  "io.dahlia.taskmanager": Application(
      app: Tasks(),
      name: "Task Manager",
      iconName: "task",
      category: ApplicationCategory.SYSTEM,
      description: ""),
};

Application? getApp(String packageName) {
  return applications[packageName];
}

Application get fallbackApp {
  return Application(app: ErrorWindow(), name: "Error");
}
