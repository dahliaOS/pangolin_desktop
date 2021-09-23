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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/desktop/shell.dart';

class PowerOverlay extends ShellOverlay {
  static const String overlayId = "power";

  PowerOverlay() : super(id: overlayId);

  @override
  _PowerOverlayState createState() => _PowerOverlayState();
}

class _PowerOverlayState extends State<PowerOverlay> with ShellOverlayState {
  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) {
    controller.showing = true;
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) {
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.showing) return SizedBox();

    return Stack(
      children: [
        //Wallpaper(),
        GestureDetector(
          onTap: () {
            controller.requestDismiss({});
          },
          child: BoxSurface(
            outline: false,
            dropShadow: true,
          ),
        ),
        Positioned(
          left: horizontalPadding(context, 320),
          right: horizontalPadding(context, 320),
          top: verticalPadding(context, 100),
          bottom: verticalPadding(context, 100),
          child: BoxContainer(
            borderRadius:
                CommonData.of(context).borderRadius(BorderRadiusType.BIG),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.BIG),
                      onTap: () {
                        SystemCalls().powerOff();
                        print("Powering off..");
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.power_settings_new,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.BIG),
                      onTap: () {
                        SystemCalls().restart();
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.replay,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.BIG),
                      onTap: () {
                        SystemCalls().terminal();
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.grid_3x3_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                //TODO: Once development phase is over, disable TTY access functionality. For now, sleep is not a priority.
                /* Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        SystemCalls().terminal();
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.brightness_2_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ),
      ],
    );
  }
}
