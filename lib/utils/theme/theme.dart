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
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

ThemeData theme(BuildContext context) {
  final _customizationProvider = CustomizationProvider.of(context);

  final bool darkMode = _customizationProvider.darkMode;

  final Color accentColor = Color(_customizationProvider.accentColor);
  final Color foregroundColor = context.theme.foregroundColor;
  final Color backgroundColor = darkMode ? Colors.black : Colors.white;
  final Color surfaceForegroundColor = darkMode ? Colors.white : Colors.black;
  final Color surfaceColor = Color(darkMode ? 0xff1E1E1E : 0xffffffff);
  final Color cardColor = Color(darkMode ? 0xFF2c2c2c : 0xFFEBEBEB);

  final String fontFamily = _customizationProvider.fontFamily;

  final Brightness brightness = darkMode ? Brightness.dark : Brightness.light;

  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            FadeThroughPageTransitionsBuilder(fillColor: Colors.transparent),
      },
    ),
    hoverColor: context.theme.colorScheme.surface.withOpacity(0.25),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      foregroundColor: foregroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          accentColor,
        ),
        elevation: MaterialStateProperty.all(0.0),
        foregroundColor: MaterialStateProperty.all(
          foregroundColor,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: accentColor,
      elevation: 0.0,
      iconTheme: IconThemeData(color: foregroundColor),
    ),
    fontFamily: fontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: accentColor,
      secondary: accentColor,
    ),
    backgroundColor: backgroundColor,
    canvasColor: surfaceColor,
    primaryColor: accentColor,
    primaryColorDark: accentColor,
    cardColor: cardColor,
    scaffoldBackgroundColor: surfaceColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: accentColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: accentColor,
          width: 2,
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    //TODO Text Theme
    textTheme: const TextTheme(
      button: TextStyle(fontSize: 13),
      /* displaySmall: TextStyle(fontSize: 11),
      displayMedium: TextStyle(fontSize: 12),
      displayLarge: TextStyle(fontSize: 13),
      //body
      bodySmall: TextStyle(fontSize: 11),
      bodyMedium: TextStyle(fontSize: 12),
      bodyLarge: TextStyle(fontSize: 13),
      //label
      labelSmall: TextStyle(fontSize: 11),
      labelMedium: TextStyle(fontSize: 12),
      labelLarge: TextStyle(fontSize: 13),
      //title
      titleSmall: TextStyle(fontSize: 11),
      titleMedium: TextStyle(fontSize: 12),
      titleLarge: TextStyle(fontSize: 13),

      //headline
      headlineSmall: TextStyle(fontSize: 11),
      headlineMedium: TextStyle(fontSize: 12),
      headlineLarge: TextStyle(fontSize: 13), */
    ),
    dialogBackgroundColor: backgroundColor,
    toggleableActiveColor: accentColor,
    platform: TargetPlatform.fuchsia,
    sliderTheme: SliderThemeData(
      overlayColor: accentColor.op(0.1),
      thumbColor: accentColor,
      activeTrackColor: accentColor,
      inactiveTrackColor: accentColor.op(0.5),
      activeTickMarkColor: Colors.white.op(0.2),
      inactiveTickMarkColor: Colors.white.op(0.2),
    ),
    iconTheme: IconThemeData(
      color: surfaceForegroundColor,
    ),
  );
}
