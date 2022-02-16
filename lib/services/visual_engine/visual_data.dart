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
class VisualInformation {
  final double taskbarHeight;
  final bool opaqueTitlebars;
  final bool titleInfo;
  final double windowRadius;
  final double taskbarRounding;
  final double taskbarOpacity;
  final String activeAppsPosition;
  final bool showDate;
  final bool searchIcon;
  final bool overviewIcon;
  final bool notificationsIcon;
  final String launcherIndicator;
  final bool launcherCategories;
  final String searchBarString;
  final bool launcherSystemOptions;
  final double searchbarRounding;
  final double qsTileRounding;
  final double qsRounding;
  final double overlayOpacity;
  final double overlayButtonRounding;
  final String userName;

  const VisualInformation({
    required this.taskbarHeight,
    required this.opaqueTitlebars,
    required this.titleInfo,
    required this.windowRadius,
    required this.taskbarRounding,
    required this.taskbarOpacity,
    required this.activeAppsPosition,
    required this.showDate,
    required this.searchIcon,
    required this.overviewIcon,
    required this.notificationsIcon,
    required this.launcherIndicator,
    required this.launcherCategories,
    required this.searchBarString,
    required this.launcherSystemOptions,
    required this.searchbarRounding,
    required this.qsTileRounding,
    required this.overlayOpacity,
    required this.qsRounding,
    required this.overlayButtonRounding,
    required this.userName,
  });

  factory VisualInformation.fromJson(Map<String, dynamic> parsedJson) {
    return VisualInformation(
      taskbarHeight: parsedJson['taskbarHeight']! as double, //complete
      opaqueTitlebars: parsedJson['opaqueTitlebars']! as bool,
      titleInfo: parsedJson['titleInfo']! as bool,
      windowRadius: parsedJson['windowRadius']! as double,
      activeAppsPosition: parsedJson['activeAppsPosition']! as String,
      userName: parsedJson['userName']! as String,
      launcherCategories: parsedJson['launcherCategories']! as bool,
      launcherIndicator: parsedJson['launcherIndicator']! as String,
      launcherSystemOptions: parsedJson['launcherSystemOptions']! as bool,
      notificationsIcon: parsedJson['notificationsIcon']! as bool,
      overlayButtonRounding: parsedJson['overlayButtonRounding']! as double,
      overlayOpacity: parsedJson['overlayOpacity']! as double,
      overviewIcon: parsedJson['overviewIcon']! as bool,
      qsRounding: parsedJson['qsRounding']! as double,
      qsTileRounding: parsedJson['qsTileRounding']! as double,
      searchbarRounding: parsedJson['searchbarRounding']! as double,
      searchBarString: parsedJson['searchBarString']! as String,
      searchIcon: parsedJson['searchIcon']! as bool,
      showDate: parsedJson['showDate']! as bool,
      taskbarOpacity: parsedJson['taskbarOpacity']! as double,
      taskbarRounding: parsedJson['taskbarRounding']! as double,
    ); //complete
  }
}
