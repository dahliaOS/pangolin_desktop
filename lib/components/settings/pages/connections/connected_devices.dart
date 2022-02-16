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

import 'package:pangolin/components/settings/widgets/list_tiles.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class SettingsPageConnectedDevices extends StatelessWidget {
  const SettingsPageConnectedDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: LSX.settings.pagesConnectionsTitle,
      cards: [
        SettingsContentHeader(LSX.settings.pagesConnectionsBluetooth),
        SettingsCard(
          children: [
            ExpandableSwitchListTile(
              value: false,
              onChanged: (val) {},
              title:
                  Text(LSX.settings.pagesConnectionsBluetoothSwitchTileTitle),
              subtitle: Text(
                LSX.settings
                    .pagesConnectionsBluetoothSwitchTileSubtitleDisabled,
              ),
              leading: const Icon(Icons.bluetooth_rounded),
            ),
            RouterListTile(
              title: Text(
                LSX.settings.pagesConnectionsBluetoothFileTransferTileTitle,
              ),
              leading: const Icon(Icons.file_copy_rounded),
            ),
          ],
        ),
        SettingsContentHeader(LSX.settings.pagesConnectionsPhoneIntegration),
        SettingsCard(
          children: [
            ExpandableListTile(
              value: false,
              title:
                  Text(LSX.settings.pagesConnectionsPhoneIntegrationTileTitle),
              subtitle: Text(
                LSX.settings.pagesConnectionsPhoneIntegrationTileSubtitle,
              ),
              leading: const Icon(Icons.phone_android_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
