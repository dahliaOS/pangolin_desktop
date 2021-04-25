import 'dart:io';

class AssetLoaderGenerator {
  final String outputDir;

  AssetLoaderGenerator(this.outputDir);

  Future<void> generate() async {
    final File file = File("$outputDir/generated_asset_loader.g.dart");
    await file.writeAsString(_class);
  }
}

String _class = """
// @dart=2.12

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import './locales.g.dart';

class GeneratedAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return Locales.data[locale.toLanguageTag()] ?? {};
  }
}
""";
