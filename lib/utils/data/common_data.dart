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

class CommonData {
  late BuildContext context;
  CommonData.of(this.context);

  // General BorderRadius
  BorderRadius borderRadius(BorderRadiusType elementSize) {
    if (elementSize == BorderRadiusType.small) {
      return BorderRadius.circular(8);
    }
    if (elementSize == BorderRadiusType.medium) {
      return BorderRadius.circular(12);
    }
    if (elementSize == BorderRadiusType.big) {
      return BorderRadius.circular(16);
    }
    if (elementSize == BorderRadiusType.round) {
      return BorderRadius.circular(200);
    }
    return BorderRadius.circular(0);
  }

  // Global Taskbar margin based on the Taskbar position
  EdgeInsets taskbarMargin() {
    final _taskbarProvider = CustomizationProvider.of(context);
    if (_taskbarProvider.isTaskbarBottom) {
      return const EdgeInsets.only(bottom: 48);
    }
    if (_taskbarProvider.isTaskbarLeft) {
      return const EdgeInsets.only(left: 48);
    }
    if (_taskbarProvider.isTaskbarRight) {
      return const EdgeInsets.only(right: 48);
    }
    if (_taskbarProvider.isTaskbarTop) {
      return const EdgeInsets.only(top: 48);
    } else {
      return const EdgeInsets.only(bottom: 48);
    }
  }

  // General animation curve
  Curve animationCurve() => Curves.easeInOut;

  //General animation duration
  Duration animationDuration() => const Duration(milliseconds: 150);

  // Text Color
  Color textColor() => Theme.of(context).brightness == Brightness.light
      ? Colors.black
      : Colors.white;

  // Alternative Text Color
  Color textColorAlt() => Theme.of(context).brightness == Brightness.dark
      ? Colors.black
      : Colors.white;
}

enum BorderRadiusType { small, medium, big, round }
