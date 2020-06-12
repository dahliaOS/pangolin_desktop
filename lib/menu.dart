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
import 'searchbar.dart';
import 'apps.dart';
//import 'launcher-widget.dart';

class AppMenu extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(// A simplified version of dialog.
      width: 600,
      height: 400,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            color: const Color(0xFFffffff),
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            width: 1.7976931348623157e+308,
            height: 75.0,
            child: SearchWidget(),
          ),
          WallpaperGrid(),
          PhoneGrid(),
          GmailGrid(),
          CalculatorGrid(),
          MusicGrid(),
          SettingsGrid(),
          ClockGrid(),
        ],
      ),
    );
  }
}
