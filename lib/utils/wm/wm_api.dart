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
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/components/window/error_window.dart';
import 'package:pangolin/components/window/window_surface.dart';
import 'package:pangolin/components/window/window_toolbar.dart';
import 'package:pangolin/utils/data/database_manager.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:pangolin/utils/wm/wm.dart';

class WmAPI {
  late BuildContext context;
  WmAPI.of(this.context);

  late final WindowHierarchyController _windowHierarchy =
      WindowHierarchy.of(context, listen: false);

  late final MiscProvider _miscProvider =
      MiscProvider.of(context, listen: false);

  static WindowEntry windowEntry = WindowEntry(
    features: const [
      MinimizeWindowFeature(),
      GeometryWindowFeature(),
      ResizeWindowFeature(),
      SurfaceWindowFeature(),
      FocusableWindowFeature(),
      ToolbarWindowFeature(),
    ],
    properties: {
      GeometryWindowFeature.position: const Offset(32, 32),
      GeometryWindowFeature.size: const Size(1280, 720),
      ResizeWindowFeature.minSize: const Size(480, 360),
      SurfaceWindowFeature.elevation: 4.0,
      SurfaceWindowFeature.shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DatabaseManager.get("windowBorderRadius") ?? 12.0),
        ),
      ),
      SurfaceWindowFeature.background: const PangolinWindowSurface(),
      ToolbarWindowFeature.widget: const PangolinWindowToolbar(),
      ToolbarWindowFeature.size: 40.0,
    },
  );

  void popWindowEntry(String id) {
    _windowHierarchy.removeWindowEntry(id);
  }

  void pushWindowEntry(LiveWindowEntry entry) {
    _windowHierarchy.addWindowEntry(entry);
  }

  void openApp(String packageName) {
    final application = getApp(packageName);
    if (!application.canBeOpened) {
      return;
      // throw 'The app couldn not be opened';
    }
    final LiveWindowEntry _window = windowEntry.newInstance(
      application.app ?? const ErrorWindow(),
      {
        WindowEntry.title: application.name,
        WindowEntry.icon:
            AssetImage("assets/icons/${application.iconName}.png"),
        WindowExtras.stableId: packageName,
        GeometryWindowFeature.size: MediaQuery.of(context).size.width < 1920
            ? const Size(720, 480)
            : MediaQuery.of(context).size.width < 1921
                ? const Size(1280, 720)
                : const Size(1920, 1080),
      },
    );

    pushWindowEntry(_window);
  }

  void minimizeAll() {
    _miscProvider.minimizedWindowsCache = [];
    for (final LiveWindowEntry e in _windowHierarchy.entries) {
      if (e.registry.minimize.minimized) {
        _miscProvider.minimizedWindowsCache.add(e.registry.info.id);
      } else {
        e.registry.minimize.minimized = true;
      }
    }
  }

  void undoMinimizeAll() {
    for (final LiveWindowEntry e in _windowHierarchy.entries) {
      _miscProvider.minimizedWindowsCache.contains(e.registry.info.id)
          ? e.registry.minimize.minimized = true
          : e.registry.minimize.minimized = false;
    }
  }
}
