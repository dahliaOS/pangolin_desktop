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
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

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

mixin ThemeConstants {
  static EdgeInsets get buttonPadding =>
      const EdgeInsets.symmetric(horizontal: 4, vertical: 10);
}

extension LocalizedResourceResolve<T> on LocalizedResource<T> {
  T resolve(Locale locale) => getForLocale(
        XdgLocale(
          locale.languageCode,
          locale.countryCode,
          locale.scriptCode,
        ),
      );
}

extension DesktopEntryLocalizer on DesktopEntry {
  String? get domainKey => extra.keys.firstWhereOrNull(
        (e) => RegExp("X-.+-Gettext-Domain").hasMatch(e),
      );
  String? get domain => domainKey != null ? extra[domainKey!] : null;

  String getLocalizedName(Locale locale) {
    return domainKey != null
        ? LangPacksService.current.cacheLookup(
            extra[domainKey]!,
            name.main,
            locale.toIntlLocale(),
          )
        : name.resolve(locale);
  }

  String? getLocalizedComment(Locale locale) {
    return domainKey != null && comment != null
        ? LangPacksService.current.cacheLookup(
            extra[domainKey]!,
            comment!.main,
            locale.toIntlLocale(),
          )
        : comment?.resolve(locale);
  }

  String? getLocalizedGenericName(Locale locale) {
    return domainKey != null && genericName != null
        ? LangPacksService.current.cacheLookup(
            extra[domainKey]!,
            genericName!.main,
            locale.toIntlLocale(),
          )
        : genericName?.resolve(locale);
  }
}

extension ResourcePointerUtils on String {
  Resource toResource() {
    return Resource.parse(this);
  }

  Color? toColor() {
    final Resource resource;

    try {
      resource = toResource();
    } catch (e) {
      return null;
    }

    if (resource is! ColorResource) return null;

    return resource.resolve();
  }
}

extension BuiltinColorLabel on BuiltinColor {
  String get label {
    switch (this) {
      case BuiltinColor.red:
        return strings.settings.pagesCustomizationThemeColorRed;
      case BuiltinColor.orange:
        return strings.settings.pagesCustomizationThemeColorOrange;
      case BuiltinColor.yellow:
        return strings.settings.pagesCustomizationThemeColorGold;
      case BuiltinColor.green:
        return strings.settings.pagesCustomizationThemeColorGreen;
      case BuiltinColor.teal:
        return strings.settings.pagesCustomizationThemeColorTeal;
      case BuiltinColor.blue:
        return strings.settings.pagesCustomizationThemeColorBlue;
      case BuiltinColor.purple:
        return strings.settings.pagesCustomizationThemeColorPruple;
      case BuiltinColor.cyan:
        return strings.settings.pagesCustomizationThemeColorAqua;
      case BuiltinColor.grey:
        return strings.settings.pagesCustomizationThemeColorAnthracite;
    }
  }
}

extension CustomizationServiceX on CustomizationService {
  void addRecentWallpaper(ImageResource wallpaper) {
    recentWallpapers = [...recentWallpapers, wallpaper];
  }

  void togglePinnedApp(String packageName) {
    if (pinnedApps.contains(packageName)) {
      pinnedApps = List.from(pinnedApps)..remove(packageName);
    } else {
      pinnedApps = List.from(pinnedApps)..add(packageName);
    }
  }
}

extension NotificationServiceX on NotificationService {
  UserNotification? getNotification(int id) {
    return notifications.firstWhereOrNull((e) => e.id == id);
  }
}
