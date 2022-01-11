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
import 'package:pangolin/utils/data/database_manager.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class SettingsPageCustomization extends StatefulWidget {
  const SettingsPageCustomization({Key? key}) : super(key: key);

  @override
  _SettingsPageCustomizationState createState() =>
      _SettingsPageCustomizationState();
}

class _SettingsPageCustomizationState extends State<SettingsPageCustomization> {
  @override
  Widget build(BuildContext context) {
    final _provider = CustomizationProvider.of(context);
    return SettingsPage(
      title: "Customization",
      cards: [
        const SettingsContentHeader("Theme"),
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
                  children: SettingsPresets.accentColorPresets
                      .map((e) => AccentColorButton(model: e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        const SettingsContentHeader("Taskbar Alignment"),
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
        const SettingsContentHeader("Window options"),
        SettingsCard(
          children: [
            ListTile(
              title: Text(
                "Window border radius  -  ${DatabaseManager.get("windowBorderRadius")}",
              ),
              subtitle: const Text("Change the window border radius"),
              trailing: Builder(
                builder: (context) {
                  final double value =
                      DatabaseManager.get<double>("windowBorderRadius");
                  return SizedBox(
                    width: 256,
                    child: Slider(
                      divisions: 4,
                      min: 8.0,
                      max: 24.0,
                      onChanged: (double val) {
                        setState(() {
                          DatabaseManager.set("windowBorderRadius", val);
                        });
                      },
                      value: value,
                    ),
                  );
                },
              ),
            ),
            SwitchListTile(
              title: const Text("Colored window titlebars"),
              subtitle: const Text("Use colored titlebars for the windows"),
              value: _provider.coloredTitlebars,
              onChanged: (value) {
                _provider.coloredTitlebars = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
