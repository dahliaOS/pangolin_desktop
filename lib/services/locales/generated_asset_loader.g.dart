import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import './locales.g.dart';

class GeneratedAssetLoader extends AssetLoader {
  @override
  Future<Map<String, String>> load(String path, Locale locale) async {
    return Locales.data[locale.toLanguageTag()] ?? {};
  }
}
