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

import 'package:flutter/material.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';

class SettingsPageNetwork extends StatefulWidget {
  const SettingsPageNetwork({Key? key}) : super(key: key);

  @override
  _SettingsPageNetworkState createState() => _SettingsPageNetworkState();
}

class _SettingsPageNetworkState extends State<SettingsPageNetwork> {
  bool _wifiEnabled = false;
  bool _ethernetEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Network & internet",
      cards: [
        const SettingsContentHeader("Wi-Fi"),
        SettingsCard.withExpandableSwitch(
          title: "Wi-Fi",
          subtitle: "Wi-Fi is ${_wifiEnabled ? "enabled" : "disabled"}",
          leading: const Icon(
            Icons.wifi_rounded,
          ),
          value: _wifiEnabled,
          onToggle: (val) {
            setState(() {
              _wifiEnabled = val;
            });
          },
        ),
        SettingsCard.withExpandable(
          value: false,
          title: "Wi-Fi prefernces",
          subtitle: "Smart Wi-Fi connection, scanning options",
          leading: const Icon(Icons.online_prediction_rounded),
        ),
        SettingsCard.withExpandable(
          value: false,
          title: "Saved networks",
          subtitle: "8 networks",
          leading: const Icon(Icons.save_rounded),
        ),
        SettingsCard.withRouter(
          title: "Wi-Fi data usage",
          subtitle: "Data usage for this month",
          leading: const Icon(Icons.data_saver_on_rounded),
        ),
        const SettingsContentHeader("Ethernet"),
        SettingsCard.withSwitch(
          title: "Ethernet",
          subtitle: "Ethernet is ${_ethernetEnabled ? "enabled" : "disabled"}",
          leading: const Icon(Icons.settings_ethernet_rounded),
          value: _ethernetEnabled,
          onToggle: (val) {
            setState(() => _ethernetEnabled = val);
          },
        ),
        SettingsCard.withRouter(
          title: "Ethernet data usage",
          subtitle: "Data usage for this month",
          leading: const Icon(Icons.data_saver_on_rounded),
        ),
        const SettingsContentHeader("Network options"),
        SettingsCard.withCustomTrailing(
          title: "Virtual Private Network (VPN)",
          subtitle: "None",
          leading: const Icon(Icons.vpn_lock_rounded),
          trailing: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("VPN options"),
            ),
            onPressed: () {},
          ),
        ),
        SettingsCard.withCustomTrailing(
          title: "Private DNS",
          subtitle: "Automatic",
          leading: const Icon(Icons.dns_rounded),
          trailing: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("DNS options"),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
