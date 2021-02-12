import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ThemeData theme(BuildContext context) {
  final _data = context.watch<PreferenceProvider>();
  return ThemeData(
      brightness: _data.darkMode ? Brightness.dark : Brightness.light,
      accentColor: Color(_data.accentColor),
      backgroundColor: _data.darkMode ? Colors.black : Colors.white,
      canvasColor: _data.darkMode ? Color(0xff111111) : Colors.white,
      primaryColor: Color(_data.accentColor),
      primaryColorDark: Color(_data.accentColor),
      cardColor: _data.darkMode ? Color(0xff0c0c0c) : Colors.grey[200],
      scaffoldBackgroundColor: _data.darkMode ? Colors.black : Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Color(_data.accentColor),
        ),
      ),
      toggleableActiveColor: Color(_data.accentColor),
      platform: TargetPlatform.android,
      sliderTheme: SliderThemeData(
          thumbColor: Color(_data.accentColor),
          activeTrackColor: Color(_data.accentColor),
          inactiveTrackColor: Color(_data.accentColor).withOpacity(0.5),
          activeTickMarkColor: Colors.white.withOpacity(0.5),
          inactiveTickMarkColor: Colors.white.withOpacity(0.5)));
}
