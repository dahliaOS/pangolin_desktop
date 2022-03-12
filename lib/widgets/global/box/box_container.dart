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
import 'package:pangolin/widgets/global/acrylic/acrylic.dart';

class BoxSurface extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;
  final Widget? child;
  final double? width;
  final double? height;
  final bool outline;
  final bool dropShadow;

  const BoxSurface({
    Key? key,
    this.child,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.outline = false,
    this.dropShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _darkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          // Set border radius of the surface area
          borderRadius: borderRadius,
        ),
        shadows: dropShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  spreadRadius: -2,
                  blurStyle: BlurStyle.outer,
                ),
              ]
            : [],
      ),
      foregroundDecoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          // Set border radius of the surface area
          borderRadius: borderRadius,
          // Create outline around the surface
          side: outline
              ? BorderSide(
                  color:
                      _darkMode ? ColorsX.white.op(0.1) : ColorsX.black.op(0.2),
                  width: 2,
                )
              : BorderSide.none,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: AcrylicLayer(
          child: child ?? Container(),
        ),
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;
  final Widget? child;
  final double? width;
  final double? height;
  final bool outline;

  /// Enable or disable the acrylic effect of this container.
  /// When disabled, a semi-transparent layer is applied instead.
  final bool acrylic;

  const BoxContainer({
    Key? key,
    this.child,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.outline = false,
    this.acrylic = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _darkMode = Theme.of(context).brightness == Brightness.dark;
    final Widget innerChild = child ?? Container();
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      foregroundDecoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          // Set border radius of the surface area
          borderRadius: borderRadius,
          // Create outline around the surface
          side: outline
              ? BorderSide(
                  color: _darkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.2),
                  width: 2,
                )
              : BorderSide.none,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: acrylic
            ? AcrylicLayer(
                child: innerChild,
              )
            : CustomPaint(
                painter: AcrylicLayerPainter(
                  darkMode: _darkMode,
                  tintColor: Theme.of(context).colorScheme.secondary,
                ),
                child: innerChild,
              ),
      ),
    );
  }
}
