import 'dart:io';

import 'package:xml/xml.dart';

import 'locale_generator.dart';

class XmlFileParser {
  const XmlFileParser._();

  static Future<Map<String, String>> load(Directory dir, String locale) async {
    Map<String, String> returnMap = {};

    List<FileSystemEntity> files = dir.listSync();

    for (FileSystemEntity file in files) {
      if (!(file is File)) continue;

      final routeFile =
          getNameFromPath(file.absolute.path).replaceAll(".xml", "");
      final fileContent = await (file as File).readAsString();
      var document = XmlDocument.parse(fileContent);
      document.normalize();

      XmlElement base = document.lastElementChild;

      for (XmlNode item in base.children) {
        if (item is XmlElement) {
          XmlElement element = item;

          String name = element.getAttribute("name");
          if (name == null) continue;

          if (element.name.toString() == "string") {
            returnMap["$routeFile.$name"] = _replacer(element.text);
          } else if (element.name.toString() == "plurals") {
            for (XmlNode plural in element.children) {
              if (plural is XmlElement) {
                XmlElement pluralElement = plural;

                String pluralAttribute = pluralElement.getAttribute("quantity");
                if (pluralAttribute == null) continue;

                returnMap["$routeFile.$name.$pluralAttribute"] =
                    _replacer(pluralElement.text);
              }
            }
          }
        }
      }
    }

    return returnMap;
  }

  static Future<Map<String, Map<String, StringInfo>>> loadWithStringInfo(
      Directory dir, String locale) async {
    Map<String, Map<String, StringInfo>> returnMap = {};

    List<FileSystemEntity> files = dir.listSync();

    for (FileSystemEntity file in files) {
      if (!(file is File)) continue;

      final routeFile =
          getNameFromPath(file.absolute.path).replaceAll(".xml", "");
      returnMap[routeFile] = {};
      final fileContent = await (file as File).readAsString();
      var document = XmlDocument.parse(fileContent);
      document.normalize();

      XmlElement base = document.lastElementChild;

      for (XmlNode item in base.children) {
        if (item is XmlElement) {
          XmlElement element = item;

          String name = element.getAttribute("name");
          if (name == null) continue;

          if (element.name.toString() == "string") {
            if (element.text.contains("%s")) {
              returnMap[routeFile][name] ??= ArgumentString()
                ..argNum = _argumentNum(element.text);
            } else {
              returnMap[routeFile][name] ??= CommonString();
            }
          } else if (element.name.toString() == "plurals") {
            returnMap[routeFile][name] ??= PluralString();
          }
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
      final indexOf = _workBase.indexOf("%s");
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
