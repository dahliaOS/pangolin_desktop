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

import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/launcher/app_launcher_button.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class CompactLauncherOverlay extends ShellOverlay {
  static const String overlayId = 'compactlauncher';

  CompactLauncherOverlay({super.key}) : super(id: overlayId);

  @override
  _CompactLauncherOverlayState createState() => _CompactLauncherOverlayState();
}

class _CompactLauncherOverlayState
    extends ShellOverlayState<CompactLauncherOverlay> {
  final scrollController = ScrollController();
  final List<DesktopEntry> applications = [];

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    applications.clear();
    applications.addAll(ApplicationService.current.listApplications());

    applications.sort(
      (a, b) => a.getLocalizedName(context.locale).toLowerCase().compareTo(
            b.getLocalizedName(context.locale).toLowerCase(),
          ),
    );

    if (scrollController.hasClients) scrollController.jumpTo(0);
    controller.showing = true;
    animationController.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    controller.showing = false;
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (shouldHide) return const SizedBox();

    return Positioned(
      bottom: 56,
      left: 8,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          alignment: const FractionalOffset(0.025, 1.0),
          child: SurfaceLayer(
            shape: Constants.bigShape,
            height: 540,
            width: 474,
            outline: true,
            dropShadow: true,
            child: CompactLauncher(
              applications: applications,
              controller: scrollController,
            ),
          ),
        ),
      ),
    );
  }
}

class CompactLauncher extends StatelessWidget {
  final List<DesktopEntry> applications;
  final ScrollController? controller;

  const CompactLauncher({
    required this.applications,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          Column(
            children: [
              const QuickActionButton(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                leading: FlutterLogo(),
              ),
              const Spacer(),
              const QuickActionButton(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Icon(Icons.edit_rounded),
              ),
              QuickActionButton(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                leading: const Icon(Icons.settings_outlined),
                onPressed: () => ActionManager.openSettings(context),
              ),
              const QuickActionButton(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Icon(Icons.exit_to_app_rounded),
              ),
              QuickActionButton(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                  top: 8.0,
                ),
                leading: const Icon(Icons.power_settings_new_rounded),
                onPressed: () => ActionManager.showPowerMenu(context),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 402,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username),
                      const SizedBox(height: 2.0),
                      const Text(
                        "Local Account",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 460,
                width: 380,
                child: ListView.separated(
                  itemCount: applications.length,
                  itemBuilder: (context, index) => AppLauncherTile(
                    application: applications[index],
                  ),
                  controller: controller,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
