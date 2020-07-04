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

import 'package:GeneratedApp/applications/containers.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(
    MaterialApp(
      home: Settings(),
    ),
  );
}

class Settings extends StatelessWidget {
  final Widget Function() customBar = (
      { //customBar in lib/window/window.dart
      /// The function called to close the window.
      Function close,

      /// The function called to minimize the window.
      Function minimize,

      /// The function called to maximize or restore the window.
      Function maximize,

      /// The getter to determine whether or not the window is maximized.
      bool Function() maximizeState}) {
    return SettingsBar(close: close, minimize: minimize, maximize: maximize);
  };
  final Color customBackground = const Color(0xFFfafafa);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFFfafafa),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SettingsPage(title: 'Settings'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

class SettingsBar extends StatelessWidget {
  final Function() minimize;
  final Function() maximize;
  final Function() close;

  SettingsBar({Key key, this.minimize, this.maximize, this.close});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
                height: 35,
                color: Color(0xffeeeeee),
                child: Row(children: [
                  Center(
                    child: Container(),
                  ),
                  Expanded(
                    child: new Text(' '),
                  ),
                  Row(children: [
                    new IconButton(
                      icon: const Icon(Icons.minimize),
                      onPressed: minimize,
                      iconSize: 18.0,
                      color: const Color(0xFF000000),
                    ),
                    new IconButton(
                      icon: const Icon(Icons.crop_square),
                      onPressed: maximize,
                      iconSize: 18.0,
                      color: const Color(0xFF000000),
                    ),
                    new IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: close,
                      iconSize: 18.0,
                      color: const Color(0xFF000000),
                    ),
                  ])
                ]))));
  }
}

Widget buildSettings(IconData icon, String title, Color color, context) {
  return new GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/second');
      },
      child: Container(
          height: 30,
          margin: EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          child: Row(children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Icon(icon, size: 20, color: color)),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(title,
                    style: TextStyle(fontSize: 15, color: Color(0xff000000))))
          ])));
}

Container buildSettingsHeader(String title) {
  return new Container(
      padding: const EdgeInsets.only(
        top: 25,
        left: 15,
      ),
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              fontSize: 15,
              color: Color(0xff222222),
              fontWeight: FontWeight.w600)));
}

final TextEditingController editingController = new TextEditingController();

class SettingsPage extends StatelessWidget {
  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(children: [
          Container(
              height: 50,
              color: Color(0xffeeeeee),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.settings, color: Color(0xffff3D00))),
                Text('Settings',
                    style: TextStyle(fontSize: 20, color: Color(0xff222222)))
              ])),
          new Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: new Column(children: <Widget>[
                    Container(
                      color: Color(0xffeeeeee),
                      child: Container(
                        padding:
                            new EdgeInsets.only(left: 10, right: 10, top: 0),
                        margin: new EdgeInsets.only(bottom: 10.0),
                        child: new Material(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(25)),
                          elevation: 5.0,
                          child: new Container(
                            width: 700,
                            height: 35.0,
                            margin: new EdgeInsets.only(left: 10, right: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                    child: new TextField(
                                  style: new TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  decoration: new InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 15,
                                      ),
                                      icon: Icon(
                                        Icons.search,
                                        color: const Color(0xFFff3d00),
                                      ),
                                      hintText: 'Search settings...',
                                      border: InputBorder.none),
                                  onSubmitted: null,
                                  controller: editingController,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildSettingsHeader('WIRELESS & NETWORKS'),
                    buildSettings(
                        Icons.network_wifi, 'Wi-Fi', Colors.cyan[600], context),
                    buildSettings(Icons.bluetooth, 'Bluetooth',
                        Colors.blue[600], context),
                    buildSettings(
                        Icons.sim_card, 'Data', Colors.red[500], context),
                    buildSettings(Icons.settings_ethernet, 'Wired',
                        Colors.amber[500], context),
                    buildSettingsHeader('DEVICE'),
                    buildSettings(Icons.brightness_medium, 'Display',
                        Colors.red[600], context),
                    buildSettings(
                        Icons.keyboard, 'Input', Colors.blue[800], context),
                    buildSettings(
                        Icons.usb, 'Ports', Colors.orange[500], context),
                    buildSettings(
                        Icons.volume_up, 'Sound', Colors.teal[500], context),
                    buildSettings(
                        Icons.storage, 'Storage', Colors.blue[500], context),
                    buildSettings(
                        Icons.power, 'Power', Colors.amber[500], context),
                    buildSettings(
                        Icons.devices, 'Devices', Colors.blue[800], context),
                    buildSettingsHeader('SYSTEM'),
                    buildSettings(Icons.system_update, 'Updates',
                        Colors.deepOrange[500], context),
                    buildSettings(Icons.palette, 'Appearance',
                        Colors.green[500], context),
                    buildSettings(Icons.apps, 'Applications',
                        Colors.purple[800], context),
                    buildSettings(
                        Icons.person, 'Users', Colors.cyan[800], context),
                    buildSettings(Icons.visibility_off, 'Privacy',
                        Colors.pink[500], context),
                    buildSettings(Icons.access_time, 'Time',
                        Colors.deepOrange[500], context),
                    buildSettings(
                        Icons.security, 'Security', Colors.blue[500], context),
                    buildSettings(Icons.domain, 'Enterprise Enrollment',
                        Colors.deepOrange[500], context),
                    buildSettings(Icons.developer_board, 'Kernel',
                        Colors.deepOrange[500], context),
                    buildSettings(Icons.flag, 'Language',
                        Colors.deepOrange[500], context),
                    buildSettingsHeader('DEVELOPER'),
                    buildSettings(
                        Icons.flag, 'Flags', Colors.deepOrange[500], context),
                    buildSettings(Icons.developer_mode, 'Bootloader',
                        Colors.green[500], context),
                    buildSettings(Icons.extension, 'Extensions',
                        Colors.blueGrey[500], context),
                    buildSettings(Icons.brightness_low, 'Flutter',
                        Colors.lightBlue[500], context),
                    buildSettings(Icons.attach_money, 'System Shell',
                        Colors.grey[500], context),
                    buildSettings(Icons.android, 'Android Subsystem',
                        Color(0xFF3DDA84), context),
                    buildSettings(
                        Icons.note, 'System Logs', Colors.deepOrange, context),
                    buildSettingsHeader('ABOUT'),
                    buildSettings(Icons.brightness_low, 'System',
                        Colors.deepOrange[500], context),
                    buildSettings(Icons.phone_android, 'Device',
                        Colors.lightBlue[500], context),
                    buildSettings(
                        Icons.people, 'Credits', Colors.amber[600], context),
                    buildSettingsHeader(' '),
                  ]))),
        ]),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debian Container"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
