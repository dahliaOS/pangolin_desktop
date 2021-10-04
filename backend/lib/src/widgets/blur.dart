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
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blur extends StatelessWidget {
  final Widget? child;
  final bool? useBlur;
  final BorderRadius? borderRadius;
  final double? customBlur;
  Blur(
      {Key? key,
      @required this.child,
      this.borderRadius,
      this.useBlur,
      this.customBlur})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
    return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(_data.borderRadius),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: (useBlur ?? true)
                  ? (customBlur ?? (_data.enableBlur ? _data.blur : 0.0))
                  : 0.0,
              sigmaY: (useBlur ?? true)
                  ? (customBlur ?? (_data.enableBlur ? _data.blur : 0.0))
                  : 0.0),
          child: child,
        ));
  }
}
