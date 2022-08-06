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

import 'package:flutter/material.dart';
import 'package:pangolin/components/settings/data/presets.dart';
import 'package:pangolin/components/settings/widgets/accent_color_button.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/components/settings/widgets/taskbar_alignment_button.dart';
import 'package:pangolin/components/settings/widgets/theme_mode_button.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/widgets/services.dart';

class SettingsPageCustomization extends StatefulWidget {
  const SettingsPageCustomization({super.key});

  @override
  _SettingsPageCustomizationState createState() =>
      _SettingsPageCustomizationState();
}

class _SettingsPageCustomizationState extends State<SettingsPageCustomization>
    with StateServiceListener<CustomizationService, SettingsPageCustomization> {
  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return SettingsPage(
      title: strings.settings.pagesCustomizationTitle,
      cards: [
        SettingsContentHeader(strings.settings.pagesCustomizationTheme),
        SettingsCard(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: SettingsPresets.themeModePresets
                      .map((e) => ThemeModeButton(model: e))
                      .toList(),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: BuiltinColor.values
                      .map((e) => AccentColorButton(color: e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        const SettingsContentHeader("Taskbar Alignment"),
        //TODO make this strings.settings.pagesCustomizationTaskbarAlignment
        SettingsCard(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: SettingsPresets.taskbarAlignmentPresets
                      .map((e) => TaskbarAlignmentButton(model: e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
