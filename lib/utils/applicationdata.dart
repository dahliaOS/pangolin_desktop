import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/utils/widgets/app_launcher.dart';
import 'package:flutter/material.dart';

class ApplicationData {
  final String appName, icon;
  final Widget app;

  const ApplicationData(
      {Key key,
      @required this.appName,
      @required this.icon,
      @required this.app});
}

List<ApplicationData> applicationsData = List<ApplicationData>();
List<AppLauncherButton> applications = List<AppLauncherButton>();
void initializeApps() {
  //Add ApplicationData
  applicationsData.add(
      ApplicationData(appName: "Settings", icon: "settings", app: Settings()));
}
