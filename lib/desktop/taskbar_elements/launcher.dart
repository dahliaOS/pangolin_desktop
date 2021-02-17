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
import 'package:pangolin/desktop/taskbar_elements/launcher_apps_grid.dart';
import 'package:pangolin/desktop/taskbar_elements/launcher_chips_row.dart';
import 'package:pangolin/desktop/taskbar_elements/launcher_search_bar.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class LauncherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            /* WmAPI(context).pushOverlayEntry(DismissibleOverlayEntry(
                content: Positioned(
                  left: 30,
                  right: 30,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.settings");
                        },
                        child: Text("Settings"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.calculator");
                        },
                        child: Text("Calculator"),
                      ),
                    ],
                  ),
                ),
                uniqueId: 'launcher')); */

            WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "launcher", content: LauncherOverlay()));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: Icon(Icons.apps)),
          ),
        ),
      ),
    );
  }
}

class LauncherOverlay extends StatefulWidget {
  final minWidth = 512;

  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Calculate horizontal padding moultiplier based off of window width
    double horizontalWidgetPaddingMultiplier;
    if (width < widget.minWidth) {
      // should have 0 horizontal padding if width smaller than `widget.minWidth`, so multiplier = 0
      horizontalWidgetPaddingMultiplier = 0;
    } else if (width < 1000) {
      // between `widget.minWidth` and 1000, so set to the result of a function that calculates smooth transition for multiplier
      // check https://www.desmos.com/calculator/lv1liilllb for a graph of this transition
      horizontalWidgetPaddingMultiplier =
          (width - widget.minWidth) / (1000 - widget.minWidth);
    } else {
      horizontalWidgetPaddingMultiplier = 1;
    }

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
        child: BoxContainer(
          useBlur: true,
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                child: LauncherSearchBar(
                  horizontalWidgetPaddingMultiplier:
                      horizontalWidgetPaddingMultiplier,
                ),
              ),
              Container(
                // The row of chips 'test test test test' lol
                margin: const EdgeInsets.only(top: 33 + (1 / 3)),
                child: LauncherChipsRow(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalWidgetPaddingMultiplier * 200,
                  ),
                  child: LauncherAppsGrid(applications: applications),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
