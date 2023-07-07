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
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/widgets/power_account_button.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';
import 'package:zenit_ui/zenit_ui.dart';

class AccountOverlay extends ShellOverlay {
  static const String overlayId = "account";

  AccountOverlay({super.key}) : super(id: overlayId);

  @override
  _AccountOverlayState createState() => _AccountOverlayState();
}

class _AccountOverlayState extends ShellOverlayState<AccountOverlay> {
  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await animationController.forward();
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    await animationController.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (shouldHide) return const SizedBox();

    return Stack(
      children: [
        //Wallpaper(),
        GestureDetector(
          onTap: () {
            controller.requestDismiss({});
          },
        ),
        Positioned(
          left: horizontalPadding(context, 330),
          right: horizontalPadding(context, 330),
          top: verticalPadding(context, 500),
          bottom: verticalPadding(context, 500),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              alignment: FractionalOffset.center,
              child: SurfaceLayer(
                outline: true,
                shape: Constants.bigShape,
                child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 328,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).surfaceColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Menu",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text("Choose what to do as user"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            PowerAccountMenuButton(
                              title: "Sign out",
                              icon: Icons.logout_rounded,
                              context: context,
                              onPressed: ActionManager.logout,
                            ),
                            PowerAccountMenuButton(
                              title: "Lock",
                              icon: Icons.lock_outline,
                              context: context,
                              onPressed: ActionManager.lock,
                            ),
                            PowerAccountMenuButton(
                              title: "Account Settings",
                              icon: Icons.settings_outlined,
                              context: context,
                              onPressed: () =>
                                  ActionManager.openSettings(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
