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
import 'package:pangolin/utils/extensions/extensions.dart';
import 'theme_manager.dart';
import 'package:provider/provider.dart';

ThemeData theme(BuildContext context) {
  final _data = context.watch<PreferenceProvider>();
  final Color _foregroundColor =
      Color(_data.accentColor).computeLuminance() > 0.4
          ? ColorsX.black
          : ColorsX.white;
  return ThemeData(
    //visualDensity: VisualDensity(horizontal: -3.5, vertical: -3.5),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            FadeThroughPageTransitionsBuilder(fillColor: Colors.transparent),
      },
    ),
    hoverColor: context.theme.colorScheme.surface.withOpacity(0.25),
    //splashColor: Color(_data.accentColor),
    /* buttonColor: Color(_data.accentColor), */
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      foregroundColor: _foregroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(_data.accentColor),
        ),
        elevation: MaterialStateProperty.all(0.0),
        foregroundColor: MaterialStateProperty.all(
            ThemeManager.of(context).foregroundColorOnAccentColor),
      ),
    ),

    fontFamily: _data.fontFamily,
    /* brightness: _data.darkMode ? Brightness.dark : Brightness.light,
    accentColor: Color(_data.accentColor), */
    colorScheme: ColorScheme(
      background: ThemeManager.of(context).backgroundColor,
      brightness: _data.darkMode ? Brightness.dark : Brightness.light,
      error: Colors.red,
      onBackground: Colors.grey,
      onError: Colors.red[900]!,
      onPrimary: Color(_data.accentColor),
      onSecondary: Color(_data.accentColor),
      //TODO changes color of the slider tooltip idk if it breaks anything
      onSurface: _data.darkMode ? ColorsX.black : ColorsX.white,
      primary: Color(_data.accentColor),
      primaryVariant: Color(_data.accentColor),
      secondary: Color(_data.accentColor),
      secondaryVariant: Color(_data.accentColor),
      surface: _data.darkMode ? ColorsX.black : ColorsX.white,
    ),
    backgroundColor: ThemeManager.of(context).backgroundColor,
    canvasColor: ThemeManager.of(context).surfaceColor,
    primaryColor: Color(_data.accentColor),
    primaryColorDark: Color(_data.accentColor),
    cardColor: ThemeManager.of(context).cardColor,
    scaffoldBackgroundColor: ThemeManager.of(context).surfaceColor,
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
    dialogBackgroundColor: ThemeManager.of(context).backgroundColor,
    toggleableActiveColor: Color(_data.accentColor),
    platform: TargetPlatform.android,
    sliderTheme: SliderThemeData(
      overlayColor: Color(_data.accentColor).withOpacity(0.1),
      thumbColor: Color(_data.accentColor),
      activeTrackColor: Color(_data.accentColor),
      inactiveTrackColor: Color(_data.accentColor).withOpacity(0.5),
      activeTickMarkColor: Colors.white.withOpacity(0.2),
      inactiveTickMarkColor: Colors.white.withOpacity(0.2),
    ),
    iconTheme: IconThemeData(
      color: _data.darkMode ? ColorsX.white : ColorsX.black,
    ),
  );
}
