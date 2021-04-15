import 'dart:async' show Future;
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:pangolin/internal/visualEngine/visualData.dart';

Future<String> _loadDataAsset() async {
  return await rootBundle.loadString('assets/json/visualData.json');
}

Future loadVisualEngine() async {
  String jsonString = await _loadDataAsset();
  final jsonResponse = json.decode(jsonString);
  VisualInformation visuals = new VisualInformation.fromJson(jsonResponse);
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
