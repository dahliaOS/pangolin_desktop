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
import 'package:utopia_wm/wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String totalVersionNumber = "21.02.7";
String headingFeatureString =
    "dahliaOS Linux-Based " + totalVersionNumber + " ...";
String longName = "dahliaOS Linux-Based " + totalVersionNumber + " PRE-RELEASE";
String kernel = "5.10.1";
String pangolinCommit = "Pangolin - reborn";
String fullPangolinVersion = "$pangolinCommit";

double sidePadding(BuildContext context, double size) =>
    context.watch<WindowHierarchyState>().wmRect.width / 2 - size / 2;

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
  "assets/images/wallpapers/dahliaOS/dahliaOS_white_logo_pattern_wallpaper.png",
  "assets/images/wallpapers/dahliaOS/dahliaOS_white_wallpaper.png",
  "assets/images/wallpapers/dahliaOS/Gradient_logo_wallpaper.png",
  "assets/images/wallpapers/dahliaOS/Three_bubbles_wallpaper.png",
  "assets/images/wallpapers/dahliaOS/Bubbles_wallpaper.png",
  "assets/images/wallpapers/dahliaOS/Mountains_wallpaper.png",
  "assets/images/wallpapers/Nature/mountain.jpg",
];
