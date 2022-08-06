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
import 'package:pangolin/components/settings/models/settings_taskbar_data_model.dart';
import 'package:pangolin/components/settings/models/settings_theme_data_model.dart';

class SettingsPresets {
  const SettingsPresets._();

  //List with presets for the system theme modes
  //TODO add automatic option based on time / sunrise-sunset
  static List<ThemeModeDataModel> get themeModePresets => getThemeModePresets();

  //List with presets for the taskbar alignment
  static List<TaskbarAlignmentModelData> get taskbarAlignmentPresets =>
      getTaskbarAlignmentPresets();

  static List<ThemeModeDataModel> getThemeModePresets() {
//load the data for the theme mode presets
    return List.from(
      [
        const ThemeModeDataModel(
          color: Color(0xffffffff),
          label: "Light",
          darkMode: false,
        ),
        const ThemeModeDataModel(
          color: Color(0xff0a0a0a),
          label: "Dark",
          darkMode: true,
        ),
      ],
      growable: false,
    );
  }

  static List<TaskbarAlignmentModelData> getTaskbarAlignmentPresets() {
//load the data for the taskbar alignment presets
    return List.from(
      [
        const TaskbarAlignmentModelData(
          label: "Start",
          centered: false,
        ),
        const TaskbarAlignmentModelData(
          label: "Center",
          centered: true,
        ),
      ],
      growable: false,
    );
  }
}
