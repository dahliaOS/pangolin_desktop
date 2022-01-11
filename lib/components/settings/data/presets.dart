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

import 'package:flutter/widgets.dart';
import 'package:pangolin/components/settings/models/settings_accent_data_model.dart';
import 'package:pangolin/components/settings/models/settings_taskbar_data_model.dart';
import 'package:pangolin/components/settings/models/settings_theme_data_model.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class SettingsPresets {
  const SettingsPresets._();

  //List with presets for the system accent colors
  static late List<AccentColorDataModel> accentColorPresets;

  //List with presets for the system theme modes
  //TODO add automatic option based on time / sunrise-sunset
  static late List<ThemeModeDataModel> themeModePresets;

  //List with presets for the taskbar alignment
  static late List<TaskbarAlignmentModelData> taskbarAlignmentPresets;

  static void loadPresets() {
    //load the data for the accent color presets
    accentColorPresets = List.from(
      [
        AccentColorDataModel(
          const Color(0xFFFF5722),
          LSX.settings.pagesCustomizationThemeColorOrange,
        ),
        AccentColorDataModel(
          const Color(0xFFD32F2F),
          LSX.settings.pagesCustomizationThemeColorRed,
        ),
        AccentColorDataModel(
          const Color(0xFF078D48),
          LSX.settings.pagesCustomizationThemeColorGreen,
        ),
        AccentColorDataModel(
          const Color(0xFF0067C0),
          LSX.settings.pagesCustomizationThemeColorBlue,
        ),
        AccentColorDataModel(
          const Color(0xFF00594F),
          LSX.settings.pagesCustomizationThemeColorTeal,
        ),
        AccentColorDataModel(
          const Color(0xFF6200EE),
          LSX.settings.pagesCustomizationThemeColorPruple,
        ),
        AccentColorDataModel(
          const Color(0xFF00BCD4),
          LSX.settings.pagesCustomizationThemeColorAqua,
        ),
        AccentColorDataModel(
          const Color(0xFFFFC107),
          LSX.settings.pagesCustomizationThemeColorGold,
        ),
        AccentColorDataModel(
          const Color(0xFF455a64),
          LSX.settings.pagesCustomizationThemeColorAnthracite,
        ),
      ],
      growable: false,
    );

    //load the data for the theme mode presets
    themeModePresets = List.from(
      [
        ThemeModeDataModel(
          const Color(0xffffffff),
          LSX.settings.pagesCustomizationThemeModeLight,
          false,
        ),
        ThemeModeDataModel(
          const Color(0xff0a0a0a),
          LSX.settings.pagesCustomizationThemeModeDark,
          true,
        ),
      ],
      growable: false,
    );

    //load the data for the taskbar alignment presets
    taskbarAlignmentPresets = List.from(
      [
        TaskbarAlignmentModelData(
          LSX.settings.pagesCustomizationTaskbarAlignmentStart,
          false,
        ),
        TaskbarAlignmentModelData(
          LSX.settings.pagesCustomizationTaskbarAlignmentCenter,
          true,
        ),
      ],
      growable: false,
    );
  }
}
