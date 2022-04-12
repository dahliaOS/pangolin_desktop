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
import 'package:pangolin/components/settings/widgets/list_tiles.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/services/network_manager.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

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
      title: LSX.settings.pagesNetworkTitle,
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
              SettingsContentHeader(LSX.settings.pagesNetworkWifi),
              SettingsCard(
                children: [
                  ExpandableSwitchListTile(
                    title: Text(LSX.settings.pagesNetworkWifiSwitchTileTitle),
                    subtitle: Text(
                      _wifiEnabled
                          ? LSX.settings
                              .pagesNetworkWifiSwitchTileSubtitleEnabled
                          : LSX.settings
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
                    title:
                        Text(LSX.settings.pagesNetworkWifiPreferencesTileTitle),
                    subtitle: Text(
                      LSX.settings.pagesNetworkWifiPreferencesTileSubtitle,
                    ),
                    leading: const Icon(
                      Icons.online_prediction_rounded,
                    ),
                  ),
                  ExpandableListTile(
                    value: false,
                    title: Text(
                      LSX.settings.pagesNetworkWifiSavedNetworksTileTitle,
                    ),
                    subtitle: Text(
                      LSX.settings
                          .pagesNetworkWifiSavedNetworksTileSubtitle("8"),
                    ),
                    leading: const Icon(Icons.save_rounded),
                  ),
                  RouterListTile(
                    title:
                        Text(LSX.settings.pagesNetworkWifiDataUsageTileTitle),
                    subtitle: Text(
                      LSX.settings.pagesNetworkWifiDataUsageTileSubtitle,
                    ),
                    leading: const Icon(Icons.data_saver_on_rounded),
                  )
                ],
              ),
              SettingsContentHeader(LSX.settings.pagesNetworkEthernet),
              SettingsCard(
                children: [
                  SwitchListTile(
                    title:
                        Text(LSX.settings.pagesNetworkEthernetSwitchTileTitle),
                    subtitle: Text(
                      _ethernetEnabled
                          ? LSX.settings
                              .pagesNetworkEthernetSwitchTileSubtitleEnabled
                          : LSX.settings
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
                      LSX.settings.pagesNetworkEthernetDataUsageTileTitle,
                    ),
                    subtitle: Text(
                      LSX.settings.pagesNetworkEthernetDataUsageTileSubtitle,
                    ),
                    leading: const Icon(Icons.data_saver_on_rounded),
                  ),
                ],
              ),
              SettingsContentHeader(LSX.settings.pagesNetworkNetworkOptions),
              SettingsCard(
                children: [
                  ListTile(
                    title: Text(
                      LSX.settings.pagesNetworkNetworkOptionsVpnTileTitle,
                    ),
                    subtitle: Text(
                      LSX.settings.pagesNetworkNetworkOptionsVpnTileSubtitle,
                    ),
                    leading: const Icon(Icons.vpn_lock_rounded),
                    trailing: ElevatedButton(
                      child: Padding(
                        padding: ThemeConstants.buttonPadding,
                        child: Text(
                          LSX.settings.pagesNetworkNetworkOptionsVpnTileButton,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      LSX.settings.pagesNetworkNetworkOptionsDnsTileTitle,
                    ),
                    subtitle: Text(
                      LSX.settings.pagesNetworkNetworkOptionsDnsTileSubtitle,
                    ),
                    leading: const Icon(Icons.dns_rounded),
                    trailing: ElevatedButton(
                      child: Padding(
                        padding: ThemeConstants.buttonPadding,
                        child: Text(
                          LSX.settings.pagesNetworkNetworkOptionsDnsTileButton,
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
