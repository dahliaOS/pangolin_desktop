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
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class Sound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
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
                    "Sound",
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
                    SettingsHeader(heading: "System volume"),
                    SettingsTile(
                      children: [
                        Text("Set your system volume"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Slider(
                                  activeColor: Color(_data.accentColor),
                                  inactiveColor: Color(_data.accentColor),
                                  divisions: 20,
                                  label:
                                      "${(_data.volumeLevel * 100).toString().replaceAll(".0", "")}%",
                                  onChanged: (double state) {
                                    _data.volumeLevel = state;
                                  },
                                  value: _data.volumeLevel,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SettingsHeader(heading: "Volume levels"),
                    SettingsTile(
                      children: [
                        Text("Set individual volume for each application"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Slider(
                                  activeColor: Color(_data.accentColor),
                                  inactiveColor: Color(_data.accentColor),
                                  divisions: 20,
                                  label:
                                      "${(_data.volumeLevel * 100).toString().replaceAll(".0", "")}%",
                                  onChanged: (double state) {
                                    _data.volumeLevel = state;
                                  },
                                  value: _data.volumeLevel,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SettingsHeader(heading: "Output"),
                    SettingsTile(
                      children: [
                        Text("Select output device"),
                        SizedBox(height: 5),
                        Container(
                          width: 1.7976931348623157e+308,
                          child: DropdownButton<String>(
                            icon: Icon(null),
                            hint: Text("Language"),
                            value: "Speaker",
                            items:
                                ["Speaker", "Headphones"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Slider(
                                activeColor: Color(_data.accentColor),
                                inactiveColor: Color(_data.accentColor),
                                divisions: 20,
                                label:
                                    "${(_data.volumeLevel * 100).toString().replaceAll(".0", "")}%",
                                onChanged: (double state) {
                                  _data.volumeLevel = state;
                                },
                                value: _data.volumeLevel,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
