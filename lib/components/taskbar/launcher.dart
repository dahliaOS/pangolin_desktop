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

import 'package:pangolin/components/overlays/launcher/compact_launcher_overlay.dart';
import 'package:pangolin/components/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:provider/provider.dart';

//TODO: Context menu for changing the taskbar's icon is cut off.
class LauncherButton extends StatelessWidget {
  const LauncherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);

    return ContextMenuRegion(
      centerAboveElement: true,
      contextMenu: ContextMenu(
        items: [
          ContextMenuItem(
            icon: Icons.apps_rounded,
            title: "Icon 1",
            onTap: () {
              _customizationProvider.launcherIcon =
                  Icons.apps_rounded.codePoint;
            },
            shortcut: "",
          ),
          ContextMenuItem(
            icon: Icons.panorama_fish_eye,
            title: "Icon 2",
            onTap: () {
              _customizationProvider.launcherIcon =
                  Icons.panorama_fish_eye.codePoint;
            },
            shortcut: "",
          ),
          ContextMenuItem(
            icon: Icons.brightness_low,
            title: "Icon 3",
            onTap: () {
              _customizationProvider.launcherIcon =
                  Icons.brightness_low.codePoint;
            },
            shortcut: "",
          ),
          ContextMenuItem(
            icon: Icons.radio_button_checked,
            title: "Icon 4",
            onTap: () {
              _customizationProvider.launcherIcon =
                  Icons.radio_button_checked.codePoint;
            },
            shortcut: "",
          ),
        ],
      ),
      child: Consumer(
        builder: (context, MiscProvider provider, _) {
          return TaskbarElement(
            overlayID: provider.compactLauncher
                ? CompactLauncherOverlay.overlayId
                : LauncherOverlay.overlayId,
            child: Icon(
              IconData(
                _customizationProvider.launcherIcon,
                fontFamily: "MaterialIcons",
              ),
              //size: 24,
            ),
          );
        },
      ),
    );
  }
}
