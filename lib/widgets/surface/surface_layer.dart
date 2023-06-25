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

import 'package:flutter/material.dart';
import 'package:zenit_ui/zenit_ui.dart';

class SurfaceLayer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final OutlinedBorder shape;
  final Widget? child;
  final double? width;
  final double? height;
  final bool outline;
  final bool dropShadow;

  const SurfaceLayer({
    super.key,
    this.child,
    this.shape = const RoundedRectangleBorder(),
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.outline = false,
    this.dropShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: ShapeDecoration(
        shape: shape,
        color: theme.colorScheme.background,
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
        shape: shape.copyWith(
          // Create outline around the surface
          side: outline
              ? BorderSide(
                  color: theme.foregroundColor.withOpacity(0.1),
                )
              : BorderSide.none,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
