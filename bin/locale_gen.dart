import 'locale_gen/asset_loader_generator.dart';
import 'locale_gen/key_generator.dart';
import 'locale_gen/locale_generator.dart';

const String _localeFolder = "locales";
const String _outputFolder = "lib/internal/locales";
const String _defaultLocale = "en-US";
void main(List<String> args) async {
  final LocaleGenerator _localeGen =
      LocaleGenerator(_localeFolder, _outputFolder);
  await _localeGen.generate();
  final AssetLoaderGenerator _assetLoaderGen =
      AssetLoaderGenerator(_outputFolder);
  await _assetLoaderGen.generate();
  final KeyGenerator _keyGen = KeyGenerator(
    _localeFolder,
    _outputFolder,
    _defaultLocale,
  );
  await _keyGen.generate();

  print("Files generated inside $_outputFolder");
  return;
}
