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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/settings/widgets/list_tiles.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/services/network_manager.dart';

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
      cards: kIsWeb
          ? [
              const SettingsCard(
                children: [
                  ListTile(
                    title: Text("Not supported on this platform"),
                  ),
                ],
              ),
            ]
          : [
              const SettingsContentHeader("Wi-Fi"),
              SettingsCard(
                children: [
                  ExpandableSwitchListTile(
                    title: const Text("Wi-Fi"),
                    subtitle: Text(
                      "Wi-Fi is ${_wifiEnabled ? "enabled" : "disabled"}",
                    ),
                    value: _wifiEnabled,
                    leading: const Icon(Icons.wifi),
                    onChanged: (val) {
                      setState(() {
                        _wifiEnabled = val;
                      });
                    },
                    content: SizedBox(
                      height: 200,
                      child: ListView(
                        children: (Platform.isLinux)
                            ? parseNetworks(context)
                            : const [
                                Center(
                                  child: Text("Not supported on this platform"),
                                ),
                              ],
                      ),
                    ),
                  ),
                  const ExpandableListTile(
                    value: false,
                    title: Text("Wi-Fi prefernces"),
                    subtitle: Text("Smart Wi-Fi connection, scanning options"),
                    leading: Icon(
                      Icons.online_prediction_rounded,
                    ),
                  ),
                  const ExpandableListTile(
                    value: false,
                    title: Text("Saved networks"),
                    subtitle: Text("8 networks"),
                    leading: Icon(Icons.save_rounded),
                  ),
                  const RouterListTile(
                    title: Text("Wi-Fi data usage"),
                    subtitle: Text("Data usage for this month"),
                    leading: Icon(Icons.data_saver_on_rounded),
                  )
                ],
              ),
              const SettingsContentHeader("Ethernet"),
              SettingsCard(
                children: [
                  SwitchListTile(
                    title: const Text("Ethernet"),
                    subtitle: Text(
                      "Ethernet is ${_ethernetEnabled ? "enabled" : "disabled"}",
                    ),
                    secondary: const Icon(Icons.settings_ethernet_rounded),
                    value: _ethernetEnabled,
                    onChanged: (val) {
                      setState(() => _ethernetEnabled = val);
                    },
                  ),
                  const RouterListTile(
                    title: Text("Ethernet data usage"),
                    subtitle: Text("Data usage for this month"),
                    leading: Icon(Icons.data_saver_on_rounded),
                  ),
                ],
              ),
              const SettingsContentHeader("Network options"),
              SettingsCard(
                children: [
                  ListTile(
                    title: const Text("Virtual Private Network (VPN)"),
                    subtitle: const Text("None"),
                    leading: const Icon(Icons.vpn_lock_rounded),
                    trailing: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("VPN options"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: const Text("Private DNS"),
                    subtitle: const Text("Automatic"),
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
              ),
            ],
    );
  }
}
