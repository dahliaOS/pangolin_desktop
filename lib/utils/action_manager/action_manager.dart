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

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:pangolin/components/overlays/account_overlay.dart';
import 'package:pangolin/components/overlays/launcher/compact_launcher_overlay.dart';
import 'package:pangolin/components/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:pangolin/utils/wm/wm_api.dart';

class ActionManager {
  const ActionManager._();

  static Future<void> showPowerMenu(BuildContext context) async {
    final shell = Shell.of(context, listen: false);
    shell.dismissEverything();
    await Future.delayed(CommonData.of(context).animationDuration());
    shell.showOverlay(
      PowerOverlay.overlayId,
      dismissEverything: false,
    );
    // ignore: invalid_use_of_protected_member
    ScaffoldMessenger.of(context).setState(() {});
  }

  static Future<void> showAccountMenu(BuildContext context) async {
    final shell = Shell.of(context, listen: false);
    shell.dismissEverything();
    await Future.delayed(CommonData.of(context).animationDuration());
    shell.showOverlay(
      AccountOverlay.overlayId,
      dismissEverything: false,
    );
    // ignore: invalid_use_of_protected_member
    ScaffoldMessenger.of(context).setState(() {});
  }

  static Future<void> switchLauncher(BuildContext context) async {
    final shell = Shell.of(context, listen: false);
    final MiscProvider _miscProvider = MiscProvider.of(context, listen: false);
    shell.dismissEverything();
    _miscProvider.compactLauncher = !_miscProvider.compactLauncher;
    await Future.delayed(CommonData.of(context).animationDuration());
    shell.showOverlay(
      _miscProvider.compactLauncher
          ? CompactLauncherOverlay.overlayId
          : LauncherOverlay.overlayId,
    );
  }

  static Future<void> openSettings(BuildContext context) async {
    final shell = Shell.of(context, listen: false);
    shell.dismissEverything();
    await Future.delayed(const Duration(milliseconds: 150));
    WmAPI.of(context).openApp("io.dahlia.settings");
    // ignore: invalid_use_of_protected_member
    ScaffoldMessenger.of(context).setState(() {});
  }

  static void powerOff() {
    if (Platform.isLinux) {
      Process.run("poweroff", []);
    } else {
      print("Not supported on this Platform");
    }
  }

  static void reboot() {
    if (Platform.isLinux) {
      Process.run("reboot", []);
    } else {
      print("Not supported on this Platform");
    }
  }

  static void suspend() {}

  static void lock() {}

  static void logout() {}
}
