/*
Copyright 2020 The dahliaOS Authors
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
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:core';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Configuration {
  String theme;

  Configuration({
    this.theme,
  });

  factory Configuration.fromJson(Map<String, dynamic> parsedJson) {
    return Configuration(
      theme: parsedJson['theme'],
    );
  }
}

Future<String> _loadConfigAsset() async {
  return await File(path.join(Platform.environment['HOME'], 'system.json'))
      .readAsStringSync();
}

Future<String> loadConfig() async {
  String jsonString = await _loadConfigAsset();
  final jsonResponse = json.decode(jsonString);
  Configuration config = new Configuration.fromJson(jsonResponse);
  print(config.theme);
  String value = config.theme;
  return value;
}

Future<ThemeMode> getSystemTheme() async {
  final theme = await loadConfig();
  print(loadConfig());
  if (theme == "dark") {
    print("DARK");
    return ThemeMode.dark;
  } else {
    print("LIGHT");
    return ThemeMode.light;
  }
}
