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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class DeveloperOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    final _features = Provider.of<FeatureFlags>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingsTitle(LocaleStrings.settings.headerDevoptions),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsHeader(heading: "Feature Flags"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.desktop_windows),
                          value: _data.enableBlur,
                          title: Text("Enable blur effects on the desktop"),
                          onChanged: (bool state) {
                            _data.enableBlur = !_data.enableBlur;
                          },
                        ),
                        SwitchListTile(
                          secondary: Icon(Icons.phone_android),
                          value: _data.enableBlur,
                          title: Text("Pangolin Mobile as default shell"),
                          onChanged: (bool state) {
                            _data.enableBlur = !_data.enableBlur;
                          },
                        ),
                        SwitchListTile(
                          secondary: Icon(Icons.memory),
                          value: _data.enableBlur,
                          title: Text("Use LTS kernel"),
                          onChanged: (bool state) {
                            _data.enableBlur = !_data.enableBlur;
                          },
                        ),
                        SwitchListTile(
                            secondary: Icon(Icons.blur_linear),
                            title: Text(
                                "Use Acrylic Background Blur for the shell [WIP]"),
                            value: _features.useAcrylic,
                            onChanged: (val) => _features.useAcrylic = val),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Color(0x00ffffff),
        child: SizedBox(
          height: 50,
          width: 15,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Card(
              elevation: 0,
              color: Colors.red[500],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Center(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.warning,
                              size: 25,
                              color: Colors.white,
                            ))),
                    Center(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "WARNING: DEVELOPER OPTIONS AHEAD! By using these options, you could lose system data or compromise your security or privacy. ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Roboto",
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
