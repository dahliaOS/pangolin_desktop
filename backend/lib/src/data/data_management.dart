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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DatabaseManager {
  static late Box _hivedb;
  static Future<void> initialseDatabase() async {
    //final _dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    //Hive.init(_dir.path);
    _hivedb = await Hive.openBox('settings');
  }

  //get
  ///Get the Value of a Key
  static dynamic get<T>(String key) => _hivedb.get(key);

  //set
  ///Set the Value of a Key
  static void set(String key, dynamic value) async =>
      await _hivedb.put(key, value);

  //new entry
  ///Checks if the Database already contains the entry and creates a new one if it doesn't
  static void newEntry(String key, dynamic value) {
    if (!(_hivedb.containsKey(key))) {
      set(key, value);
    }
  }

  //get DatabaseEntry
  ///returns the Hive Box
  static Box? get getHiveBox => _hivedb;
}

class PreferenceProvider extends ChangeNotifier {
  PreferenceProvider() {
    loadData();
  }

  //initial values
  double _blur = 25.0;
  double _borderRadius = 1.0;
  double _themeOpacity = 0.7;
  bool _darkMode = false;
  List<String> _packages = List.empty();
  String _wallpaper = "assets/images/wallpapers/Three_Bubbles.png";
  bool _centerTaskbar = true;
  bool _enableBlur = true;
  bool _randomWallpaper = false;
  int _accentColor = Colors.deepOrangeAccent.value;
  bool _enableDevOptions = false;
  bool _enableAutoTime = true;
  bool _showSeconds = false;
  bool _enable24h = true;
  String _keyboardLayoutName = "en_US";
  double _volumeLevel = 0.5;
  bool _enableBluelightFilter = false;
  double _brightness = 1.0;
  bool _wifi = true;
  bool _bluetooth = false;
  String _fontFamily = "Roboto";
  bool _useCustomAccentColor = false;
  bool _useColoredTitleBar = false;
  List<String> _pinnedApps = List.from(
      kIsWeb
          ? [
              "io.dahlia.calculator",
              "io.dahlia.settings",
            ]
          : [
              "io.dahlia.calculator",
              "io.dahlia.terminal",
              "io.dahlia.settings",
              "io.dahlia.files"
            ],
      growable: true);
  List<String> _recentWallpapers = List.from([], growable: true);
  double _taskbarPosition = 2;
  int _launcherIcon = Icons.apps.codePoint;
  List<String> _recentSearchResults = List.from([], growable: true);

  //getter
  double get blur => _blur;
  double get borderRadius => _borderRadius;
  double get themeOpacity => _themeOpacity;
  bool get darkMode => _darkMode;
  List<String> get packages => _packages;
  String get wallpaper => _wallpaper;
  bool get centerTaskbar => _centerTaskbar;
  bool get enableBlur => _enableBlur;
  bool get randomWallpaper => _randomWallpaper;
  int get accentColor => _accentColor;
  bool get enableDevOptions => _enableDevOptions;
  bool get enableAutoTime => _enableAutoTime;
  bool get showSeconds => _showSeconds;
  bool get enable24h => _enable24h;
  String get keyboardLayoutName => _keyboardLayoutName;
  double get volumeLevel => _volumeLevel;
  bool get enableBluelightFilter => _enableBluelightFilter;
  double get brightness => _brightness;
  bool get wifi => _wifi;
  bool get bluetooth => _bluetooth;
  String get fontFamily => _fontFamily;
  bool get useCustomAccentColor => _useCustomAccentColor;
  bool get useColoredTitlebar => _useColoredTitleBar;
  List<String> get pinnedApps => _pinnedApps;
  List<String> get recentWallpapers => _recentWallpapers;
  double get taskbarPosition => _taskbarPosition;
  int get launcherIcon => _launcherIcon;
  List<String> get recentSearchResults => _recentSearchResults;

  //setter
  set blur(double blur) {
    _blur = blur;
    notifyListeners();
    DatabaseManager.set("blur", blur);
  }

  set borderRadius(double borderRadius) {
    _borderRadius = borderRadius;
    notifyListeners();
    DatabaseManager.set("borderRadius", borderRadius);
  }

  set themeOpacity(double opacity) {
    _themeOpacity = opacity;
    notifyListeners();
    DatabaseManager.set("themeOpacity", opacity);
  }

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
    DatabaseManager.set("darkMode", darkMode);
  }

  set packages(List<String> packages) {
    _packages = packages;
    notifyListeners();
    DatabaseManager.set("packages", packages);
  }

  set wallpaper(String path) {
    _wallpaper = path;
    notifyListeners();
    DatabaseManager.set("wallpaper", path);
  }

  set centerTaskbar(bool value) {
    _centerTaskbar = value;
    notifyListeners();
    DatabaseManager.set("centerTaskbar", value);
  }

  set enableBlur(bool value) {
    _enableBlur = value;
    notifyListeners();
    DatabaseManager.set("enableBlur", value);
  }

  set randomWallpaper(bool value) {
    _randomWallpaper = value;
    notifyListeners();
    DatabaseManager.set("randomWallpaper", value);
  }

  set accentColor(int value) {
    _accentColor = value;
    notifyListeners();
    DatabaseManager.set("accentColor", value);
  }

  set enableDevOptions(bool value) {
    _enableDevOptions = value;
    notifyListeners();
    DatabaseManager.set("enableDeveloperOptions", value);
  }

  set enableAutoTime(bool value) {
    _enableAutoTime = value;
    notifyListeners();
    DatabaseManager.set("enableAutoTime", value);
  }

  set showSeconds(bool value) {
    _showSeconds = value;
    notifyListeners();
    DatabaseManager.set("showSeconds", value);
  }

  set enable24h(bool value) {
    _enable24h = value;
    notifyListeners();
    DatabaseManager.set("enable24h", value);
  }

  set keyboardLayoutName(String value) {
    _keyboardLayoutName = value;
    notifyListeners();
    DatabaseManager.set("keyboardLayoutName", value);
  }

  set volumeLevel(double value) {
    _volumeLevel = value;
    notifyListeners();
    DatabaseManager.set("volumeLevel", value);
  }

  set enableBluelightFilter(bool value) {
    _enableBluelightFilter = value;
    notifyListeners();
    DatabaseManager.set("enableBluelightFilter", value);
  }

  set brightness(double value) {
    _brightness = value;
    notifyListeners();
    DatabaseManager.set("brightness", value);
  }

  set wifi(bool value) {
    _wifi = value;
    notifyListeners();
    DatabaseManager.set("wifi", value);
  }

  set bluetooth(bool value) {
    _bluetooth = value;
    notifyListeners();
    DatabaseManager.set("bluetooth", value);
  }

  set fontFamily(String font) {
    _fontFamily = font;
    notifyListeners();
    DatabaseManager.set("fontFamily", font);
  }

  set useCustomAccentColor(bool val) {
    _useCustomAccentColor = val;
    notifyListeners();
    DatabaseManager.set("useCustomAccentColor", val);
  }

  set useColoredTitlebar(bool val) {
    _useColoredTitleBar = val;
    notifyListeners();
    DatabaseManager.set("useColoredTitlebar", val);
  }

  void togglePinnedApp(String packageName) {
    !_pinnedApps.contains(packageName)
        ? _pinnedApps.add(packageName)
        : _pinnedApps.remove(packageName);
    notifyListeners();
    DatabaseManager.set("pinnedApps", _pinnedApps);
  }

  void addRecentWallpaper(String ref) {
    if (!_recentWallpapers.contains(ref)) {
      _recentWallpapers.add(ref);
      notifyListeners();
      DatabaseManager.set("recentWallpapers", _recentWallpapers);
    }
  }

  set taskbarPosition(double value) {
    _taskbarPosition = value;
    notifyListeners();
    DatabaseManager.set("taskbarPosition", value);
  }

  set launcherIcon(int codePoint) {
    _launcherIcon = codePoint;
    notifyListeners();
    DatabaseManager.set("launcherIcon", codePoint);
  }

  void addRecentSearchResult(String value) {
    _recentSearchResults.add(value);
    notifyListeners();
    DatabaseManager.set("recentSearchResults", _recentSearchResults);
  }

  //load from Database
  void loadData() {
    blur = DatabaseManager.get("blur") ?? blur;
    borderRadius = DatabaseManager.get("borderRadius") ?? borderRadius;
    themeOpacity = DatabaseManager.get("themeOpacity") ?? themeOpacity;
    darkMode = DatabaseManager.get("darkMode") ?? darkMode;
    packages = DatabaseManager.get("packages") ?? packages;
    wallpaper = DatabaseManager.get("wallpaper") ?? wallpaper;
    centerTaskbar = DatabaseManager.get("centerTaskbar") ?? centerTaskbar;
    enableBlur = DatabaseManager.get("enableBlur") ?? enableBlur;
    randomWallpaper = DatabaseManager.get("randomWallpaper") ?? randomWallpaper;
    accentColor = DatabaseManager.get("accentColor") ?? accentColor;
    enableDevOptions =
        DatabaseManager.get("enableDeveloperOptions") ?? enableDevOptions;
    enableAutoTime = DatabaseManager.get("enableAutoTme") ?? enableAutoTime;
    showSeconds = DatabaseManager.get("showSeconds") ?? showSeconds;
    enable24h = DatabaseManager.get("enable24h") ?? enable24h;
    keyboardLayoutName =
        DatabaseManager.get("keyboardLayoutName") ?? keyboardLayoutName;
    volumeLevel = DatabaseManager.get("volumeLevel") ?? volumeLevel;
    enableBluelightFilter =
        DatabaseManager.get("enableBluelightFilter") ?? enableBluelightFilter;
    brightness = DatabaseManager.get("brightness") ?? brightness;
    wifi = DatabaseManager.get("wifi") ?? wifi;
    bluetooth = DatabaseManager.get("bluetooth") ?? bluetooth;
    fontFamily = DatabaseManager.get("fontFamily") ?? fontFamily;
    useCustomAccentColor =
        DatabaseManager.get("useCustomAccentColor") ?? useCustomAccentColor;
    useColoredTitlebar =
        DatabaseManager.get("useColoredTitlebar") ?? useColoredTitlebar;
    _pinnedApps = List.from(DatabaseManager.get("pinnedApps") ?? pinnedApps);
    _recentWallpapers =
        List.from(DatabaseManager.get("recentWallpapers") ?? recentWallpapers);
    _taskbarPosition =
        DatabaseManager.get("taskbarPosition") ?? taskbarPosition;
    _launcherIcon = DatabaseManager.get("launcherIcon") ?? launcherIcon;
    _recentSearchResults =
        DatabaseManager.get("recentSearchResults") ?? recentSearchResults;
    if (DatabaseManager.get("iconPack") == "io.dahlia.icons.default") {
      DatabaseManager.set("iconPack", "material");
    }

    DatabaseManager.newEntry("windowBorderRadius", 8.0);
  }
}
