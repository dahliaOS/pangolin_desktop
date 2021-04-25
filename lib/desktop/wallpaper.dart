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
import 'package:pangolin/settings/pages/customization.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_overlay.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:provider/provider.dart';

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    return Stack(
      children: [
        SizedBox.expand(
            child: ContextMenuRegion(
                contextMenu: ContextMenu(
                  items: [
                    ContextMenuItem(
                      onTap: () {
                        showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return WallpaperChooser();
                            });
                      },
                      icon: Icons.image,
                      title: "Change Wallpaper",
                      shortcut: "",
                    ),
                  ],
                ),
                child: wallpaperImage(_data.wallpaper))),
        Positioned(
          bottom: 70,
          right: 20,
          child: Text(
            "Pangolin Version $totalVersionNumber",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget wallpaperImage(String source) {
    if (source.startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        source,
        fit: BoxFit.cover,
      );
    }
  }
}
