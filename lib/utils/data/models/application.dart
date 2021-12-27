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
import 'package:flutter/widgets.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/wm/wm_api.dart';

class Application {
  final String? name, version, description;
  final String packageName;
  final Widget? app;
  final ApplicationCategory? category;
  final bool isTest;
  final String? iconName;
  final Color color;
  final bool supportsWeb;
  Application(
      {required this.app,
      required this.packageName,
      this.category,
      this.description,
      this.iconName,
      required this.name,
      required this.color,
      this.isTest = false,
      this.version,
      this.supportsWeb = true});
  const Application.testing(
      {required this.app,
      required this.packageName,
      this.category = ApplicationCategory.testing,
      this.description = "TESING APP",
      this.iconName,
      required this.name,
      this.isTest = true,
      required this.color,
      this.version = "TEST",
      this.supportsWeb = true});

  void launch(BuildContext context) {
    Shell.of(context, listen: false).dismissEverything();
    WmAPI.of(context).openApp(packageName);
  }
}

enum ApplicationCategory {
  internet,
  media,
  gaming,
  development,
  system,
  office,
  testing
}
