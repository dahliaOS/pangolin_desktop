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
                      context.theme.backgroundColor.op(0.2),
                  width: 2,
                )
              : BorderSide.none,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: AcrylicLayer(
          isBackground: true,
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
  final double opacity;

  const BoxContainer({
    Key? key,
    this.child,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.outline = false,
    this.opacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _darkMode = Theme.of(context).darkMode;
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
        child: AcrylicLayer(
          opacity: opacity,
          enableBlur: false,
          enableNoise: false,
          child: child ?? Container(),
        ),
      ),
    );
  }
}
