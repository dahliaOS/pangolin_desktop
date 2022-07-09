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
import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/services/visual_engine/visual_data.dart';

Future<String> _loadDataAsset() {
  return rootBundle.loadString('assets/json/visualData.json');
}

Future loadVisualEngine() async {
  final String jsonString = await _loadDataAsset();
  final Map<String, dynamic> jsonResponse =
      json.decode(jsonString) as Map<String, dynamic>;
  final VisualInformation visuals = VisualInformation.fromJson(jsonResponse);
  if (kDebugMode) {
    print(visuals.taskbarHeight);
    print(visuals.opaqueTitlebars);
    print(visuals.titleInfo);
    print(visuals.windowRadius);
    print(visuals.activeAppsPosition);
    print(visuals.userName);
    print(visuals.launcherCategories);
    print(visuals.launcherIndicator);
    print(visuals.launcherSystemOptions);
    print(visuals.notificationsIcon);
    print(visuals.overlayButtonRounding);
    print(visuals.overlayOpacity);
    print(visuals.overviewIcon);
    print(visuals.qsTileRounding);
    print(visuals.searchBarString);
    print(visuals.searchIcon);
    print(visuals.showDate);
    print(visuals.taskbarOpacity);
    print(visuals.taskbarRounding);
  }
  PreferencesService.current.set('taskbarHeight', visuals.taskbarHeight);
  PreferencesService.current.set('opaqueTitlebars', visuals.opaqueTitlebars);
  PreferencesService.current.set('titleInfo', visuals.titleInfo);
  PreferencesService.current.set('titleInfo', visuals.windowRadius);
  PreferencesService.current
      .set('activeAppsPosition', visuals.activeAppsPosition);
  PreferencesService.current.set('userName', visuals.userName);
  PreferencesService.current
      .set('launcherCategories', visuals.launcherCategories);
  PreferencesService.current
      .set('launcherIndicator', visuals.launcherIndicator);
  PreferencesService.current
      .set('launcherSystemOptions', visuals.launcherSystemOptions);
  PreferencesService.current
      .set('notificationsIcon', visuals.notificationsIcon);
  PreferencesService.current
      .set('overlayButtonRounding', visuals.overlayButtonRounding);
  PreferencesService.current.set('overlayOpacity', visuals.overlayOpacity);
  PreferencesService.current.set('overviewIcon', visuals.overviewIcon);
  PreferencesService.current.set('qsTileRounding', visuals.qsTileRounding);
  PreferencesService.current.set('searchBarString', visuals.searchBarString);
  PreferencesService.current.set('searchIcon', visuals.searchIcon);
  PreferencesService.current.set('showDate', visuals.showDate);
  PreferencesService.current.set('qsRounding', visuals.qsRounding);
  PreferencesService.current.set('taskbarOpacity', visuals.taskbarOpacity);
  PreferencesService.current.set('taskbarRounding', visuals.taskbarRounding);
}
