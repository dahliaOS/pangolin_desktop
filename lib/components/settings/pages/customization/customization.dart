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
import 'package:pangolin/components/settings/data/presets.dart';
import 'package:pangolin/components/settings/widgets/accent_color_button.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/components/settings/widgets/taskbar_alignment_button.dart';
import 'package:pangolin/components/settings/widgets/theme_mode_button.dart';

class SettingsPageCustomization extends StatefulWidget {
  const SettingsPageCustomization({Key? key}) : super(key: key);

  @override
  _SettingsPageCustomizationState createState() =>
      _SettingsPageCustomizationState();
}

class _SettingsPageCustomizationState extends State<SettingsPageCustomization> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Customization",
      cards: [
        SettingsContentHeader("Accent color"),
        SettingsCard.custom(
          content: SizedBox(
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
        ),
        SettingsContentHeader("Theme Mode"),
        SettingsCard.custom(
          content: SizedBox(
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
        ),
        SettingsContentHeader("Taskbar Alignment"),
        SettingsCard.custom(
          content: SizedBox(
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
        ),
        SettingsContentHeader("Window options"),
        SettingsCard.withCustomTrailing(
          title: "Window rorder radius  -  " +
              DatabaseManager.get("windowBorderRadius").toString(),
          trailing: Builder(
            builder: (context) {
              var value = DatabaseManager.get("windowBorderRadius");
              return SizedBox(
                width: 256,
                child: Slider(
                  divisions: 2,
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
      ],
    );
  }
}
