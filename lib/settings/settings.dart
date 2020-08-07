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

import 'package:Pangolin/applications/containers.dart';
import 'package:Pangolin/main.dart';
import 'package:Pangolin/settings/pages/backup.dart';
import 'package:Pangolin/settings/pages/about.dart';
import 'package:Pangolin/settings/pages/accounts.dart';
import 'package:Pangolin/settings/pages/advfeatures.dart';
import 'package:Pangolin/settings/pages/applications.dart';
import 'package:Pangolin/settings/pages/connections.dart';
import 'package:Pangolin/settings/pages/customization.dart';
import 'package:Pangolin/settings/pages/display.dart';
import 'package:Pangolin/settings/pages/genmanagement.dart';
import 'package:Pangolin/settings/pages/security.dart';
import 'package:Pangolin/settings/pages/sound.dart';
import 'package:Pangolin/settings/pages/updates.dart';
import 'package:Pangolin/themes/customization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import 'hiveManager.dart';

void main() {
  runApp(
    MaterialApp(
      home: Settings(),
    ),
  );
}

int selected;

class Settings extends StatelessWidget {
  /*final Widget Function() customBar = (
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
  final Color customBackground = const Color(0xFFfafafa);*/
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomizationNotifier(),
      child: Consumer<CustomizationNotifier>(
          builder: (context, CustomizationNotifier notifier, child) {
        return MaterialApp(
          title: 'Settings',
          theme: notifier.darkTheme
              ? Themes.dark(Colors.deepOrange)
              : Themes.light(Colors.deepOrange),
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => SettingsPage(title: 'Settings'),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => SecondScreen(),
          },
        );
      }),
    );
  }
}

/*class SettingsBar extends StatelessWidget {
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
}*/

Widget buildSettings(
    IconData icon, String title, Color color, context, Function onTap) {
  return new GestureDetector(
      onTap: onTap,
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
PageController contoller = PageController();

class SettingsPage extends StatefulWidget {
  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<TileItem> items = new List<TileItem>();

  @override
  void initState() {
    items.add(new TileItem("Connections", "Wifi, Bluetooth, other Connections",
        Icons.wifi, true, Connections()));
    items.add(new TileItem("Volume and Sounds", "Sound mode, Volume",
        Icons.volume_up, false, Sound()));
    items.add(new TileItem("Display", "Brightness, Blue light filter",
        Icons.brightness_5, false, Display()));
    items.add(new TileItem(
        "Customization",
        "Customize the look and feel of Pangolin",
        Icons.color_lens,
        false,
        Customization()));
    items.add(new TileItem("Applications", "Manage Apps and Permissions",
        Icons.apps, false, Applications()));
    items.add(new TileItem("Security", "Settings for Security and Privacy",
        Icons.security, false, Security()));
    items.add(new TileItem("Accounts", "Manage and add Accounts", Icons.people,
        false, Accounts()));
    items.add(new TileItem(
        "Backup", "Backup and Restore", Icons.update, false, Backup()));
    items.add(new TileItem("Advanced Features", "Comming",
        Icons.add_circle_outline, false, AdvancedFeatures()));
    items.add(new TileItem("General Management", "Language, Keyboard, Time",
        Icons.language, false, GeneralManagement()));
    items.add(new TileItem("Updates", "Download, Changelog",
        Icons.system_update, false, Updates()));
    items.add(new TileItem(
        "About Device", "Status, Information", Icons.laptop, false, About()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      DrawerHeader(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Color(
                                        HiveManager().get("accentColorValue")),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Material(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(25)),
                              //elevation: 5.0,
                              child: new Container(
                                width: 700,
                                height: 45.0,
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
                                            color: Color(HiveManager()
                                                .get("accentColorValue")),
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: items[i].selected == true
                                        ? Color(HiveManager()
                                                .get("accentColorValue"))
                                            .withOpacity(0.2)
                                        : Color(HiveManager()
                                                .get("accentColorValue"))
                                            .withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                    dense: true,
                                    title: Text(items[i].title),
                                    subtitle: Text(items[i].subtitle),
                                    leading: Icon(
                                      items[i].icon,
                                      color: Color(HiveManager()
                                          .get("accentColorValue")),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        //setSelected(i, items);
                                      });
                                      contoller.animateToPage(i,
                                          duration:
                                              Duration(milliseconds: 1000),
                                          curve: Curves.decelerate);
                                    }),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        pageSnapping: false,
                        physics: NeverScrollableScrollPhysics(),
                        controller: contoller,
                        onPageChanged: (index) {
                          setState(() {
                            setSelected(index, items);
                          });
                        },
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return items[index].page;
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TileItem {
  String title, subtitle;
  IconData icon;
  bool selected;
  Widget page;

  TileItem(this.title, this.subtitle, this.icon, this.selected, this.page);
}

setSelected(int index, List items) {
  for (int _i = 0; _i < items.length; _i++) {
    items[_i].selected = false;
  }
  items[index].selected = true;
}
