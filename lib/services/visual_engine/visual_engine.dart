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
import 'package:pangolin/services/visual_engine/visual_data.dart';
import 'package:pangolin/utils/data/database_manager.dart';

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
  DatabaseManager.set('taskbarHeight', visuals.taskbarHeight);
  DatabaseManager.set('opaqueTitlebars', visuals.opaqueTitlebars);
  DatabaseManager.set('titleInfo', visuals.titleInfo);
  DatabaseManager.set('titleInfo', visuals.windowRadius);
  DatabaseManager.set('activeAppsPosition', visuals.activeAppsPosition);
  DatabaseManager.set('userName', visuals.userName);
  DatabaseManager.set('launcherCategories', visuals.launcherCategories);
  DatabaseManager.set('launcherIndicator', visuals.launcherIndicator);
  DatabaseManager.set('launcherSystemOptions', visuals.launcherSystemOptions);
  DatabaseManager.set('notificationsIcon', visuals.notificationsIcon);
  DatabaseManager.set('overlayButtonRounding', visuals.overlayButtonRounding);
  DatabaseManager.set('overlayOpacity', visuals.overlayOpacity);
  DatabaseManager.set('overviewIcon', visuals.overviewIcon);
  DatabaseManager.set('qsTileRounding', visuals.qsTileRounding);
  DatabaseManager.set('searchBarString', visuals.searchBarString);
  DatabaseManager.set('searchIcon', visuals.searchIcon);
  DatabaseManager.set('showDate', visuals.showDate);
  DatabaseManager.set('qsRounding', visuals.qsRounding);
  DatabaseManager.set('taskbarOpacity', visuals.taskbarOpacity);
  DatabaseManager.set('taskbarRounding', visuals.taskbarRounding);
}
