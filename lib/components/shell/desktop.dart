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

import 'package:pangolin/components/overlays/launcher/compact_launcher_overlay.dart';
import 'package:pangolin/components/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/components/overlays/overview_overlay.dart';
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/overlays/search/search_overlay.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'shell.dart';
import 'package:pangolin/components/desktop/wallpaper.dart';

class Desktop extends StatefulWidget {
  static final WindowHierarchyController wmController =
      WindowHierarchyController();

  const Desktop({Key? key}) : super(key: key);

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
          CompactLauncherOverlay(),
          SearchOverlay(),
          OverviewOverlay(),
          QuickSettingsOverlay(),
          PowerOverlay(),
        ])),
      );
      // ignore: avoid_print
      print("Initilized Desktop Shell");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _customizationProvider = CustomizationProvider.of(context);
    Desktop.wmController.wmInsets = EdgeInsets.only(
      left: _customizationProvider.isTaskbarLeft ? 48 : 0,
      top: _customizationProvider.isTaskbarTop ? 48 : 0,
      right: _customizationProvider.isTaskbarRight ? 48 : 0,
      bottom: _customizationProvider.isTaskbarBottom ? 48 : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: WindowHierarchy(
        controller: Desktop.wmController,
      ),
    );
  }
}
