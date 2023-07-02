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
import 'package:pangolin/components/overlays/notifications/queue.dart';
import 'package:pangolin/components/taskbar/app_list.dart';
import 'package:pangolin/components/taskbar/launcher.dart';
import 'package:pangolin/components/taskbar/notifications.dart';
import 'package:pangolin/components/taskbar/overview.dart';
import 'package:pangolin/components/taskbar/quick_settings.dart';
import 'package:pangolin/components/taskbar/search.dart';
import 'package:pangolin/components/taskbar/show_desktop.dart';
import 'package:pangolin/components/taskbar/taskbar.dart';
import 'package:pangolin/components/taskbar/tray.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/wm/wm.dart';

class Shell extends StatefulWidget {
  final List<ShellOverlay> overlays;

  const Shell({
    required this.overlays,
    super.key,
  });

  @override
  ShellState createState() => ShellState();
}

class ShellState extends State<Shell> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ShellService.current.registerShell(this, widget.overlays);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShellService.current.notifyStartupComplete();
    });
  }

  void notify() {
    setState(() {});
  }

  void showInformativeDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message, style: const TextStyle(fontFamily: "monospace")),
        shape: Constants.bigShape,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Listener(
              onPointerDown: (event) {
                ShellService.current.dismissEverything();
              },
              behavior: HitTestBehavior.translucent,
            ),
          ),
          const Taskbar(
            leading: [
              LauncherButton(),
              SearchButton(),
              OverviewButton(),
            ],
            centerRelativeToScreen: true,
            center: [AppListElement()],
            trailing: [
              //TODO: here is the keyboard button
              //KeyboardButton(),
              TrayMenuButton(),
              QuickSettingsButton(),
              NotificationsButton(),
              ShowDesktopButton(),
            ],
          ),
          ...widget.overlays,
          Positioned(
            width: 420,
            right: WindowHierarchy.of(context).wmInsets.right + 8,
            bottom: WindowHierarchy.of(context).wmInsets.bottom + 8,
            child: const NotificationQueue(),
          ),
        ],
      ),
    );
  }
}
