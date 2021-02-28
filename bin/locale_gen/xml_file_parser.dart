import 'dart:io';

import 'package:xml/xml.dart';

class XmlFileParser {
  const XmlFileParser._();

  static Future<Map<String, String>> load(File file, String locale) async {
    final Map<String, String> returnMap = {};

    final String fileContent = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileContent);
    document.normalize();

    XmlElement base = document.lastElementChild;

    for (XmlNode item in base.children) {
      if (item is XmlElement) {
        XmlElement element = item;

        String name = element.getAttribute("name");
        if (name == null) continue;

        if (element.name.toString() == "string") {
          returnMap["$name"] = _replacer(element.text);
        } else if (element.name.toString() == "plurals") {
          for (XmlNode plural in element.children) {
            if (plural is XmlElement) {
              XmlElement pluralElement = plural;

              String pluralAttribute = pluralElement.getAttribute("quantity");
              if (pluralAttribute == null) continue;

              returnMap["$name.$pluralAttribute"] =
                  _replacer(pluralElement.text);
            }
          }
        }
      }
    }

    return returnMap;
  }

  static Future<Map<String, Map<String, StringInfo>>> loadWithStringInfo(
      File file, String locale) async {
    final Map<String, Map<String, StringInfo>> returnMap = {};

    final String fileContent = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileContent);
    document.normalize();

    final XmlElement base = document.lastElementChild;

    for (XmlNode item in base.children) {
      if (item is XmlElement) {
        final XmlElement element = item;

        final String name = element.getAttribute("name");
        if (name == null) continue;
        final List<String> splittedName = name.split(".");
        final String routeName = splittedName.first;
        splittedName.removeAt(0);
        final String normalizedName = splittedName.join(".");

        returnMap[routeName] ??= {};

        if (element.name.toString() == "string") {
          if (element.text.contains("%s")) {
            returnMap[routeName][normalizedName] ??= ArgumentString()
              ..argNum = _argumentNum(element.text);
          } else {
            returnMap[routeName][normalizedName] ??= CommonString();
          }
        } else if (element.name.toString() == "plurals") {
          returnMap[routeName][normalizedName] ??= PluralString();
        }
      }
    }

    return returnMap;
  }

  static String _replacer(String base) {
    return base
        .replaceAll("%s", "{}")
        .replaceAll("\\\"", "\"")
        .replaceAll("\\\'", "\'")
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

class StringInfo {}

class CommonString extends StringInfo {}

class PluralString extends StringInfo {}

class ArgumentString extends StringInfo {
  int argNum;
}
