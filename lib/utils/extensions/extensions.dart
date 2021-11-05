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
import 'package:pangolin/utils/data/common_data.dart';

export 'package:flutter/material.dart';
export 'package:pangolin/utils/extensions/extensions.dart';
export 'package:pangolin/utils/icons/icons_x.dart';
export 'package:pangolin/utils/extensions/preference_extension.dart';
export 'package:pangolin/utils/providers/provider_manager.dart';

extension ThemeDataX on ThemeData {
  bool get darkMode => this.brightness == Brightness.dark;
  Color get elementColor => darkMode ? Color(0xff0a0a0a) : Color(0xfffafafa);
  Color get elementHoverColor => darkMode
      ? Color(0xff0a0a0a).withOpacity(0.2)
      : Color(0xfffafafa).withOpacity(0.2);

  Color get textColor => darkMode ? ColorsX.white : ColorsX.black;
}

extension ColorsX on Color {
  static Color get white => Color(0xfffafafa);
  static Color get black => Color(0xff0a0a0a);
  static Color get transparent => Colors.transparent;
  Color op(double opacity) {
    return this.withOpacity(opacity);
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  CommonData get commonData => CommonData.of(this);

  Color get accentColor => theme.colorScheme.secondary;
  Color get backgroundColor => theme.darkMode ? ColorsX.black : ColorsX.white;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mSize => mediaQuery.size;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsetsDirectional get viewPaddingDirectional {
    switch (directionality) {
      case TextDirection.ltr:
        return EdgeInsetsDirectional.fromSTEB(
          viewPadding.left,
          viewPadding.top,
          viewPadding.right,
          viewPadding.bottom,
        );
      case TextDirection.rtl:
        return EdgeInsetsDirectional.fromSTEB(
          viewPadding.right,
          viewPadding.top,
          viewPadding.left,
          viewPadding.bottom,
        );
    }
  }

  TextDirection get directionality => Directionality.of(this);

  NavigatorState get navigator => Navigator.of(this);
  void pop<T extends Object?>([T? result]) => navigator.pop<T?>(result);
  Future<T?> push<T extends Object?>(Route<T> route) =>
      navigator.push<T?>(route);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  OverlayState? get overlay => Overlay.of(this);
}

extension CommonDataX on CommonData {
  BorderRadiusGeometry get borderRadiusSmall =>
      this.borderRadius(BorderRadiusType.SMALL);
  BorderRadiusGeometry get borderRadiusMedium =>
      this.borderRadius(BorderRadiusType.MEDIUM);
  BorderRadiusGeometry get borderRadiusBig =>
      this.borderRadius(BorderRadiusType.BIG);
  BorderRadiusGeometry get borderRadiusRound =>
      this.borderRadius(BorderRadiusType.ROUND);
}
