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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ThemeData theme(BuildContext context) {
  final _data = context.watch<PreferenceProvider>();
  return ThemeData(
      //visualDensity: VisualDensity(horizontal: -3.5, vertical: -3.5),
      splashColor: Color(_data.accentColor),
      buttonColor: Color(_data.accentColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Theme.of(context).backgroundColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color(_data.accentColor)))),
      fontFamily: _data.fontFamily,
      brightness: _data.darkMode ? Brightness.dark : Brightness.light,
      accentColor: Color(_data.accentColor),
      backgroundColor: _data.darkMode ? Color(0xff0a0a0a) : Color(0xfff0f8ff),
      canvasColor: _data.darkMode ? Color(0xff151515) : Color(0xfff0f8ff),
      primaryColor: Color(_data.accentColor),
      primaryColorDark: Color(_data.accentColor),
      cardColor: _data.darkMode ? Color(0xff151515) : Colors.grey[200],
      scaffoldBackgroundColor:
          _data.darkMode ? Color(0xff151515) : Color(0xfff0f8ff),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Color(_data.accentColor),
        ),
      ),
      dialogBackgroundColor:
          _data.darkMode ? Color(0xfff0f8ff) : Color(0xff0a0a0a),
      toggleableActiveColor: Color(_data.accentColor),
      platform: TargetPlatform.android,
      sliderTheme: SliderThemeData(
          overlayColor: Color(_data.accentColor).withOpacity(0.1),
          thumbColor: Color(_data.accentColor),
          activeTrackColor: Color(_data.accentColor),
          inactiveTrackColor: Color(_data.accentColor).withOpacity(0.5),
          activeTickMarkColor: Colors.white.withOpacity(0.5),
          inactiveTickMarkColor: Colors.white.withOpacity(0.5)));
}
