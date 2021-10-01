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
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/services/wm_api.dart';
import 'package:provider/provider.dart';

class AppLauncherButton extends StatefulWidget {
  final Application application;
  const AppLauncherButton(this.application);

  @override
  _AppLauncherButtonState createState() => _AppLauncherButtonState();
}

class _AppLauncherButtonState extends State<AppLauncherButton> {
  Application get application => widget.application;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        // Material widget to allow a HoverColor for each app
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onSecondaryTap: () {
              Provider.of<PreferenceProvider>(context, listen: false)
                  .togglePinnedApp(application.packageName ?? "");
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              hoverColor: CommonData.of(context).textColor().withOpacity(0.2),
              focusColor: CommonData.of(context).textColor(),
              onTap: () {
                Shell.of(context, listen: false).dismissEverything();
                WmAPI.of(context).openApp(application.packageName!);
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
                    style: TextStyle(
                        fontSize: 17,
                        color: CommonData.of(context).textColor()),
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
