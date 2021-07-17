import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_card.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';

class SettingsPageNetwork extends StatefulWidget {
  const SettingsPageNetwork({Key? key}) : super(key: key);

  @override
  _SettingsPageNetworkState createState() => _SettingsPageNetworkState();
}

class _SettingsPageNetworkState extends State<SettingsPageNetwork> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Network & internet",
      cards: [
        SettingsCard.withExpandableSwitch(
          title: "Wifi",
          leading: Icon(Icons.wifi),
          defaultValue: false,
          content: Text("test"),
        ),
      ],
    );
  }
}
