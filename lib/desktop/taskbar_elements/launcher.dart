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
import 'package:pangolin/desktop/taskbar_elements/search.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/app_launcher_button.dart';
import 'package:pangolin/widgets/searchbar.dart';
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
  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay> {
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Searchbar(
                  onTextChanged: (change) {
                    WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false));
                    WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                        uniqueId: "search", content: Search()));
                  },
                  leading: Icon(Icons.search),
                  trailing: Icon(Icons.menu),
                  hint: "Search Device, Apps and Web",
                  controller: TextEditingController()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                  Chip(label: Text("test")),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: GridView.builder(
                  itemCount: applications.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (BuildContext context, int index) {
                    var keys = applications.keys.toList();
                    return AppLauncherButton(keys[index]);
                  },
                  //crossAxisCount: 7,
                  /* children: [
                    for(var app in applications) {}
                    AppLauncherButton("io.dahlia.calculator"),
                  ], */
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
