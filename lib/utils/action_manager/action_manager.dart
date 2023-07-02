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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/account_overlay.dart';
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/shell.dart';

class ActionManager {
  const ActionManager._();

  static ShellService get _shell => ShellService.current;

  static Future<void> showPowerMenu(BuildContext context) async {
    _shell.dismissEverything();
    await Future.delayed(Constants.animationDuration);
    _shell.showOverlay(
      PowerOverlay.overlayId,
      dismissEverything: false,
    );
  }

  static Future<void> showAccountMenu(BuildContext context) async {
    _shell.dismissEverything();
    await Future.delayed(Constants.animationDuration);
    _shell.showOverlay(
      AccountOverlay.overlayId,
      dismissEverything: false,
    );
  }

  static void openSettings(BuildContext context) {
    _shell.dismissEverything();
    ApplicationService.current.startApp("io.dahlia.settings");
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
