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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        // Material widget to allow a HoverColor for each app
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onSecondaryTap: () {
              _customizationProvider.togglePinnedApp(application.packageName);
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              hoverColor: CommonData.of(context).textColor().withOpacity(0.2),
              focusColor: CommonData.of(context).textColor(),
              onTap: () {
                if (application.systemExecutable == true) {
                  print(application.runtimeFlags.toString());
                  Process.run(
                    'io.dahliaos.web_runtime.dap',
                    application.runtimeFlags,
                  );
                }
                application.launch(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getAppIcon(
                    application.systemExecutable,
                    application.iconName,
                    64,
                  ),
                  const SizedBox(
                    height: 18,
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
      ),
    );
  }
}
