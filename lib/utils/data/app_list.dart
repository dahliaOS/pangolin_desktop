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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/other/webapp_manager.dart';

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
