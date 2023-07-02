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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/desktop/wallpaper.dart';
import 'package:pangolin/components/overlays/account_overlay.dart';
import 'package:pangolin/components/overlays/launcher/compact_launcher_overlay.dart';
import 'package:pangolin/components/overlays/notifications/overlay.dart';
import 'package:pangolin/components/overlays/overview_overlay.dart';
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/overlays/search/search_overlay.dart';
import 'package:pangolin/components/overlays/tray_overlay.dart';
import 'package:pangolin/components/overlays/welcome_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/wm/layout.dart';
import 'package:pangolin/utils/wm/wm.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  static const shellEntry = WindowEntry(
    features: [],
    layoutInfo: FreeformLayoutInfo(
      alwaysOnTop: true,
      alwaysOnTopMode: AlwaysOnTopMode.systemOverlay,
    ),
    properties: {
      WindowEntry.title: "shell",
      WindowExtras.stableId: "shell",
      WindowEntry.showOnTaskbar: false,
      WindowEntry.icon: null,
    },
  );

  @override
  void initState() {
    super.initState();
    ShellService.current.onShellReadyCallback(() {
      if (CustomizationService.current.showWelcomeScreen) {
        ShellService.current.showOverlay("welcome");
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WindowManagerService.current.push(
        shellEntry.newInstance(
          content: Shell(
            overlays: [
              CompactLauncherOverlay(),
              SearchOverlay(),
              OverviewOverlay(),
              QuickSettingsOverlay(),
              PowerOverlay(),
              AccountOverlay(),
              WelcomeOverlay(),
              NotificationsOverlay(),
              TrayMenuOverlay(),
            ],
          ),
        ),
      );
      // ignore: avoid_print
      print("Initilized Desktop Shell");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WindowManagerService.current.controller.wmInsets =
        const EdgeInsets.only(bottom: 48);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          const WallpaperLayer(),
          Positioned.fill(
            child: WindowHierarchy(
              controller: WindowManagerService.current.controller,
              layoutDelegate: const PangolinLayoutDelegate(),
            ),
          ),
        ],
      ),
    );
  }
}
