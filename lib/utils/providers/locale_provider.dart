/*
Copyright 2022 The dahliaOS Authors

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

import 'package:intl/locale.dart';
import 'package:pangolin/generated/locale.dart';
import 'package:yatl_flutter/yatl_flutter.dart';
import 'package:yatl_gen/yatl_gen.dart';

class _LocaleProviders {
  _LocaleProviders._();

  static final _LocaleProviders instance = _LocaleProviders._();

  static const GeneratedLocales _locales = GeneratedLocales();

  late YatlCore _yatl;
  late GeneratedLocaleStrings _strings;

  Future<void> init() async {
    _yatl = YatlCore(
      loader: const LocalesTranslationsLoader(_locales),
      supportedLocales: _locales.supportedLocales,
      fallbackLocale: Locale.parse('en_US'),
    );
    await _yatl.init();
    _strings = GeneratedLocaleStrings(_yatl);
  }
}

_LocaleProviders get _instance => _LocaleProviders.instance;

Future<void> initProviders() async => _instance.init();

YatlCore get yatl => _instance._yatl;

GeneratedLocales get locales => _LocaleProviders._locales;

GeneratedLocaleStrings get strings => _instance._strings;
