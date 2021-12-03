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

class SettingsPageDeveloperOptions extends StatefulWidget {
  const SettingsPageDeveloperOptions({Key? key}) : super(key: key);

  @override
  _SettingsPageDeveloperOptionsState createState() =>
      _SettingsPageDeveloperOptionsState();
}

class _SettingsPageDeveloperOptionsState
    extends State<SettingsPageDeveloperOptions> {
  bool _devModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "Developer Options",
      cards: [
        SettingsCard.withSwitch(
          title: "Developer Mode",
          subtitle: "Activate advanced debugging features",
          leading: const Icon(Icons.developer_mode),
          value: _devModeEnabled,
          onToggle: (val) {
            setState(() => _devModeEnabled = val);
          },
        ),
        const SettingsContentHeader(""),
        SettingsCard.withSwitch(
          title: "Developer Mode",
          subtitle: "Activate advanced debugging features",
          leading: const Icon(Icons.developer_mode),
          value: _devModeEnabled,
          onToggle: (val) {
            setState(() => _devModeEnabled = val);
          },
        ),
      ],
    );
  }
}
