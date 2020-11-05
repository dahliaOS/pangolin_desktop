/*
Copyright 2019 The dahliaOS Authors
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

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String> _localizationValues;
  Map<String, String> _localizationBackupValues;

  Future load() async {
    String jsonStringValues;
    try {
      jsonStringValues = await rootBundle.loadString(
          "assets/locales/${locale.languageCode}_${locale.countryCode}.json");
    } catch (e) {
      print(e);
      jsonStringValues = await rootBundle
          .loadString("assets/locales/en_US.json");
      print("Using backup JSON for localization");
    }

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizationValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  Future loadBackup() async {
    String jsonStringValues = await rootBundle
        .loadString("assets/locales/en_US.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizationBackupValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String get(String key) {
    if (_localizationValues[key] == null) {
      if (_localizationBackupValues[key] == null) {
        return "Error";
      } else {
        return _localizationBackupValues[key];
      }
    } else {
      return _localizationValues[key];
    }
  }

  static const LocalizationsDelegate<Localization> delegate =
      _LocalizationDelegate();
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      "ar",
      "bs",
      "hr",
      "nl",
      "en",
      "fr",
      "de",
      "id",
      "pl",
      "pt",
      "ru",
      "sv",
      "uk"
    ].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = new Localization(locale);
    await localization.load();
    await localization.loadBackup();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
