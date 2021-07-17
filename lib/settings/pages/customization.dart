import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';

class SettingsPageCustomization extends StatefulWidget {
  const SettingsPageCustomization({Key? key}) : super(key: key);

  @override
  _SettingsPageCustomizationState createState() =>
      _SettingsPageCustomizationState();
}

class _SettingsPageCustomizationState extends State<SettingsPageCustomization> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Customization",
      cards: [],
    );
  }
}
