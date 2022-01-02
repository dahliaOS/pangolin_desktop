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

import 'package:pangolin/components/overlays/keyboard_overlay.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class KeyboardButton extends StatelessWidget {
  const KeyboardButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    final _shell = Shell.of(context);

    return SizedBox(
      //width: 96,
      width: _customizationProvider.isTaskbarHorizontal ? null : 48,
      height: _customizationProvider.isTaskbarHorizontal ? 48 : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius:
              CommonData.of(context).borderRadius(BorderRadiusType.small),
          child: ValueListenableBuilder<bool>(
            valueListenable:
                _shell.getShowingNotifier(QuickSettingsOverlay.overlayId),
            builder: (context, showing, child) {
              return Material(
                color: showing
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
                child: child,
              );
            },
            child: InkWell(
              hoverColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              mouseCursor: SystemMouseCursors.click,
              onTap: () => showKeyboard(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Center(
                  child: _customizationProvider.isTaskbarHorizontal
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.keyboard_outlined)],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Icon(Icons.keyboard_outlined)],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
