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

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pangolin/utils/api_models/bing_wallpaper_api_model.dart';
import 'package:pangolin/utils/api_models/wallpaper_api_model.dart';
import 'package:pangolin/utils/wm/wm.dart';

String totalVersionNumber = "220222";
String headingFeatureString = "dahliaOS Linux $totalVersionNumber ...";
String longName = "dahliaOS Linux $totalVersionNumber ALPHA";
String get kernel {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      final ProcessResult result = Process.runSync('uname', ['-sr']);
      final String kernelString = result.stdout.toString();
      return kernelString.replaceAll('\n', '');
    } else {
      return "Windows";
    }
  } else {
    return "Web Build";
  }
}

String get architecture {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      final ProcessResult result = Process.runSync('uname', ['-m']);
      final String architechtureString = result.stdout.toString();
      return architechtureString.replaceAll('\n', '');
    } else {
      return "x86_64 / ARM64 based Windows operating system";
    }
  } else {
    return "x86_64";
  }
}

String get username {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      final ProcessResult result = Process.runSync('whoami', []);
      final String architechtureString = result.stdout.toString();
      return architechtureString.replaceAll('\n', '');
    } else {
      return "Windows user";
    }
  } else {
    return "dahliaOS Live user";
  }
}

String pangolinCommit = "220222-dahliaOS_linux";
String fullPangolinVersion = pangolinCommit;

double horizontalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.width / 2 - size / 2;

double verticalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.height / 2 - size / 3.5;

List<String> timeZones = [];

Future<List<Wallpaper>?> getWallpapers() async {
  final response = await get(
    Uri.parse(
      'https://api.github.com/repos/dahliaOS/wallpapers/contents/Official/Desktop/PNG?ref=main',
    ),
    headers: {
      "Access-Control-Allow-Origin": "true",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    },
  );

  if (response.statusCode == 200) {
    return wallpaperParser
        .validate(jsonDecode(response.body))
        ?.cast<Wallpaper>();
  } else {
    throw Exception(
      "Failed to fetch data from dahliaOS' GitHub Wallpaper repository API.",
    );
  }
}

Future<BingImageOfTheDay?> getBingWallpaper() async {
  final response = await get(
    Uri.parse(
      'http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US',
    ),
    headers: {
      "Access-Control-Allow-Origin": "true",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    },
  );

  if (response.statusCode == 200) {
    return bingParser.validate(jsonDecode(response.body));
  } else {
    throw Exception(
      "Failed to fetch data from the Bing's Wallpaper of the Day API.",
    );
  }
}
