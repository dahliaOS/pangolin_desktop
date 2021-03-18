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

import 'dart:ui';
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
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
                    "About Device",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto"),
                  )),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 100,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                height: 200,
                //width: 200,
                child: Center(
                  child: Image(
                    image: AssetImage("assets/images/logos/dahliaOS-logo.png"),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SettingsHeader(heading: "Version"),
                SettingsTile(children: [Text(longName)]),
                SettingsHeader(heading: "Kernel"),
                SettingsTile(children: [Text(kernel)]),
                SettingsHeader(heading: "Pangolin Version"),
                SettingsTile(children: [Text(fullPangolinVersion)]),
                SettingsHeader(heading: "Developer Options"),
                SettingsTile(children: [
                  SwitchListTile(
                    secondary: Icon(Icons.developer_mode_outlined),
                    title: Text("Enable Developer Options"),
                    onChanged: (bool value) {
                      _data.enableDevOptions = !_data.enableDevOptions;
                    },
                    value: _data.enableDevOptions,
                  )
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
