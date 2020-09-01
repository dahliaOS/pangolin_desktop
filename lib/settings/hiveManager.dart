import '../main.dart';
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
    createEntryIfNotExisting("enable24hTime", true);
    createEntryIfNotExisting("settingsLanguageSelectorList", languages);
    createEntryIfNotExisting("languageName", "English - United States");
    createEntryIfNotExisting("randomWallpaper", false);
    createEntryIfNotExisting("wifi", true);
    createEntryIfNotExisting("bluetooth", false);
    createEntryIfNotExisting("showSeconds", false);
    createEntryIfNotExisting("keyboardLayout", "en_US");
    createEntryIfNotExisting("keyboardLayoutName", "English - United States");
    createEntryIfNotExisting("timeZone", "en_US");
    createEntryIfNotExisting("timeZoneName", "English - United States");
    createEntryIfNotExisting("launcherWidth", 1500);
    createEntryIfNotExisting("launcherSize", 5);
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
