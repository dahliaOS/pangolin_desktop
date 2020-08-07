import 'package:Pangolin/settings/hiveManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themes {
  //light
  static ThemeData light(Color accent) {
    return ThemeData.light().copyWith(
      accentColor: accent,
      toggleableActiveColor: accent,
      primaryColor: accent,
      iconTheme: IconThemeData(color: Colors.grey[700]),
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
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      cardColor: Colors.grey[100],
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: accent,
          ),
          fillColor: Colors.grey[100]),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.grey[200],
      ),
      textSelectionHandleColor: accent,
    );
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
  static bool _darkTheme = HiveManager().get("darkMode");
  static bool _blur = HiveManager().get("blur");

  bool get darkTheme => _darkTheme;
  bool get blur => _blur;
  Color accent = Color(HiveManager().get("accentColorValue"));

  toggleThemeDarkMode(bool state) {
    _darkTheme = state;
    HiveManager().set("darkMode", state);
    notifyListeners();
  }

  changeThemeColor(Color color) {
    accent = color;
    HiveManager().set("accentColorValue", color.value);
    notifyListeners();
  }

  toggleBlur(bool state) {
    _blur = state;
    HiveManager().set("blur", state);
    notifyListeners();
  }
}
