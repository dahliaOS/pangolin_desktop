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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/desktop/wallpaper_picker.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:pangolin/widgets/resource/image/image.dart';
import 'package:provider/provider.dart';

class WallpaperLayer extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  const WallpaperLayer({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return SizedBox.expand(
      child: ChangeNotifierProvider.value(
        value: WindowManagerService.current.controller,
        child: _WallpaperContextMenu(
          child: ResourceImage(
            resource: service.wallpaper,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _WallpaperContextMenu extends StatelessWidget {
  const _WallpaperContextMenu({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      entries: [
        ContextMenuItem(
          onTap: () {
            showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return const WallpaperPicker();
              },
            );
          },
          leading: const Icon(Icons.image),
          child: const Text("Change Wallpaper"),
        ),
        ContextMenuItem(
          onTap: () {
            ApplicationService.current.startApp("io.dahlia.settings");
          },
          leading: const Icon(Icons.settings_outlined),
          child: const Text("Settings"),
        ),
      ],
      child: child,
    );
  }
}
