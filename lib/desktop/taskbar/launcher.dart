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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:provider/provider.dart';
import 'package:dahlia_backend/dahlia_backend.dart';

class LauncherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    final _shell = Shell.of(context);

    return SizedBox(
      width: 48,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ContextMenuRegion(
          contextMenu: ContextMenu(
            items: [
              ContextMenuItem(
                icon: Icons.apps_rounded,
                title: "Icon 1",
                onTap: () {
                  _pref.launcherIcon = Icons.apps_rounded.codePoint;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.panorama_fish_eye,
                title: "Icon 2",
                onTap: () {
                  _pref.launcherIcon = Icons.panorama_fish_eye.codePoint;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.brightness_low,
                title: "Icon 3",
                onTap: () {
                  _pref.launcherIcon = Icons.brightness_low.codePoint;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.radio_button_checked,
                title: "Icon 4",
                onTap: () {
                  _pref.launcherIcon = Icons.radio_button_checked.codePoint;
                },
                shortcut: "",
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
                CommonData.of(context).borderRadius(BorderRadiusType.SMALL),
            child: ValueListenableBuilder<bool>(
              valueListenable:
                  _shell.getShowingNotifier(LauncherOverlay.overlayId),
              builder: (context, showing, child) {
                return Material(
                  color: showing
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                  child: child,
                );
              },
              child: InkWell(
                hoverColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                mouseCursor: SystemMouseCursors.click,
                onTap: () => _shell.toggleOverlay(LauncherOverlay.overlayId),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      IconData(
                        _pref.launcherIcon,
                        fontFamily: "MaterialIcons",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
