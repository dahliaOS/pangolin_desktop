import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';

class SettingsPageLocale extends StatefulWidget {
  SettingsPageLocale({Key? key}) : super(key: key);

  @override
  _SettingsPageLocaleState createState() => _SettingsPageLocaleState();
}

class _SettingsPageLocaleState extends State<SettingsPageLocale> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Locale",
      cards: [],
    );
  }
}
