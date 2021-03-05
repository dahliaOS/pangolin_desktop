/*
Copyright 2019 The dahliaOS Authors
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
import 'package:Pangolin/desktop/quicksettings/quick_settings.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/utils/themes/customization_manager.dart';
import 'package:Pangolin/utils/widgets/conditionWidget.dart';
import 'package:Pangolin/utils/widgets/settingsTile.dart';
import 'package:Pangolin/utils/widgets/settingsheader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdvancedFeatures extends StatefulWidget {
  @override
  _AdvancedFeaturesState createState() => _AdvancedFeaturesState();
}

class _AdvancedFeaturesState extends State<AdvancedFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Developer Options",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SettingsHeader(heading: "User Shells"),
                        SettingsTile(
                          children: [
                            Consumer<CustomizationNotifier>(
                              builder: (context, notifier, child) =>
                                  SwitchListTile(
                                secondary: Icon(Icons.desktop_windows),
                                value: HiveManager.get("blur"),
                                title:
                                    Text("Enable blur effects on the desktop"),
                                onChanged: (bool state) {
                                  setState(() {
                                    notifier.toggleBlur(state);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ])),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Color(0x00ffffff),
          child: new SizedBox(
              height: 50,
              width: 15,
              child: new Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    elevation: 0,
                    color: Colors.red[500],
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Row(
                        children: [
                          new Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.white,
                                  ))),
                          Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: new Text(
                                    "WARNING: ADVANCED OPTIONS AHEAD! By using these options, you could lose system data or compromise your security or privacy. ",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  )))),
    );
  }
}
