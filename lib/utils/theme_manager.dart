import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  late final BuildContext context;
  ThemeManager.of(this.context);

  //Getter: accentColor
  Color get accentColor => Theme.of(context).colorScheme.secondary;

  //Getter: alternative accentColor
  Color get accentColorAlt =>
      HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
          .withLightness(
              HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
                      .lightness -
                  0.2)
          .toColor();

  //Getter forgreoundColor on accent
  Color get foregroundColorOnAccentColor =>
      this.accentColor.computeLuminance() < 0.4 ? Colors.white : Colors.black;
  //Getter forgreoundColor on accent
  Color get foregroundColorOnAccentColorAlt =>
      this.accentColor.computeLuminance() < 0.4 ? Colors.white : Colors.black;
}
