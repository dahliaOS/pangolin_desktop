import 'package:Pangolin/utils/hiveManager.dart';
import 'package:flutter/material.dart';

class Themes {
  //light
  static ThemeData light(Color accent) {
    return ThemeData(
        accentColor: accent,
        primaryColor: accent,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          caption: TextStyle(color: Colors.black),
        ),
        sliderTheme: SliderThemeData(
          activeTickMarkColor: accent,
          thumbColor: accent,
          activeTrackColor: accent,
          inactiveTrackColor: accent.withAlpha(90),
          inactiveTickMarkColor: accent,
        ),
        toggleableActiveColor: accent,
        cardColor: Colors.grey[100],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
        ),
        tabBarTheme: TabBarTheme(labelColor: Colors.black12),
        brightness: Brightness.light,
        platform: TargetPlatform.android);
  }

  //dark
  static ThemeData dark(Color accent) {
    return ThemeData(
        accentColor: accent,
        primaryColor: accent,
        canvasColor: Color(0xff111111),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
        ),
        sliderTheme: SliderThemeData(
          activeTickMarkColor: accent,
          thumbColor: accent,
          activeTrackColor: accent,
          inactiveTrackColor: accent.withAlpha(90),
          inactiveTickMarkColor: accent,
        ),
        toggleableActiveColor: accent,
        cardColor: Color(0xff1B1B1D),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
        ),
        tabBarTheme: TabBarTheme(labelColor: Colors.black12),
        brightness: Brightness.dark,
        platform: TargetPlatform.android);
  }
}

class CustomizationNotifier extends ChangeNotifier {
  static bool _darkTheme = HiveManager.get("darkMode");
  static bool _blur = HiveManager.get("blur");

  bool get darkTheme => _darkTheme;
  bool get blur => _blur;
  Color accent = Color(HiveManager.get("accentColorValue"));

  toggleThemeDarkMode(bool state) {
    _darkTheme = state;
    HiveManager.set("darkMode", state);
    notifyListeners();
  }

  changeThemeColor(Color color) {
    accent = color;
    HiveManager.set("accentColorValue", color.value);
    notifyListeners();
  }

  toggleBlur(bool state) {
    _blur = state;
    HiveManager.set("blur", state);
    notifyListeners();
  }
}
