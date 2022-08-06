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
import 'package:pangolin/components/overlays/launcher/compact_launcher_overlay.dart';
import 'package:pangolin/components/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/resource/icon/icon.dart';
import 'package:pangolin/widgets/services.dart';

//TODO: Context menu for changing the taskbar's icon is cut off.
class LauncherButton extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  const LauncherButton({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return ContextMenuRegion(
      centerAboveElement: true,
      contextMenu: ContextMenu(
        items: LauncherIcon.values
            .map(
              (e) => ContextMenuItem(
                icon: Constants.builtinIcons[e.iconName]!,
                title: e.label,
                onTap: () => service.launcherIcon = IconResource(
                  type: IconResourceType.dahlia,
                  value: e.iconName,
                ),
              ),
            )
            .toList(),
      ),
      child: TaskbarElement(
        overlayID: service.compactLauncher
            ? CompactLauncherOverlay.overlayId
            : LauncherOverlay.overlayId,
        child: ResourceIcon(resource: service.launcherIcon),
      ),
    );
  }
}

enum LauncherIcon {
  first("Icon 1", "launcher_1"),
  second("Icon 2", "launcher_2"),
  third("Icon 3", "launcher_3"),
  fourth("Icon 4", "launcher_4");

  final String label;
  final String iconName;

  const LauncherIcon(this.label, this.iconName);
}
