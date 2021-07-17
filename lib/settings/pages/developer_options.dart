import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';

class SettingsPageDeveloperOptions extends StatefulWidget {
  const SettingsPageDeveloperOptions({Key? key}) : super(key: key);

  @override
  _SettingsPageDeveloperOptionsState createState() =>
      _SettingsPageDeveloperOptionsState();
}

class _SettingsPageDeveloperOptionsState
    extends State<SettingsPageDeveloperOptions> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Developer Options",
      cards: [],
    );
  }
}
