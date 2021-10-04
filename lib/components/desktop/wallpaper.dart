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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/services/wm_api.dart';
import 'package:pangolin/components/desktop/wallpaper_picker.dart';
import 'package:provider/provider.dart';

class WallpaperWindowFeature extends WindowFeature {
  const WallpaperWindowFeature();

  @override
  Widget build(BuildContext context, Widget content) {
    // get properties
    final WindowPropertyRegistry properties =
        WindowPropertyRegistry.of(context);

    // fetch image from properties
    final String? image =
        Provider.of<PreferenceProvider>(context, listen: true).wallpaper;

    //get Bing Wallpaper of the Day data
    getBingWallpaper();

    return SizedBox.expand(
      child: _WallpaperContextMenu(child: wallpaperImage(image!)),
    );
  }

  @override
  List<WindowPropertyKey> get requiredProperties => [];
}

class _WallpaperContextMenu extends StatelessWidget {
  const _WallpaperContextMenu({
    required Widget child,
    Key? key,
  })  : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      contextMenu: ContextMenu(
        items: [
          ContextMenuItem(
            onTap: () {
              showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return WallpaperPicker();
                },
              );
            },
            icon: Icons.image,
            title: "Change Wallpaper",
            shortcut: "",
          ),
          ContextMenuItem(
            onTap: () {
              WmAPI.of(context).openApp("io.dahlia.settings");
            },
            icon: Icons.settings_outlined,
            title: "Settings",
            shortcut: "",
          ),
        ],
      ),
      child: _child,
    );
  }
}

Widget wallpaperImage(String source) {
  if (source.startsWith("http")) {
    return CachedNetworkImage(
      imageUrl: source,
      fit: BoxFit.cover,
      cacheKey: source,
      useOldImageOnUrlChange: true,
      fadeInDuration: Duration(milliseconds: 1000),
      fadeOutDuration: Duration(milliseconds: 1000),
      fadeInCurve: Curves.easeInOut,
      fadeOutCurve: Curves.easeInOut,
    );
  } else {
    return Image.asset(
      source,
      fit: BoxFit.cover,
    );
  }
}
