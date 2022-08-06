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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/other/resource.dart';

class Constants {
  const Constants._();

  /// General animation curve
  static const Curve animationCurve = Curves.easeInOut;

  /// General animation duration
  static const Duration animationDuration = Duration(milliseconds: 150);

  static const Map<String, MaterialColor> materialColors = {
    "red": Colors.red,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "deepPurple": Colors.deepPurple,
    "indigo": Colors.indigo,
    "blue": Colors.blue,
    "lightBlue": Colors.lightBlue,
    "cyan": Colors.cyan,
    "teal": Colors.teal,
    "green": Colors.green,
    "lightGreen": Colors.lightGreen,
    "lime": Colors.lime,
    "yellow": Colors.yellow,
    "amber": Colors.amber,
    "orange": Colors.orange,
    "deepOrange": Colors.deepOrange,
    "brown": Colors.brown,
    "grey": Colors.grey,
    "blueGrey": Colors.blueGrey,
  };

  static const OutlinedBorder smallShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const OutlinedBorder mediumShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const OutlinedBorder bigShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const OutlinedBorder circularShape = StadiumBorder();

  static const Map<String, IconData> builtinIcons = {
    'launcher_1': Icons.brightness_low,
    'launcher_2': Icons.apps_rounded,
    'launcher_3': Icons.panorama_fish_eye,
    'launcher_4': Icons.radio_button_checked,
  };
}

enum BuiltinColor {
  red(Color(0xFFD32F2F)),
  orange(Color(0xFFFF5722)),
  yellow(Color(0xFFFFC107)),
  green(Color(0xFF078D48)),
  teal(Color(0xFF00594F)),
  blue(Color(0xFF0067C0)),
  purple(Color(0xFF6200EE)),
  cyan(Color(0xFF00BCD4)),
  grey(Color(0xFF455A64));

  static BuiltinColor? getFromName(String name) {
    return BuiltinColor.values.firstWhereOrNull((e) => e.name == name);
  }

  final Color value;

  const BuiltinColor(this.value);

  ColorResource get resource => ColorResource(
        type: ColorResourceType.dahlia,
        value: name,
      );
}
