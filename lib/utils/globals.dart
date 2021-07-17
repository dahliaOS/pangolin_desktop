/*
Copyright 2021 The dahliaOS Authors

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
import 'dart:convert';
import 'dart:io';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:http/http.dart';
import 'package:pangolin/utils/accent_color_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

String totalVersionNumber = "210419";
String headingFeatureString =
    "dahliaOS Linux-Based " + totalVersionNumber + " ...";
String longName = "dahliaOS Linux-Based " + totalVersionNumber + " PRE-RELEASE";
String kernel() {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      ProcessResult result = Process.runSync('uname', ['-sr']);
      var kernelString = result.stdout;
      return kernelString.toString().replaceAll('\n', '');
    } else
      return "Windows";
  } else
    return "Web Build";
}

String pangolinCommit = "Pangolin - reborn";
String fullPangolinVersion = "$pangolinCommit";

double horizontalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.width / 2 - size / 2;

double verticalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.height / 2 - size / 3.5;

List<String> languages = [
  "عربى - إيران",
  "Bosanski - Bosna i Hercegovina",
  "Hrvatski - Hrvatska",
  "Nederlands - België",
  "Nederlands - Nederland",
  "English - United States",
  "Français - France",
  "Deutsch - Deutschland",
  "bahasa Indonesia - Indonesia",
  "Polski - Polska",
  "Português - Brasil",
  "русский - Россия",
  "Svenska - Sverige",
  "Український - Україна",
];

List<String> timeZones = [];

List<String> wallpapers = [
  "assets/images/wallpapers/dahliaOS_white_logo_pattern_wallpaper.png",
  "assets/images/wallpapers/dahliaOS_white_wallpaper.png",
  "assets/images/wallpapers/Gradient_logo_wallpaper.png",
  "assets/images/wallpapers/Three_Bubbles.png",
  "assets/images/wallpapers/Bubbles_wallpaper.png",
  "assets/images/wallpapers/Mountains_wallpaper.png",
  "assets/images/wallpapers/mountain.jpg",
];

List<AccentColorData> accentColors = [
  AccentColorData(color: Colors.deepOrange, title: "Orange"),
  AccentColorData(color: Colors.red.shade700, title: "Red"),
  AccentColorData(color: Colors.greenAccent.shade700, title: "Green"),
  AccentColorData(color: Colors.blue, title: "Blue"),
  AccentColorData(color: Colors.purple, title: "Purple"),
  AccentColorData(color: Colors.cyan, title: "Cyan"),
  AccentColorData(color: Colors.amber, title: "Amber"),
  AccentColorData(color: null, title: "Custom Accent Color"),
];

String link = "";
String copyright = "";
void getBingWallpaper() async {
  Response response = await get(Uri.parse(
      'https://bing.biturl.top/?resolution=1920&format=json&index=0&mkt=en-US'));
  Map data = jsonDecode(response.body);
  link = data['url'];
  copyright = data['copyright'];
}
