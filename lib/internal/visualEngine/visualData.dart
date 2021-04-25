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
  double taskbarHeight;
  bool opaqueTitlebars;
  bool titleInfo;
  double windowRadius;
  double taskbarRounding;
  double taskbarOpacity;
  String activeAppsPosition;
  bool showDate;
  bool searchIcon;
  bool overviewIcon;
  bool notificationsIcon;
  String launcherIndicator;
  bool launcherCategories;
  String searchBarString;
  bool launcherSystemOptions;
  double searchbarRounding;
  double qsTileRounding;
  double qsRounding;
  double overlayOpacity;
  double overlayButtonRounding;
  String userName;

  VisualInformation(
      {required this.taskbarHeight,
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
      required this.userName});

  factory VisualInformation.fromJson(Map<String, dynamic> parsedJson) {
    return VisualInformation(
        taskbarHeight: parsedJson['taskbarHeight'], //complete
        opaqueTitlebars: parsedJson['opaqueTitlebars'],
        titleInfo: parsedJson['titleInfo'],
        windowRadius: parsedJson['windowRadius'],
        activeAppsPosition: parsedJson['activeAppsPosition'],
        userName: parsedJson['userName'],
        launcherCategories: parsedJson['launcherCategories'],
        launcherIndicator: parsedJson['launcherIndicator'],
        launcherSystemOptions: parsedJson['launcherSystemOptions'],
        notificationsIcon: parsedJson['notificationsIcon'],
        overlayButtonRounding: parsedJson['overlayButtonRounding'],
        overlayOpacity: parsedJson['overlayOpacity'],
        overviewIcon: parsedJson['overviewIcon'],
        qsRounding: parsedJson['qsRounding'],
        qsTileRounding: parsedJson['qsTileRounding'],
        searchbarRounding: parsedJson['searchbarRounding'],
        searchBarString: parsedJson['searchBarString'],
        searchIcon: parsedJson['searchIcon'],
        showDate: parsedJson['showDate'],
        taskbarOpacity: parsedJson['taskbarOpacity'],
        taskbarRounding: parsedJson['taskbarRounding']); //complete
  }
}
