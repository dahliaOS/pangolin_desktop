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
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/wm_api.dart';

class LauncherPowerMenu extends StatefulWidget {
  @override
  _LauncherPowerMenuState createState() => _LauncherPowerMenuState();
}

class _LauncherPowerMenuState extends State<LauncherPowerMenu> {
  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        width: 28 * 3 + 16 * 4,
        height: 32 + 16,
        child: BoxContainer(
          useShadows: true,
          useBlur: true,
          color: Theme.of(context).backgroundColor,
          useSystemOpacity: true,
          customBorderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      onTap: () {
                        _shell.showOverlay(PowerOverlay.overlayId,
                            dismissEverything: false);
                        setState(() {});
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.power_settings_new,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      onTap: () {},
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      onTap: () {
                        _shell.dismissEverything();
                        WmAPI.of(context).openApp("io.dahlia.settings");
                        setState(() {});
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.settings_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
