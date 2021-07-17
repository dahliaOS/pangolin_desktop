import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_card.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';

class SettingsPageSound extends StatelessWidget {
  const SettingsPageSound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Sound",
      cards: [
        SettingsCard.withSwitch(
          defaultValue: true,
          title: "Switch",
        ),
        SettingsCard.withExpandableSwitch(
          content: Text("test"),
          defaultValue: true,
          title: "Expandable Switch",
        ),
        SettingsCard.withExpandable(
          content: Text("test"),
          defaultValue: true,
          title: "Expandable",
        ),
        SettingsCard.withCustomTrailing(
          defaultValue: true,
          title: "Custom Trailing",
          trailing: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Custom Trailing"),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
