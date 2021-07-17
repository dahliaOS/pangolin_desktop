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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/widgets/error_window.dart';
import 'package:pangolin/widgets/window_surface.dart';
import 'package:pangolin/widgets/window_toolbar.dart';
import 'package:utopia_wm/wm_new.dart';

class WmAPI {
  static const WindowEntry windowEntry = WindowEntry(
    features: [
      MinimizeWindowFeature(),
      GeometryWindowFeature(),
      ResizeWindowFeature(),
      SurfaceWindowFeature(),
      FocusableWindowFeature(),
      ToolbarWindowFeature(),
    ],
    properties: {
      GeometryWindowFeature.position: Offset(32, 32),
      GeometryWindowFeature.size: Size(1280, 720),
      ResizeWindowFeature.minSize: Size(480, 360),
      SurfaceWindowFeature.elevation: 4.0,
      SurfaceWindowFeature.shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      SurfaceWindowFeature.background: PangolinWindowSurface(),
      ToolbarWindowFeature.widget: PangolinWindowToolbar(),
      ToolbarWindowFeature.size: 40.0,
    },
  );
  final BuildContext context;
  const WmAPI.of(this.context);

  /* void popOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .popOverlayEntry(entry);
  } */

  /*  void popCurrentOverlayEntry() {
    if (Provider.of<WindowHierarchyState>(context, listen: false)
        .overlays
        .isNotEmpty) {
      Provider.of<WindowHierarchyState>(context, listen: false).popOverlayEntry(
          Provider.of<DismissibleOverlayEntry>(context, listen: false));
      // ignore: invalid_use_of_protected_member
      ScaffoldMessenger.of(context).setState(() {});
    }
  } */

  void popWindowEntry(String id) {
    WindowHierarchy.of(context, listen: false).removeWindowEntry(id);
  }

  /* void pushOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .pushOverlayEntry(entry);
  } */

  void pushWindowEntry(LiveWindowEntry entry) {
    WindowHierarchy.of(context, listen: false).addWindowEntry(entry);
  }

  void openApp(String packageName) {
    final LiveWindowEntry _window = windowEntry.newInstance(
      getApp(packageName).app ?? ErrorWindow(),
      {
        WindowEntry.title: getApp(packageName).name,
        WindowEntry.icon:
            AssetImage("assets/icons/${getApp(packageName).iconName}.png"),
        WindowExtras.stableId: packageName,
        GeometryWindowFeature.size: MediaQuery.of(context).size.width < 1920
            ? Size(720, 480)
            : MediaQuery.of(context).size.width < 1921
                ? Size(1280, 720)
                : Size(1920, 1080),
      },
    );

    pushWindowEntry(_window);
  }
}
