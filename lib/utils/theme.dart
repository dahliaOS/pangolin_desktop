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

import 'package:animations/animations.dart';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/cupertino/theme.dart';
import 'package:provider/provider.dart';

ThemeData theme(BuildContext context) {
  final _data = context.watch<PreferenceProvider>();
  return ThemeData(
    //visualDensity: VisualDensity(horizontal: -3.5, vertical: -3.5),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            FadeThroughPageTransitionsBuilder(fillColor: Colors.transparent),
      },
    ),
    //hoverColor: Color(_data.accentColor).withOpacity(0.5),
    splashColor: Color(_data.accentColor),
    /* buttonColor: Color(_data.accentColor), */
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(_data.accentColor),
        ),
      ),
    ),

    fontFamily: _data.fontFamily,
    /* brightness: _data.darkMode ? Brightness.dark : Brightness.light,
    accentColor: Color(_data.accentColor), */
    colorScheme: ColorScheme(
      background: CustomThemeData.of(context).backgroundColor,
      brightness: _data.darkMode ? Brightness.dark : Brightness.light,
      error: Colors.red,
      onBackground: Colors.grey,
      onError: Colors.red[900]!,
      onPrimary: Color(_data.accentColor),
      onSecondary: Color(_data.accentColor),
      onSurface: Color(0xff141414),
      primary: Color(_data.accentColor),
      primaryVariant: Color(_data.accentColor),
      secondary: Color(_data.accentColor),
      secondaryVariant: Color(_data.accentColor),
      surface: Color(0xff141414),
    ),
    backgroundColor: _data.darkMode ? Color(0xff0a0a0a) : Color(0xffffffff),
    canvasColor: _data.darkMode ? Color(0xff151515) : Color(0xffffffff),
    primaryColor: Color(_data.accentColor),
    primaryColorDark: Color(_data.accentColor),
    cardColor: _data.darkMode ? Color(0xff151515) : Color(0xffffffff),
    scaffoldBackgroundColor:
        _data.darkMode ? Color(0xff151515) : Color(0xffffffff),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(_data.accentColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(_data.accentColor),
          width: 2,
        ),
      ),
    ),
    dialogBackgroundColor:
        !_data.darkMode ? Color(0xffffffff) : Color(0xff0a0a0a),
    toggleableActiveColor: Color(_data.accentColor),
    platform: TargetPlatform.android,
    sliderTheme: SliderThemeData(
      overlayColor: Color(_data.accentColor).withOpacity(0.1),
      thumbColor: Color(_data.accentColor),
      activeTrackColor: Color(_data.accentColor),
      inactiveTrackColor: Color(_data.accentColor).withOpacity(0.5),
      activeTickMarkColor: Colors.white.withOpacity(0.5),
      inactiveTickMarkColor: Colors.white.withOpacity(0.5),
    ),
  );
}

class CustomThemeData {
  final Color backgroundColor,
      surfaceColor,
      accentColor,
      variantColor,
      textColor,
      textVariantColor;

  const CustomThemeData({
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.variantColor,
    required this.textColor,
    required this.textVariantColor,
  });

  static CustomThemeData of(BuildContext context) {
    final Color _accentColor,
        _backgroundColor,
        _surfaceColor,
        _variantColor,
        _textColor,
        _textVariantColor;
    final _provider = Provider.of<PreferenceProvider>(context);
    _accentColor = Color(_provider.accentColor);
    _backgroundColor =
        _provider.darkMode ? Color(0xff0a0a0a) : Color(0xfffafafa);
    _surfaceColor = _provider.darkMode ? Color(0xff141414) : Color(0xffffffff);
    _variantColor = _provider.darkMode ? Color(0xfffafafa) : Color(0xff0a0a0a);
    _textColor = _provider.darkMode ? Color(0xfffafafa) : Color(0xff0a0a0a);
    _textVariantColor =
        _provider.darkMode ? Color(0xff0a0a0a) : Color(0xfffafafa);
    return CustomThemeData(
        accentColor: _accentColor,
        backgroundColor: _backgroundColor,
        surfaceColor: _surfaceColor,
        variantColor: _variantColor,
        textColor: _textColor,
        textVariantColor: _textVariantColor);
  }
}
