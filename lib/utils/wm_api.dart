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
import 'package:pangolin/widgets/error_window.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class WmAPI {
  late BuildContext context;
  WmAPI(this.context);
  WmAPI.of(this.context);
  void popOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .popOverlayEntry(entry);
  }

  void popWindowEntry(WindowEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .popWindowEntry(entry);
  }

  void pushOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .pushOverlayEntry(entry);
  }

  void pushWindowEntry(WindowEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .pushWindowEntry(entry);
  }

  void openApp(String packageName) {
    if (applications.containsKey(packageName)) {
      pushWindowEntry(WindowEntry.withDefaultToolbar(
        content: applications[packageName]!.app ?? ErrorWindow(),
        initialSize: Size(1280, 720),
        icon: AssetImage(
            "assets/icons/${applications[packageName]!.iconName}.png"),
        title: applications[packageName]!.name,
      ));
    } else {
      pushWindowEntry(WindowEntry.withDefaultToolbar(
          content: ErrorWindow(),
          title: "Error",
          initialSize: Size(1280, 720)));
    }
  }
}
