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

import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class PowerOverlay extends ShellOverlay {
  static const String overlayId = "power";

  PowerOverlay({super.key}) : super(id: overlayId);

  @override
  _PowerOverlayState createState() => _PowerOverlayState();
}

class _PowerOverlayState extends State<PowerOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: Constants.animationDuration,
    );
    ac.forward();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await ac.forward();
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.showing) return const SizedBox();

    final Animation<double> animation = CurvedAnimation(
      parent: ac,
      curve: Constants.animationCurve,
    );

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
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                alignment: FractionalOffset.center,
                child: Material(
                  color: Colors.transparent,
                  child: BoxSurface(
                    dropShadow: true,
                    shape: Constants.bigShape,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strings.powerOverlay.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(strings.powerOverlay.subtitle),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 224,
                          color: context.theme.backgroundColor.op(0.35),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _powerMenuButton(
                                  strings.powerOverlay.poweroff,
                                  Icons.power_settings_new_rounded,
                                  context,
                                  onPressed: () => ActionManager.powerOff(),
                                ),
                                _powerMenuButton(
                                  strings.powerOverlay.sleep,
                                  Icons.brightness_4_outlined,
                                  context,
                                  onPressed: () => ActionManager.suspend(),
                                ),
                                _powerMenuButton(
                                  strings.powerOverlay.restart,
                                  Icons.replay_rounded,
                                  context,
                                  onPressed: () => ActionManager.reboot(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _powerMenuButton(
    String title,
    IconData icon,
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: 280,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: Constants.smallShape,
          color: context.theme.accent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: context.theme.foregroundColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: context.theme.textTheme.button?.copyWith(
                      fontSize: 16,
                      color: context.theme.foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
