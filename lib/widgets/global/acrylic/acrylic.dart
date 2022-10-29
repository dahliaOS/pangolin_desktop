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

import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class AcrylicLayer extends StatelessWidget {
  const AcrylicLayer({
    super.key,
    required this.child,
    this.isBackground = false,
    this.enableBlur = true,
    this.enableNoise = true,
    this.opacity = 0.5,
  });
  final Widget? child;
  final bool isBackground;
  final bool enableBlur;
  final bool enableNoise;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: CustomPaint(
        painter: AcrylicLayerPainter(
          darkMode: Theme.of(context).brightness == Brightness.dark,
          isBackground: isBackground,
          opacity: opacity,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Stack(
            children: [
              Opacity(
                opacity: noiseOpacity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/textures/NoiseAsset_256X256_PNG.png',
                      ),
                      alignment: Alignment.topLeft,
                      repeat: ImageRepeat.repeat,
                    ),
                    backgroundBlendMode: BlendMode.srcOver,
                    color: Colors.transparent,
                  ),
                  child: Container(),
                ),
              ),
              Center(child: child),
            ],
          ),
        ),
      ),
    );
  }

  double get noiseOpacity => enableNoise ? 0.02 : 0.0;

  double get blurSigma => enableBlur ? 32 : (kIsWeb ? 0.1 : 0.0);
}

class AcrylicLayerPainter extends CustomPainter {
  // const
  const AcrylicLayerPainter({
    required this.darkMode,
    required this.isBackground,
    this.opacity = 0.5,
  });
  // vars
  final bool darkMode;
  final bool isBackground;
  final double opacity;

  // painter
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final darkModeColor = const Color(0xff0a0a0a).withOpacity(opacity);
    final lightModeColor = const Color(0xfffafafa).withOpacity(opacity);

    /* canvas.drawColor(
      darkMode ? _darkModeColor : _lightModeColor,
      BlendMode.luminosity,
    ); */
    const red = Color(0x00ff0000);
    const green = Color(0x0000ff00);
    const blue = Color(0x000000ff);
    if (isBackground) {
      canvas
        ..drawColor(red.withOpacity(0.25), BlendMode.luminosity)
        ..drawColor(green.withOpacity(0.25), BlendMode.luminosity)
        ..drawColor(blue.withOpacity(0.25), BlendMode.luminosity)
        ..drawColor(red.withOpacity(0.05), BlendMode.saturation)
        ..drawColor(green.withOpacity(0.05), BlendMode.saturation)
        ..drawColor(blue.withOpacity(0.05), BlendMode.saturation)
        ..drawColor(Colors.black.withOpacity(0.2), BlendMode.darken);
    }
    darkMode
        ? canvas.drawColor(darkModeColor, BlendMode.darken)
        : canvas.drawColor(lightModeColor, BlendMode.lighten);
  }

  @override
  bool shouldRepaint(covariant AcrylicLayerPainter oldDelegate) {
    return darkMode != oldDelegate.darkMode;
  }
}
