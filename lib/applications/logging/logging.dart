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
import 'package:Pangolin/main.dart';
import 'shell/terminal-widget.dart';
import 'dart:io';

void main() {
  runApp(new Logs());
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'System Logs',
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      darkTheme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      themeMode: Pangolin.settingsBox.get("darkMode")
          ? ThemeMode.dark
          : ThemeMode.light,
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
  List<Widget> screens = [
    logItem("dmesg"),
    logItem("xorg"),
    logItem("message"),
    logItem("fs")
  ];

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
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.developer_board),
                selectedIcon: Icon(Icons.developer_board),
                label: Text('Kernel Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.tv),
                selectedIcon: Icon(Icons.tv),
                label: Text('Display Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.brightness_low),
                selectedIcon: Icon(Icons.brightness_low),
                label: Text('System Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.storage),
                selectedIcon: Icon(Icons.storage),
                label: Text('Filesystem Logs'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(child: screens[_selectedIndex])
        ],
      ),
    );
  }
}

String dmesg() {
  ProcessResult result = Process.runSync('dmesg', ['-k']);
  var verString = result.stdout;
  return verString;
}

String xorg() {
  ProcessResult result = Process.runSync('cat', ['/var/log/Xorg.0.log']);
  var verString = result.stdout;
  return verString;
}

String message() {
  ProcessResult result = Process.runSync('cat', ['/var/log/messages']);
  var verString = result.stdout;
  return verString;
}

String fs() {
  ProcessResult result = Process.runSync('df', ['-h']);
  var verString = result.stdout;
  return verString;
}

Widget logItem(String type) {
  return new Container(
    child: new Column(
      children: [
        new Expanded(
          child: new Container(
            width: 1.7976931348623157e+308,
            color: const Color(0xFF111111),
            child: new SingleChildScrollView(
              child: new Padding(
                padding: EdgeInsets.all(5),
                child: new Text(
                  () {
                    if (type == "dmesg") {
                      return dmesg();
                    }
                    if (type == "xorg") {
                      return xorg();
                    }
                    if (type == "message") {
                      return message();
                    }
                    if (type == "fs") {
                      return fs();
                    }
                  }(),
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: const Color(0xFFf2f2f2),
                      fontFamily: "Cousine"),
                ),
              ),
            ),
          ),
        ),
        new Container(
          height: 150,
          child: Terminal(),
        )
      ],
    ),
  );
}
