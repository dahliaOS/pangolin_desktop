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

import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/widgets/global/icon/icon.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class AppLauncherButton extends StatelessWidget {
  final DesktopEntry application;

  const AppLauncherButton({required this.application, super.key});

  @override
  Widget build(BuildContext context) {
    final _customizationProvider =
        CustomizationProvider.of(context, listen: false);
    return Tooltip(
      message: application.getLocalizedComment(context.locale) ?? "",
      waitDuration: const Duration(seconds: 1),
      preferBelow: true,
      verticalOffset: 80,
      child: SizedBox(
        height: 128,
        width: 128,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              /* onLongPress: () =>
                  _customizationProvider.togglePinnedApp(application.packageName), */
              onTap: () async {
                await ApplicationService.current.startApp(application);
                // ignore: use_build_context_synchronously
                Shell.of(context, listen: false).dismissEverything();
              },
              borderRadius: CommonData.of(context).borderRadiusMedium,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DynamicIcon(
                    icon: application.icon?.main ?? "",
                    size: 64,
                  ),
                  Text(
                    application.getLocalizedName(context.locale),
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
