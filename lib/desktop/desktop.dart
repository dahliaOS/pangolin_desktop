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
import 'package:pangolin/desktop/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/desktop/overlays/overview_overlay.dart';
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/desktop/overlays/quicksettings/quick_settings_overlay.dart';
import 'package:pangolin/desktop/overlays/search/search_overlay.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/utils/preference_extension.dart';

// ignore: must_be_immutable
class Desktop extends StatefulWidget {
  static final WindowHierarchyController wmController =
      WindowHierarchyController();

  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  static const shellEntry = WindowEntry(
    features: [],
    properties: {
      WindowEntry.title: "shell",
      WindowExtras.stableId: "shell",
      WindowEntry.showOnTaskbar: false,
      WindowEntry.icon: null,
      WindowEntry.alwaysOnTop: true,
      WindowEntry.alwaysOnTopMode: AlwaysOnTopMode.systemOverlay,
    },
  );
  static const wallpaperEntry = WindowEntry(
    features: [WallpaperWindowFeature()],
    properties: {
      WindowEntry.showOnTaskbar: false,
      WindowEntry.icon: null,
      WindowEntry.title: "wallpaper",
    },
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Desktop.wmController.addWindowEntry(wallpaperEntry.newInstance());
      Desktop.wmController.addWindowEntry(
        shellEntry.newInstance(Shell(overlays: [
          LauncherOverlay(),
          SearchOverlay(),
          OverviewOverlay(),
          QuickSettingsOverlay(),
          PowerOverlay(),
        ])),
      );
      print("Initilized Desktop Shell");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _pref = Provider.of<PreferenceProvider>(context, listen: false);
    Desktop.wmController.wmInsets = EdgeInsets.only(
      left: _pref.isTaskbarLeft ? 48 : 0,
      top: _pref.isTaskbarTop ? 48 : 0,
      right: _pref.isTaskbarRight ? 48 : 0,
      bottom: _pref.isTaskbarBottom ? 48 : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);

    return SizedBox.expand(
      child: WindowHierarchy(
        controller: Desktop.wmController,
      ),
    );
  }
}
