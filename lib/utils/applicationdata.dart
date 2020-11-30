import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/utils/widgets/app_launcher.dart';
import 'package:flutter/material.dart';

class ApplicationData {
  final String appName, icon;
  final Widget app;
  final bool appExists;
  final Color color;

  const ApplicationData(
      {Key key,
      @required this.appName,
      @required this.icon,
      @required this.app,
      @required this.color,
      @required this.appExists});
}

List<ApplicationData> applicationsData = List<ApplicationData>();
List<AppLauncherButton> applications = List<AppLauncherButton>();
void initializeApps() {
  //Add ApplicationData

  //Settings
  applicationsData.add(ApplicationData(
      appName: "Settings",
      icon: "settings",
      app: Settings(),
      color: Colors.deepOrange[700],
      appExists: true));
}
