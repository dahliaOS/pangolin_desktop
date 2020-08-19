import 'package:Pangolin/settings/hiveManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themes {
  //light
  static ThemeData light(Color accent) {
    ThemeData(
        accentColor: accent,
        primaryColor: accent,
        canvasColor: Color(0xffFFFFFF),
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
        cardColor: Colors.grey[900],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
        ),
        tabBarTheme: TabBarTheme(labelColor: Colors.black12),
        textSelectionHandleColor: accent,
        brightness: Brightness.light,
        platform: TargetPlatform.android);
  }

  //default
  static ThemeData def(Color accent) {
    ThemeData(
        accentColor: accent,
        primaryColor: accent,
        canvasColor: Color(0xff1B1B1D),
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
        cardColor: Colors.grey[900],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
        ),
        tabBarTheme: TabBarTheme(labelColor: Colors.black12),
        textSelectionHandleColor: accent,
        brightness: Brightness.light,
        platform: TargetPlatform.android);
  }

  //dark
  static ThemeData dark(Color accent) {
    return ThemeData(
        accentColor: accent,
        primaryColor: accent,
        canvasColor: Color(0xff1B1B1D),
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
        cardColor: Colors.grey[900],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
        ),
        tabBarTheme: TabBarTheme(labelColor: Colors.black12),
        textSelectionHandleColor: accent,
        brightness: Brightness.dark,
        platform: TargetPlatform.android);
  }
}

class CustomizationNotifier extends ChangeNotifier {
  static PangolinTheme _themeData = HiveManager.get("theme");
  static bool _blur = HiveManager.get("blur");
  ThemeData _theme;
  //static int _theme = HiveManager.get("theme");

  PangolinTheme get themeData => _themeData;
  bool get blur => _blur;
  ThemeData get theme => _theme;
  //int get theme => _theme;
  Color accent = Color(HiveManager.get("accentColorValue"));

  setTheme(PangolinTheme theme) {
    _themeData = theme;
    if (theme == PangolinTheme.light) {
      HiveManager.set("theme", 0);
      _theme = Themes.light(Colors.blue);
      notifyListeners();
    } else if (theme == PangolinTheme.def) {
      HiveManager.set("theme", 1);
      _theme = Themes.def(Colors.blue);
      notifyListeners();
    } else if (theme == PangolinTheme.dark) {
      HiveManager.set("theme", 2);
      _theme = Themes.dark(Colors.blue);
      notifyListeners();
    }
    //theme ? HiveManager.set("theme", 2) : HiveManager.set("theme", 1);
    //HiveManager.set("darkMode", state);
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

enum PangolinTheme { light, def, dark }
