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
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';

class SettingsPageNetwork extends StatefulWidget {
  const SettingsPageNetwork({super.key});

  @override
  _SettingsPageNetworkState createState() => _SettingsPageNetworkState();
}

class _SettingsPageNetworkState extends State<SettingsPageNetwork> {
  bool _wifiEnabled = false;
  bool _ethernetEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: strings.settings.pagesNetworkTitle,
      cards: kIsWeb
          ? [
              const SettingsCard(
                children: [
                  ListTile(
                    //TODO add localization String
                    title: Text("Not supported on this platform"),
                  ),
                ],
              ),
            ]
          : [
              SettingsContentHeader(strings.settings.pagesNetworkWifi),
              SettingsCard(
                children: [
                  ExpandableSwitchListTile(
                    title:
                        Text(strings.settings.pagesNetworkWifiSwitchTileTitle),
                    subtitle: Text(
                      _wifiEnabled
                          ? strings.settings
                              .pagesNetworkWifiSwitchTileSubtitleEnabled
                          : strings.settings
                              .pagesNetworkWifiSwitchTileSubtitleDisabled,
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
                                  //TODO same as above
                                  child: Text("Not supported on this platform"),
                                ),
                              ],
                      ),
                    ),
                  ),
                  ExpandableListTile(
                    value: false,
                    title: Text(
                      strings.settings.pagesNetworkWifiPreferencesTileTitle,
                    ),
                    subtitle: Text(
                      strings.settings.pagesNetworkWifiPreferencesTileSubtitle,
                    ),
                    leading: const Icon(
                      Icons.online_prediction_rounded,
                    ),
                  ),
                  ExpandableListTile(
                    value: false,
                    title: Text(
                      strings.settings.pagesNetworkWifiSavedNetworksTileTitle,
                    ),
                    subtitle: Text(
                      strings.settings
                          .pagesNetworkWifiSavedNetworksTileSubtitle("8"),
                    ),
                    leading: const Icon(Icons.save_rounded),
                  ),
                  RouterListTile(
                    title: Text(
                      strings.settings.pagesNetworkWifiDataUsageTileTitle,
                    ),
                    subtitle: Text(
                      strings.settings.pagesNetworkWifiDataUsageTileSubtitle,
                    ),
                    leading: const Icon(Icons.data_saver_on_rounded),
                  )
                ],
              ),
              SettingsContentHeader(strings.settings.pagesNetworkEthernet),
              SettingsCard(
                children: [
                  SwitchListTile(
                    title: Text(
                      strings.settings.pagesNetworkEthernetSwitchTileTitle,
                    ),
                    subtitle: Text(
                      _ethernetEnabled
                          ? strings.settings
                              .pagesNetworkEthernetSwitchTileSubtitleEnabled
                          : strings.settings
                              .pagesNetworkEthernetSwitchTileSubtitleDisabled,
                    ),
                    secondary: const Icon(Icons.settings_ethernet_rounded),
                    value: _ethernetEnabled,
                    onChanged: (val) {
                      setState(() => _ethernetEnabled = val);
                    },
                  ),
                  RouterListTile(
                    title: Text(
                      strings.settings.pagesNetworkEthernetDataUsageTileTitle,
                    ),
                    subtitle: Text(
                      strings
                          .settings.pagesNetworkEthernetDataUsageTileSubtitle,
                    ),
                    leading: const Icon(Icons.data_saver_on_rounded),
                  ),
                ],
              ),
              SettingsContentHeader(
                strings.settings.pagesNetworkNetworkOptions,
              ),
              SettingsCard(
                children: [
                  ListTile(
                    title: Text(
                      strings.settings.pagesNetworkNetworkOptionsVpnTileTitle,
                    ),
                    subtitle: Text(
                      strings
                          .settings.pagesNetworkNetworkOptionsVpnTileSubtitle,
                    ),
                    leading: const Icon(Icons.vpn_lock_rounded),
                    trailing: ElevatedButton(
                      child: Padding(
                        padding: ThemeConstants.buttonPadding,
                        child: Text(
                          strings
                              .settings.pagesNetworkNetworkOptionsVpnTileButton,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      strings.settings.pagesNetworkNetworkOptionsDnsTileTitle,
                    ),
                    subtitle: Text(
                      strings
                          .settings.pagesNetworkNetworkOptionsDnsTileSubtitle,
                    ),
                    leading: const Icon(Icons.dns_rounded),
                    trailing: ElevatedButton(
                      child: Padding(
                        padding: ThemeConstants.buttonPadding,
                        child: Text(
                          strings
                              .settings.pagesNetworkNetworkOptionsDnsTileButton,
                        ),
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
