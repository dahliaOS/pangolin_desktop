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
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/wallpaper_picker.dart';
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

/* 
class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  @override
  void initState() {
    super.initState();
    getBingWallpaper();
  }

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
                          return WallpaperPicker();
                        });
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
            child: wallpaperImage(_data.wallpaper),
          ),
        ),
        Positioned(
          bottom: 48 + 12,
          right: 10,
          child: _data.wallpaper == link
              ? BoxContainer(
                  useShadows: true,
                  useAccentBG: true,
                  customBorderRadius: CommonData.of(context)
                      .borderRadius(BorderRadiusType.SMALL),
                  useSystemOpacity: true,
                  color: CommonData.of(context).textColorAlt(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      copyright.replaceAll(", ", ",\n"),
                      style: TextStyle(
                        color: CommonData.of(context).textColor(),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
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
 */
