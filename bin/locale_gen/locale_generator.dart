import 'dart:convert';
import 'dart:io';

import 'xml_file_parser.dart';

class LocaleGenerator {
  final String localeDir;
  final String outputDir;

  LocaleGenerator(this.localeDir, this.outputDir);

  Future<void> generate() async {
    List<String> locales = [];
    List<Directory> paths = [];
    final Directory providedDir = Directory(localeDir);
    final Directory absoluteOutputDir = Directory(outputDir).absolute;
    final folders = providedDir.listSync();
    final localesBuffer = StringBuffer();

    final localesFile = File("${absoluteOutputDir.path}/locales.g.dart");
    final buffer = StringBuffer(_baseLocaleClass);

    for (var element in folders) {
      if (element is Directory) {
        final locale = getNameFromPath(element.path);
        locales.add(locale);
        paths.add(element);
      }
    }

    locales.sort((a, b) => a.compareTo(b));
    paths.sort((a, b) => a.path.compareTo(b.path));

    localesBuffer.writeln("import 'dart:ui';");
    localesBuffer.writeln();
    localesBuffer.writeln("class Locales {");
    localesBuffer.writeln("  Locales._();");
    localesBuffer.writeln();
    localesBuffer.writeln("  static List<Locale> get supported => [");
    locales.forEach((e) {
      final splittedLocale = e.split("-");
      localesBuffer.writeln(
          '    Locale("${splittedLocale[0]}", "${splittedLocale[1]}"),');
    });
    localesBuffer.writeln("  ];");
    localesBuffer.writeln();
    localesBuffer.writeln(
      "  static Map<String, Map<String, String>> get data => {",
    );
    for (int i = 0; i < locales.length; i++) {
      final locale = locales[i];
      final path = paths[i];
      Map<String, String> result = await XmlFileParser.load(path, locale);

      buffer.writeln();
      buffer.writeln(getLocaleClass(result, locale));
      final classInstance = "${getClassNameFromLocale(locale)}()";
      localesBuffer.writeln('    $classInstance.locale: $classInstance.data,');
    }
    localesBuffer.writeln("  };");
    localesBuffer.writeln("}");

    await localesFile
        .writeAsString(localesBuffer.toString() + "\n" + buffer.toString());
  }
}

String getNameFromPath(String path) {
  return path.split("/").last;
}

String getClassNameFromLocale(String locale) {
  final sanifiedName = locale.replaceAll("-", "");
  final initial = sanifiedName[0].toUpperCase();
  final capitalizedName = initial + sanifiedName.substring(1);
  return "_\$Locale$capitalizedName";
}

String _baseLocaleClass = """
abstract class _\$LocaleBase {
  String locale;
  Map<String, String> data;
}
""";

String getLocaleClass(Map<String, String> data, String locale) {
  StringBuffer buffer = StringBuffer();
  buffer.writeln(
      "class ${getClassNameFromLocale(locale)} extends _\$LocaleBase {");
  buffer.writeln("  @override");
  buffer.writeln("  String get locale => \"$locale\";");
  buffer.writeln();
  buffer.writeln("  @override");
  buffer.writeln("  Map<String, String> get data => {");
  data.forEach((key, value) {
    final encodedKey = json.encode(key);
    final encodedValue = json.encode(value);
    buffer.writeln('    $encodedKey: $encodedValue,');
  });
  buffer.writeln("  };");
  buffer.writeln("}");

  return buffer.toString();
}
