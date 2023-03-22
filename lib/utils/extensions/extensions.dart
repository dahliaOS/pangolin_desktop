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
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

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

  List<String>? getLocalizedKeywords(Locale locale) {
    if (domainKey != null && keywords != null) {
      final String translatedFromLangPack =
          LangPacksService.current.cacheLookup(
        extra[domainKey]!,
        "${keywords!.main.join(";")};",
        locale.toIntlLocale(),
      );
      final List<String> parts = translatedFromLangPack.split(";");
      parts.removeLast();

      return parts;
    }

    return keywords?.resolve(locale);
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

extension NotificationServiceX on NotificationService {
  UserNotification? getNotification(int id) {
    return notifications.firstWhereOrNull((e) => e.id == id);
  }
}
