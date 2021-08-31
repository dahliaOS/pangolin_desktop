import 'dart:io';

import 'package:xml/xml.dart';

class XmlFileParser {
  const XmlFileParser._();

  static Future<ParseResult> load(File file, String locale) async {
    final Map<String, String> returnMap = {};
    int stringCount = 0;

    final String fileContent = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileContent);
    document.normalize();

    final XmlElement base = document.lastElementChild!;

    for (final XmlNode item in base.children) {
      if (item is XmlElement) {
        final XmlElement element = item;

        final String? name = element.getAttribute("name");
        if (name == null) continue;

        if (element.name.toString() == "string") {
          stringCount++;
          returnMap[name] = _replacer(element.text);
        } else if (element.name.toString() == "plurals") {
          stringCount++;
          for (final XmlNode plural in element.children) {
            if (plural is XmlElement) {
              final XmlElement pluralElement = plural;

              final String? pluralAttribute =
                  pluralElement.getAttribute("quantity");
              if (pluralAttribute == null) continue;

              returnMap["$name.$pluralAttribute"] =
                  _replacer(pluralElement.text);
            }
          }
        }
      }
    }

    return ParseResult(data: returnMap, uniqueStrings: stringCount);
  }

  static Future<Map<String, Map<String, StringInfo>>> loadWithStringInfo(
    File file,
    String locale,
  ) async {
    final Map<String, Map<String, StringInfo>> returnMap = {};

    final String fileContent = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileContent);
    document.normalize();

    final XmlElement base = document.lastElementChild!;

    for (final XmlNode item in base.children) {
      if (item is XmlElement) {
        final XmlElement element = item;

        final String? name = element.getAttribute("name");
        if (name == null) continue;
        final List<String> splittedName = name.split(".");
        final String routeName = splittedName.first;
        splittedName.removeAt(0);
        final String normalizedName = splittedName.join(".");
        final String? comment = element.getAttribute("comment");

        returnMap[routeName] ??= {};

        if (element.name.toString() == "string") {
          if (element.text.contains("%s")) {
            returnMap[routeName]![normalizedName] ??= ArgumentString()
              ..comment = comment
              ..argNum = _argumentNum(element.text);
          } else {
            returnMap[routeName]![normalizedName] ??= CommonString()
              ..comment = comment;
          }
        } else if (element.name.toString() == "plurals") {
          returnMap[routeName]![normalizedName] ??= PluralString()
            ..comment = comment;
        }
      }
    }

    return returnMap;
  }

  static String _replacer(String base) {
    return base
        .replaceAll("%s", "{}")
        .replaceAll('\\"', '"')
        .replaceAll("\\'", "'")
        .replaceAll("\\n", "\n");
  }

  static int _argumentNum(String base) {
    String _workBase = base;

    int i;

    for (i = 0; _workBase.contains("%s"); i++) {
      final int indexOf = _workBase.indexOf("%s");
      _workBase = _workBase.substring(indexOf + 2);
    }

    return i;
  }
}

class StringInfo {
  String? comment;
}

class CommonString extends StringInfo {}

class PluralString extends StringInfo {}

class ArgumentString extends StringInfo {
  late int argNum;
}

class ParseResult {
  final Map<String, String> data;
  final int uniqueStrings;

  const ParseResult({
    required this.data,
    required this.uniqueStrings,
  });
}
