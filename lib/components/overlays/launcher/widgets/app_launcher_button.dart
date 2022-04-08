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

import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class AppLauncherButton extends StatefulWidget {
  final Application application;
  const AppLauncherButton(this.application, {Key? key}) : super(key: key);

  @override
  _AppLauncherButtonState createState() => _AppLauncherButtonState();
}

class _AppLauncherButtonState extends State<AppLauncherButton> {
  Application get application => widget.application;

  @override
  Widget build(BuildContext context) {
    final _customizationProvider =
        CustomizationProvider.of(context, listen: false);
    return SizedBox(
      height: 128,
      width: 128,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onLongPress: () =>
                _customizationProvider.togglePinnedApp(application.packageName),
            onTap: () {
              _launchApp(context);
            },
            borderRadius: CommonData.of(context).borderRadiusMedium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getAppIcon(
                  application.systemExecutable,
                  application.iconName,
                  64,
                ),
                Text(
                  application.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: CommonData.of(context).textColor(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    
  }

  void _launchApp(BuildContext context) {
    if (application.systemExecutable == true) {
      if (kDebugMode) {
        print(application.runtimeFlags.toString());
      }
      Process.run(
        'io.dahliaos.web_runtime.dap',
        application.runtimeFlags,
      );
    }
    application.launch(context);
  }
}
