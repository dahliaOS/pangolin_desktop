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
import 'package:pangolin/components/overlays/launcher_overlay.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/widgets/taskbar/taskbar_element.dart';
import 'package:provider/provider.dart';
import 'package:dahlia_backend/dahlia_backend.dart';

class LauncherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);

    return ContextMenuRegion(
        contextMenu: ContextMenu(
          items: [
            ContextMenuItem(
              icon: Icons.apps_rounded,
              title: "Icon 1",
              onTap: () {
                _pref.launcherIcon = Icons.apps_rounded.codePoint;
              },
            ),
            ContextMenuItem(
              icon: Icons.panorama_fish_eye,
              title: "Icon 2",
              onTap: () {
                _pref.launcherIcon = Icons.panorama_fish_eye.codePoint;
              },
            ),
            ContextMenuItem(
              icon: Icons.brightness_low,
              title: "Icon 3",
              onTap: () {
                _pref.launcherIcon = Icons.brightness_low.codePoint;
              },
            ),
            ContextMenuItem(
              icon: Icons.radio_button_checked,
              title: "Icon 4",
              onTap: () {
                _pref.launcherIcon = Icons.radio_button_checked.codePoint;
              },
            ),
          ],
        ),
        child: TaskbarElement(
          overlayID: LauncherOverlay.overlayId,
          child: Icon(
            IconData(
              _pref.launcherIcon,
              fontFamily: "MaterialIcons",
            ),
          ),
        ));
  }
}
