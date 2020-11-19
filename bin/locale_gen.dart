import 'locale_gen/asset_loader_generator.dart';
import 'locale_gen/key_generator.dart';
import 'locale_gen/locale_generator.dart';

void main(List<String> args) async {
  if (args.isEmpty || args.length != 2) {
    print("Usage: dart bin/locale_gen.dart <locales folder> <output folder>");
    return;
  }

  final _localeGen = LocaleGenerator(args[0], args[1]);
  await _localeGen.generate();
  final _assetLoaderGen = AssetLoaderGenerator(args[1]);
  await _assetLoaderGen.generate();
  final _keyGen = KeyGenerator(args[0], args[1]);
  await _keyGen.generate();

  print("Files generated inside ${args[1]}");
  return;
}
