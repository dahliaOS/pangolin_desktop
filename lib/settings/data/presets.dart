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
import 'package:pangolin/settings/models/settings_accent_data_model.dart';
import 'package:pangolin/settings/models/settings_taskbar_data_model.dart';
import 'package:pangolin/settings/models/settings_theme_data_model.dart';

class SettingsPresets {
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
        AccentColorDataModel(Color(0xFFFF5722), "Orange"),
        AccentColorDataModel(Color(0xFFD32F2F), "Red"),
        AccentColorDataModel(Color(0xFF078D48), "Green"),
        AccentColorDataModel(Color(0xFF0067C0), "Blue"),
        AccentColorDataModel(Color(0xFF00594F), "Teal"),
        AccentColorDataModel(Color(0xFF6200EE), "Purple"),
        AccentColorDataModel(Color(0xFF00BCD4), "Aqua"),
        AccentColorDataModel(Color(0xFFFFC107), "Gold"),
        AccentColorDataModel(Color(0xFF455a64), "Anthracite"),
      ],
      growable: false,
    );

    //load the data for the theme mode presets
    themeModePresets = List.from(
      [
        ThemeModeDataModel(Color(0xffffffff), "Light", false),
        ThemeModeDataModel(Color(0xff0a0a0a), "Dark", true),
      ],
      growable: false,
    );

    //load the data for the taskbar alignment presets
    taskbarAlignmentPresets = List.from(
      [
        TaskbarAlignmentModelData("Start", false),
        TaskbarAlignmentModelData("Center", true),
      ],
      growable: false,
    );
  }
}
