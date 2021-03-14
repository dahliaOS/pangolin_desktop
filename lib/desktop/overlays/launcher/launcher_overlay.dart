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
import 'package:pangolin/desktop/overlays/launcher/launcher_categories.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_grid.dart';
import 'package:pangolin/desktop/overlays/launcher/power_menu.dart';
import 'package:pangolin/desktop/overlays/search_overlay.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class LauncherOverlay extends StatefulWidget {
  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay> {
  @override
  Widget build(BuildContext context) {
    final _controller = PageController();

    return Positioned(
      top: 0,
      bottom: 48,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          WmAPI.of(context).popOverlayEntry(
              Provider.of<DismissibleOverlayEntry>(context, listen: false));
          setState(() {});
        },
        child: Stack(
          children: [
            Wallpaper(),
            BoxContainer(
              useBlur: true,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Search(),
                  LauncherCategories(
                    controller: _controller,
                  ),
                  LauncherGrid(controller: _controller),
                  LauncherPowerMenu(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 50),
        child: Searchbar(
          onTextChanged: (change) {
            WmAPI.of(context).popOverlayEntry(
                Provider.of<DismissibleOverlayEntry>(context, listen: false));
            WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "search",
                content: SearchOverlay(
                  text: change,
                )));
          },
          leading: Icon(Icons.search),
          trailing: Icon(Icons.menu),
          hint: "Search Device, Apps and Web",
          controller: TextEditingController(),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ));
  }
}
