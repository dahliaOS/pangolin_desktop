/* /*
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
import 'package:pangolin/desktop/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/desktop/overlays/overview_overlay.dart';
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/desktop/overlays/quicksettings/quick_settings_overlay.dart';
import 'package:pangolin/desktop/overlays/search/search_overlay.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';

class OverlayManager {
  late BuildContext context;
  OverlayManager.of(this.context);

  // QuickSettings
  void openQuickSettings() {
    WmAPI.of(context).pushOverlayEntry(
      DismissibleOverlayEntry(
        uniqueId: "action_center",
        content: QuickSettingsOverlay(),
        background: _background(),
        duration: CommonData.of(context).animationDuration(),
        curve: CommonData.of(context).animationCurve(),
      ),
    );
  }

  // Search
  void openSearch(String prefix) {
    WmAPI.of(context).pushOverlayEntry(
      DismissibleOverlayEntry(
        uniqueId: "search",
        content: SearchOverlay(
          text: prefix,
        ),
        background: _background(),
        duration: CommonData.of(context).animationDuration(),
        curve: CommonData.of(context).animationCurve(),
      ),
    );
  }

  // Overview
  void openOverview() {
    WmAPI.of(context).pushOverlayEntry(
      DismissibleOverlayEntry(
        uniqueId: "overview",
        content: OverviewOverlay(),
        background: _background(),
        duration: CommonData.of(context).animationDuration(),
        curve: CommonData.of(context).animationCurve(),
      ),
    );
  }

  // Launcher
  void openLauncher() {
    WmAPI.of(context).pushOverlayEntry(
      DismissibleOverlayEntry(
        uniqueId: "launcher",
        content: LauncherOverlay(),
        background: _background(),
        duration: CommonData.of(context).animationDuration(),
        curve: CommonData.of(context).animationCurve(),
      ),
    );
  }

  // Power Menu
  void openPowerMenu() {
    closeCurrentOverlay();
    WmAPI.of(context).pushOverlayEntry(
      DismissibleOverlayEntry(
        uniqueId: "power_menu",
        content: PowerOverlay(),
        duration: CommonData.of(context).animationDuration(),
        curve: CommonData.of(context).animationCurve(),
      ),
    );
  }

  // Close currently active overlay
  void closeCurrentOverlay() {
    WmAPI.of(context).popCurrentOverlayEntry();
  }

  // General Background
  BoxSurface _background() => BoxSurface(
        color: Colors.black.withOpacity(0.2),
        margin: CommonData.of(context).taskbarMargin(),
        useBlur: true,
        customBlur: 2,
      );
}
 */
