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

import 'dart:math';
import 'dart:ui';

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Credits: @HrX03 (https://github.com/hrx03)
class Acrylic extends StatelessWidget {
  final bool useBlur;
  final Color color;
  final Widget? child;
  final double? opacity, blurRadius, customBlur;
  Acrylic(
      {required this.color,
      required this.child,
      this.useBlur = true,
      this.opacity,
      this.customBlur,
      this.blurRadius});

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    final _tint = AcrylicHelper.getEffectiveTintColor(color, opacity ?? 0.9);
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: useBlur
              ? customBlur == null
                  ? (_pref.enableBlur ? blurRadius ?? 24 : 0)
                  : customBlur!
              : 0,
          sigmaY: useBlur
              ? customBlur == null
                  ? (_pref.enableBlur ? blurRadius ?? 24 : 0)
                  : customBlur!
              : 0,
        ),
        child: CustomPaint(
          painter: _AcrylicPainter(
            context: context,
            tintColor: _pref.enableBlur || useBlur ? _tint : Colors.transparent,
            luminosityColor: AcrylicHelper.getLuminosityColor(
                _pref.enableBlur || useBlur ? _tint : Colors.transparent,
                opacity ?? 0.9),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: useBlur
                  ? customBlur == null
                      ? (_pref.enableBlur || useBlur ? blurRadius ?? 24 : 0)
                      : customBlur!
                  : 0,
              sigmaY: useBlur
                  ? customBlur == null
                      ? (_pref.enableBlur || useBlur ? blurRadius ?? 24 : 0)
                      : customBlur!
                  : 0,
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: _pref.enableBlur ? 0.025 : 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/textures/NoiseAsset_256X256_PNG.png"),
                        alignment: Alignment.topLeft,
                        repeat: ImageRepeat.repeat,
                      ),
                      backgroundBlendMode: BlendMode.srcOver,
                      color: Colors.transparent,
                    ),
                    child: Container(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: child ?? Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Credits: @HrX03 (https://github.com/hrx03)
class _AcrylicPainter extends CustomPainter {
  static final Color red = Color(0xFFFF0000).withOpacity(0.12);
  static final Color blue = Color(0xFF00FF00).withOpacity(0.12);
  static final Color green = Color(0xFF0000FF).withOpacity(0.12);
  final Color luminosityColor;
  final Color tintColor;
  final BuildContext context;

  _AcrylicPainter(
      {required this.luminosityColor,
      required this.tintColor,
      required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(luminosityColor, BlendMode.luminosity);
    if (context.read<PreferenceProvider>().enableBlur) {
      canvas.drawColor(red, BlendMode.saturation);
      canvas.drawColor(blue, BlendMode.saturation);
      canvas.drawColor(green, BlendMode.saturation);
      canvas.drawColor(
        tintColor,
        tintColor.opacity == 1 ? BlendMode.srcIn : BlendMode.color,
      );
      /* canvas.drawColor(
          Color(Provider.of<PreferenceProvider>(context, listen: false)
                  .accentColor)
              .withOpacity(0.05),
          BlendMode.srcOver); */
    }
  }

  @override
  bool shouldRepaint(_AcrylicPainter old) {
    return this.luminosityColor != old.luminosityColor ||
        this.tintColor != old.tintColor;
  }
}

// Credits: @HrX03 (https://github.com/hrx03)
/// Microsoft utils converted from C# to dart
class AcrylicHelper {
  static Color getEffectiveTintColor(Color color, double opacity) {
    // Update tintColor's alpha with the combined opacity value
    // If LuminosityOpacity was specified, we don't intervene into users parameters
    return color.withOpacity(opacity);
  }

  static Color getLuminosityColor(Color tintColor, double? luminosityOpacity) {
    // If luminosity opacity is specified, just use the values as is
    if (luminosityOpacity != null) {
      return Color.fromRGBO(
        tintColor.red,
        tintColor.green,
        tintColor.blue,
        luminosityOpacity.clamp(0.0, 1.0),
      );
    } else {
      // To create the Luminosity blend input color without luminosity opacity,
      // we're taking the TintColor input, converting to HSV, and clamping the V between these values
      const double minHsvV = 0.125;
      const double maxHsvV = 0.965;

      HSVColor hsvTintColor = HSVColor.fromColor(tintColor);

      double clampedHsvV = hsvTintColor.value.clamp(minHsvV, maxHsvV);

      HSVColor hsvLuminosityColor = hsvTintColor.withValue(clampedHsvV);
      Color rgbLuminosityColor = hsvLuminosityColor.toColor();

      // Now figure out luminosity opacity
      // Map original *tint* opacity to this range
      const double minLuminosityOpacity = 0.15;
      const double maxLuminosityOpacity = 1.03;

      const double luminosityOpacityRangeMax =
          maxLuminosityOpacity - minLuminosityOpacity;
      double mappedTintOpacity =
          ((tintColor.alpha / 255.0) * luminosityOpacityRangeMax) +
              minLuminosityOpacity;

      // Finally, combine the luminosity opacity and the HsvV-clamped tint color
      return Color.fromRGBO(
        rgbLuminosityColor.red,
        rgbLuminosityColor.green,
        rgbLuminosityColor.blue,
        min(mappedTintOpacity, 1.0),
      );
    }
  }

  static double getTintOpacityModifier(Color color) {
    // Mid point of HsvV range that these calculations are based on. This is here for easy tuning.
    const double midPoint = 0.50;

    const double whiteMaxOpacity = 0.45; // 100% luminosity
    const double midPointMaxOpacity = 0.90; // 50% luminosity
    const double blackMaxOpacity = 0.85; // 0% luminosity

    HSVColor hsv = HSVColor.fromColor(color);

    double opacityModifier = midPointMaxOpacity;

    if (hsv.value != midPoint) {
      // Determine maximum suppression amount
      double lowestMaxOpacity = midPointMaxOpacity;
      double maxDeviation = midPoint;

      if (hsv.value > midPoint) {
        lowestMaxOpacity = whiteMaxOpacity; // At white (100% hsvV)
        maxDeviation = 1 - maxDeviation;
      } else if (hsv.value < midPoint) {
        lowestMaxOpacity = blackMaxOpacity; // At black (0% hsvV)
      }

      double maxOpacitySuppression = midPointMaxOpacity - lowestMaxOpacity;

      // Determine normalized deviation from the midpoint
      double deviation = (hsv.value - midPoint);
      double normalizedDeviation = deviation / maxDeviation;

      // If we have saturation, reduce opacity suppression to allow that color to come through more
      if (hsv.saturation > 0) {
        // Dampen opacity suppression based on how much saturation there is
        maxOpacitySuppression *= max(1 - (hsv.saturation * 2), 0.0);
      }

      double opacitySuppression = maxOpacitySuppression * normalizedDeviation;

      opacityModifier = midPointMaxOpacity - opacitySuppression;
    }

    return opacityModifier;
  }
}
