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
import 'package:pangolin/services/locales/locale_strings.g.dart';
import 'package:pangolin/utils/data/common_data.dart';

export 'package:flutter/material.dart';
export 'package:pangolin/services/locales/locale_strings.g.dart';
export 'package:pangolin/services/locales/locales.g.dart';
export 'package:pangolin/utils/extensions/extensions.dart';
export 'package:pangolin/utils/extensions/preference_extension.dart';
export 'package:pangolin/utils/icons/icons_x.dart';

typedef LSX = LocaleStrings;

extension ThemeDataX on ThemeData {
  bool get darkMode => brightness == Brightness.dark;

  Color get textColor => darkMode ? Colors.white : Colors.black;

  Color get accent => colorScheme.secondary;
  Color get backgroundColor => darkMode ? Colors.black : Colors.white;
  Color get foregroundColor =>
      accent.computeLuminance() > 0.4 ? Colors.black : Colors.white;
  Color get surfaceForegroundColor =>
      iconTheme.color ?? (darkMode ? Colors.white : Colors.black);

  Color computedForegroundColor(Color init) =>
      init.computeLuminance() > 0.4 ? Colors.black : Colors.white;
}

extension ColorsX on Color {
  Color op(double opacity) {
    return withOpacity(opacity);
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  CommonData get commonData => CommonData.of(this);

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
  BorderRadius get borderRadiusSmall => borderRadius(BorderRadiusType.small);
  BorderRadius get borderRadiusMedium => borderRadius(BorderRadiusType.medium);
  BorderRadius get borderRadiusBig => borderRadius(BorderRadiusType.big);
  BorderRadius get borderRadiusRound => borderRadius(BorderRadiusType.round);
}

mixin ThemeConstants {
  static EdgeInsets get buttonPadding =>
      const EdgeInsets.symmetric(horizontal: 4, vertical: 10);
}
