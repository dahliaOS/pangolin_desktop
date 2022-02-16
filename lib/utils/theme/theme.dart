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
import 'package:pangolin/utils/theme/theme_manager.dart';

ThemeData theme(BuildContext context) {
  final _customizationProvider = CustomizationProvider.of(context);
  final Color _foregroundColor =
      Color(_customizationProvider.accentColor).computeLuminance() > 0.4
          ? ColorsX.black
          : ColorsX.white;
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
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
          Color(_customizationProvider.accentColor),
        ),
        elevation: MaterialStateProperty.all(0.0),
        foregroundColor: MaterialStateProperty.all(
          ThemeManager.of(context).foregroundColorOnAccentColor,
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      color: Color(_customizationProvider.accentColor),
      elevation: 0.0,
      iconTheme: IconThemeData(color: _foregroundColor),
    ),

    fontFamily: _customizationProvider.fontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness:
          _customizationProvider.darkMode ? Brightness.dark : Brightness.light,
      seedColor: Color(_customizationProvider.accentColor),
      secondary: Color(_customizationProvider.accentColor),
    ),
    backgroundColor: ThemeManager.of(context).backgroundColor,
    canvasColor: ThemeManager.of(context).surfaceColor,
    primaryColor: Color(_customizationProvider.accentColor),
    primaryColorDark: Color(_customizationProvider.accentColor),
    cardColor: ThemeManager.of(context).cardColor,
    scaffoldBackgroundColor: ThemeManager.of(context).surfaceColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(_customizationProvider.accentColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(_customizationProvider.accentColor),
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
    textTheme: const TextTheme(button: TextStyle(fontSize: 13)),
    dialogBackgroundColor: ThemeManager.of(context).backgroundColor,
    toggleableActiveColor: Color(_customizationProvider.accentColor),
    platform: TargetPlatform.fuchsia,
    sliderTheme: SliderThemeData(
      overlayColor: Color(_customizationProvider.accentColor).withOpacity(0.1),
      thumbColor: Color(_customizationProvider.accentColor),
      activeTrackColor: Color(_customizationProvider.accentColor),
      inactiveTrackColor:
          Color(_customizationProvider.accentColor).withOpacity(0.5),
      activeTickMarkColor: Colors.white.withOpacity(0.2),
      inactiveTickMarkColor: Colors.white.withOpacity(0.2),
    ),
    iconTheme: IconThemeData(
      color: _customizationProvider.darkMode ? ColorsX.white : ColorsX.black,
    ),
  );
}
