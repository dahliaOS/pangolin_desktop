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
    String jsonStringValues = await rootBundle
        .loadString("lib/localization/languages/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizationValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  Future loadBackup() async {
    String jsonStringValues =
        await rootBundle.loadString("lib/localization/languages/en.json");

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
    return ["en", "de", "fr", "pl", "hr", "nl", "es"]
        .contains(locale.languageCode);
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
