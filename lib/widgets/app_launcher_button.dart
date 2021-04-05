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
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class AppLauncherButton extends StatefulWidget {
  final String packageName;
  const AppLauncherButton(this.packageName);

  @override
  _AppLauncherButtonState createState() => _AppLauncherButtonState();
}

class _AppLauncherButtonState extends State<AppLauncherButton> {
  @override
  Widget build(BuildContext context) {
    final Application application = getApp(widget.packageName);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        // Material widget to allow a HoverColor for each app
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onSecondaryTap: () {
              //right click to pin/unpin
              Provider.of<PreferenceProvider>(context, listen: false)
                  .addToPinnedApps = application.packageName ?? "";
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
              focusColor: Colors.white,
              onTap: () {
                WmAPI.of(context).popOverlayEntry(
                    Provider.of<DismissibleOverlayEntry>(context,
                        listen: false));
                WmAPI.of(context).openApp(widget.packageName);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.yellow,
                    child: Image.asset(
                      "assets/icons/${application.iconName}.png",
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    application.name ?? "",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
