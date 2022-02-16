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

import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class ThemeManager {
  final BuildContext context;
  late bool _darkMode;
  ThemeManager.of(this.context) {
    _darkMode = CustomizationProvider.of(context).darkMode;
  }

  //Getter: accentColor
  Color get accentColor => Theme.of(context).colorScheme.secondary;

  //Getter: alternative accentColor
  Color get accentColorAlt {
    final _hsl = HSLColor.fromColor(Theme.of(context).colorScheme.secondary);
    late HSLColor accentAltHSL;
    if (_hsl.lightness < 0.2) {
      accentAltHSL =
          _hsl.withLightness(_hsl.lightness + (_hsl.lightness * 0.5));
    } else {
      accentAltHSL =
          _hsl.withLightness(_hsl.lightness - (_hsl.lightness * 0.25));
    }

    if (accentAltHSL.saturation > 0.9) {
      accentAltHSL = accentAltHSL
          .withSaturation(_hsl.saturation - (_hsl.saturation * 0.2));
    }
    return accentAltHSL.toColor();
  }

  //Getter forgreoundColor on accent
  Color get foregroundColorOnAccentColor =>
      accentColor.computeLuminance() < 0.4 ? Colors.white : Colors.black;

  //Getter forgreoundColor on accent
  Color get foregroundColorOnSurface =>
      surfaceColor.computeLuminance() < 0.4 ? Colors.white : Colors.black;

  //TODO check usage of the following var
  //Getter forgreoundColor on accent
  /* Color get foregroundColorOnAccentColorAlt =>
      this.accentColor.computeLuminance() < 0.4 ? Colors.white : Colors.black; */

  //Getter: surfaceColor
  Color get surfaceColor =>
      _darkMode ? const Color(0xff1E1E1E) : const Color(0xffffffff);

  //Getter: backgroundColor
  Color get backgroundColor =>
      _darkMode ? const Color(0xff0a0a0a) : const Color(0xffffffff);

  //Getter: cardColor
  Color get cardColor =>
      _darkMode ? const Color(0xFF2c2c2c) : const Color(0xffEBEBEB);
}

mixin ThemeConstants {
  static EdgeInsets get buttonPadding =>
      const EdgeInsets.symmetric(horizontal: 4, vertical: 10);
}
