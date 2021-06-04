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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';

class PowerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Wallpaper(),
        GestureDetector(
          onTap: () {
            WmAPI.of(context).popCurrentOverlayEntry();
            //setState(() {});
          },
          child: BoxContainer(
            useAccentBG: true,
            color: Theme.of(context).backgroundColor.withOpacity(0.5),
            useBlur: true,
          ),
        ),
        Positioned(
            left: horizontalPadding(context, 320),
            right: horizontalPadding(context, 320),
            top: verticalPadding(context, 100),
            bottom: verticalPadding(context, 100),
            child: BoxContainer(
              useSystemOpacity: true,
              useBlur: true,
              useShadows: true,
              customBorderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.MEDIUM),
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          SystemCalls().powerOff();
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
                        onTap: () {
                          SystemCalls().sleep();
                        },
                        mouseCursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.brightness_2_outlined,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
