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
import 'package:flutter/material.dart';

class AcrylicLayer extends StatelessWidget {
  final Widget? child;
  const AcrylicLayer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
      child: CustomPaint(
        painter: AcrylicLayerPainter(
          darkMode: Theme.of(context).brightness == Brightness.dark,
          tintColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.025,
              child: DecoratedBox(
                decoration: const BoxDecoration(
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
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class AcrylicLayerPainter extends CustomPainter {
  // vars
  final bool darkMode;
  final Color tintColor;

  // const
  const AcrylicLayerPainter({required this.darkMode, required this.tintColor});

  // painter
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    var _darkModeColor = const Color(0xff0a0a0a).withOpacity(0.6);
    var _lightModeColor = const Color(0xfffafafa).withOpacity(0.6);

    canvas.drawColor(
        darkMode ? _darkModeColor : _lightModeColor, BlendMode.luminosity);
    canvas.drawColor(tintColor.withOpacity(0.10), BlendMode.color);
  }

  @override
  bool shouldRepaint(covariant AcrylicLayerPainter oldDelegate) {
    return darkMode != oldDelegate.darkMode;
  }
}
