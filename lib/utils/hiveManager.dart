/*
Copyright 2019 The dahliaOS Authors
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
import 'package:Pangolin/main.dart';
import 'package:flutter/material.dart';

class HiveManager {
  static initializeHive() {
    createEntryIfNotExisting("darkMode", false);
    createEntryIfNotExisting("blur", true);
    createEntryIfNotExisting("accentColorName", "orange");
    createEntryIfNotExisting(
        "accentColorValue", Colors.deepOrangeAccent[400].value);
    createEntryIfNotExisting("darkMode", true);
    createEntryIfNotExisting("centerTaskbar", false);
    createEntryIfNotExisting("volumeLevel", 0.75);
    createEntryIfNotExisting("brightness", 1.0);
    createEntryIfNotExisting("blueLightFilterValue", 0.5);
    createEntryIfNotExisting("enableBlueLightFilter", false);
    createEntryIfNotExisting("enableAutoTime", true);
    createEntryIfNotExisting("enable24hTime", false);
    createEntryIfNotExisting("settingsLanguageSelectorList", languages);
    createEntryIfNotExisting("languageName", "English - United States");
    createEntryIfNotExisting("randomWallpaper", false);
    createEntryIfNotExisting("wifi", true);
    createEntryIfNotExisting("wallpaper", 3);
    createEntryIfNotExisting("bluetooth", false);
    createEntryIfNotExisting("showSeconds", false);
    createEntryIfNotExisting("keyboardLayout", "en_US");
    createEntryIfNotExisting("keyboardLayoutName", "English - United States");
    createEntryIfNotExisting("timeZone", "en_US");
    createEntryIfNotExisting("timeZoneName", "English - United States");
    createEntryIfNotExisting("launcherWideMode", false);
    createEntryIfNotExisting("coloredTitlebar", true);
  }

  static set(String key, dynamic value) {
    Pangolin.settingsBox.put(key, value);
  }

  static get(String key) {
    return Pangolin.settingsBox.get(key);
  }

  static double magicNumber = double.infinity;
}

createEntryIfNotExisting(String key, dynamic value) {
  if (Pangolin.settingsBox.get(key) == null) {
    Pangolin.settingsBox.put(key, value);
  }
}

List<String> languages = [
  "English - United States",
  "Deutsch - Deutschland",
  "Français - France",
  "Polski - Polska",
  "Hrvatski - Hrvatska",
  "Nederlands - België",
  "Nederlands - Nederland",
];

List<String> timeZones = [];

List<String> wallpapers = [
  "assets/images/Desktop/Wallpapers/dahliaOS/dahliaOS_white_logo_pattern_wallpaper.png",
  "assets/images/Desktop/Wallpapers/dahliaOS/dahliaOS_white_wallpaper.png",
  "assets/images/Desktop/Wallpapers/dahliaOS/Gradient_logo_wallpaper.png",
  "assets/images/Desktop/Wallpapers/dahliaOS/Three_bubbles_wallpaper.png",
  "assets/images/Desktop/Wallpapers/Nature/mountain.jpg",
];
