import 'dart:io';

import 'package:recase/recase.dart';

import 'xml_file_parser.dart';

class KeyGenerator {
  final String localeDir;
  final String outputDir;

  KeyGenerator(this.localeDir, this.outputDir);

  Future<void> generate() async {
    List<String> locales = [];
    List<Directory> paths = [];
    final Directory providedDir = Directory(localeDir);
    final Directory absoluteOutputDir = Directory(outputDir).absolute;
    final folders = providedDir.listSync();
    final commonBuffer = StringBuffer();
    final stringClassesBuffer = StringBuffer();

    final localeStringsFile =
        File("${absoluteOutputDir.path}/locale_strings.g.dart");

    for (var element in folders) {
      if (element is Directory) {
        final locale = getNameFromPath(element.path);
        locales.add(locale);
        paths.add(element);
      }
    }

    final locale = locales[0];
    final path = paths[0];
    Map<String, Map<String, StringInfo>> result =
        await XmlFileParser.loadWithStringInfo(path, locale);

    commonBuffer
        .writeln("import 'package:easy_localization/easy_localization.dart';");
    commonBuffer.writeln();
    commonBuffer.writeln("class LocaleStrings {");
    commonBuffer.writeln("  LocaleStrings._();");
    commonBuffer.writeln();

    result.forEach((routeFile, keyStringInfo) {
      final currentBuffer = StringBuffer();
      final recasedRouteFile = ReCase(routeFile).camelCase;

      currentBuffer.writeln("class ${getClassNameFromRouteFile(routeFile)} {");
      keyStringInfo.forEach((key, stringInfo) {
        if (stringInfo is CommonString) {
          final varName = ReCase(key).camelCase;
          currentBuffer
              .writeln("  final String $varName = \"$routeFile.$key\".tr();");
        } else if (stringInfo is PluralString) {
          final varName = ReCase(key).camelCase;
          currentBuffer.writeln(
              "  String $varName(num value) => \"$routeFile.$key\".plural(value);");
        } else if (stringInfo is ArgumentString) {
          final varName = ReCase(key).camelCase;
          final argNum = stringInfo.argNum;
          final List<String> args = [];
          String string = "";

          string += "  String $varName(";
          for (int i = 0; i < argNum; i++) {
            args.add("arg${i + 1}.toString()");
            if (i == argNum - 1) {
              string += "dynamic arg${i + 1}) => ";
            } else {
              string += "dynamic arg${i + 1}, ";
            }
          }
          string += "\"$routeFile.$key\".tr(args: [${args.join(", ")}]);";
          currentBuffer.writeln(string);
        }
      });
      currentBuffer.writeln("}");
      stringClassesBuffer.writeln(currentBuffer.toString());

      final className = getClassNameFromRouteFile(routeFile);
      commonBuffer.writeln(
          "  static $className get $recasedRouteFile => $className();");
    });
    commonBuffer.writeln("}");

    await localeStringsFile.writeAsString(
        commonBuffer.toString() + "\n" + stringClassesBuffer.toString());
  }
}

String getNameFromPath(String path) {
  return path.split("/").last;
}

String getClassNameFromLocale(String locale) {
  return "_\$Locale${ReCase(locale).pascalCase}";
}

String getClassNameFromRouteFile(String routeFile) {
  return "_\$${ReCase(routeFile).pascalCase}LocaleStrings";
}
