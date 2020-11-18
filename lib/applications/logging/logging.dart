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

void main() {
  runApp(new Logs());
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'System Logs',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LogsPage(),
    );
  }
}

class LogsPage extends StatefulWidget {
  LogsPage({Key key}) : super(key: key);
  @override
  _LogsPageState createState() => new _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('System Logs'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.apps),
                selectedIcon: Icon(Icons.apps),
                label: Text('Application Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.new_releases),
                selectedIcon: Icon(Icons.new_releases),
                label: Text('Event Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Service Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.brightness_low),
                selectedIcon: Icon(Icons.brightness_low),
                label: Text('System Logs'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
