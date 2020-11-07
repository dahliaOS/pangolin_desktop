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

import 'package:Pangolin/desktop/settings/pages/backup.dart';
import 'package:Pangolin/desktop/settings/pages/about.dart';
import 'package:Pangolin/desktop/settings/pages/accounts.dart';
import 'package:Pangolin/desktop/settings/pages/advfeatures.dart';
import 'package:Pangolin/desktop/settings/pages/applications.dart';
import 'package:Pangolin/desktop/settings/pages/connections.dart';
import 'package:Pangolin/desktop/settings/pages/customization.dart';
import 'package:Pangolin/desktop/settings/pages/display.dart';
import 'package:Pangolin/desktop/settings/pages/genmanagement.dart';
import 'package:Pangolin/desktop/settings/pages/grid.dart';
import 'package:Pangolin/desktop/settings/pages/security.dart';
import 'package:Pangolin/desktop/settings/pages/sound.dart';
import 'package:Pangolin/desktop/settings/pages/updates.dart';
import 'package:Pangolin/utils/themes/customization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../utils/hiveManager.dart';

void main() {
  runApp(
    MaterialApp(
      home: Settings(),
    ),
  );
}

int selected;

class Settings extends StatelessWidget {
  static List<TileItem> items = new List<TileItem>();
  static PageController contoller = PageController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomizationNotifier(),
      child: Consumer<CustomizationNotifier>(
          builder: (context, CustomizationNotifier notifier, child) {
        return MaterialApp(
          title: 'Settings',
          theme: notifier.darkTheme
              ? Themes.dark(notifier.accent)
              : Themes.light(notifier.accent),
          initialRoute: '/settingshome',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => SettingsPage(title: 'Settings'),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/search': (context) => Search(),
            '/settingshome': (context) => SettingsHome(),
          },
        );
      }),
    );
  }
}

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

class SettingsPage extends StatefulWidget {
  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    Settings.items = new List();
    Settings.items.add(new TileItem(
        "Connections",
        "Wi-Fi, Bluetooth, other connections",
        Icons.wifi,
        true,
        Connections()));
    Settings.items.add(new TileItem("Volume and sounds", "Sound mode, volume",
        Icons.volume_up, false, Sound()));
    Settings.items.add(new TileItem("Display", "Brightness, Blue light filter",
        Icons.brightness_5, false, Display()));
    Settings.items.add(new TileItem(
        "Customization",
        "Customize the look and feel of Pangolin",
        Icons.color_lens,
        false,
        Customization()));
    Settings.items.add(new TileItem("Applications",
        "Manage Apps and permissions", Icons.apps, false, Applications()));
    Settings.items.add(new TileItem(
        "Security",
        "Settings for security and privacy",
        Icons.security,
        false,
        Security()));
    Settings.items.add(new TileItem("Accounts", "Manage and add accounts",
        Icons.people, false, Accounts()));
    Settings.items.add(new TileItem(
        "Backup", "Backup and Restore", Icons.update, false, Backup()));
    Settings.items.add(new TileItem("Advanced Features", "Coming soon!",
        Icons.add_circle_outline, false, AdvancedFeatures()));
    Settings.items.add(new TileItem(
        "General management",
        "Language, Keyboard, Time",
        Icons.language,
        false,
        GeneralManagement()));
    Settings.items.add(new TileItem("Updates", "Download, Sources, Changelog",
        Icons.system_update, false, Updates()));
    Settings.items.add(new TileItem(
        "About Device", "Status, Information", Icons.laptop, false, About()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed("/settingshome");
      //   },
      //   child: Icon(Icons.grid_on_outlined),
      // ),
      // appBar: AppBar(title: Text(widget.title)),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth > 768 ? 300 : 90,
                    child: Column(
                      children: [
                        DrawerHeader(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(25.0),
                                      onTap: () {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.of(context)
                                              .pushNamed("/settingshome");
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.menu,
                                          color: Color(HiveManager.get(
                                              "accentColorValue")),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: constraints.maxWidth > 768,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Settings",
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Hero(
                                tag: "search",
                                child: Material(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(25)),
                                  //elevation: 5.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed("/search");
                                    },
                                    child: new Container(
                                      width: 700,
                                      height: 45.0,
                                      margin: new EdgeInsets.only(
                                          left: 10, right: 5),
                                      child: new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                              child: AbsorbPointer(
                                            child: new TextField(
                                              style: new TextStyle(
                                                color: Colors.grey[900],
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color,
                                                    fontSize: 15,
                                                  ),
                                                  icon: Icon(
                                                    Icons.search,
                                                    color: Color(HiveManager.get(
                                                        "accentColorValue")),
                                                  ),
                                                  hintText:
                                                      constraints.maxWidth > 768
                                                          ? 'Search settings...'
                                                          : "",
                                                  border: InputBorder.none),
                                              onSubmitted: null,
                                              controller: editingController,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: ListView.builder(
                              itemCount: Settings.items.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  margin: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Settings.items[i].selected == true
                                          ? Color(HiveManager.get(
                                                  "accentColorValue"))
                                              .withOpacity(0.2)
                                          : Color(HiveManager.get(
                                                  "accentColorValue"))
                                              .withOpacity(0.0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                      dense: true,
                                      title: Visibility(
                                        visible: constraints.maxWidth > 768
                                            ? true
                                            : false,
                                        child: Text(Settings.items[i].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ),
                                      subtitle: Visibility(
                                          visible: constraints.maxWidth > 768
                                              ? true
                                              : false,
                                          child:
                                              Text(Settings.items[i].subtitle)),
                                      leading: Icon(
                                        Settings.items[i].icon,
                                        color: Color(HiveManager.get(
                                            "accentColorValue")),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          //setSelected(i, Settings.items);
                                        });
                                        Settings.contoller.animateToPage(i,
                                            duration:
                                                Duration(milliseconds: 500),
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
                          controller: Settings.contoller,
                          onPageChanged: (index) {
                            setState(() {
                              setSelected(index, Settings.items);
                            });
                          },
                          itemCount: Settings.items.length,
                          itemBuilder: (context, index) {
                            return Settings.items[index].page;
                          })),
                ],
              ),
            ),
          ],
        );
      }),
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
  items.forEach((element) {
    element.selected = false;
  });
  items[index].selected = true;
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Hero(
            tag: "search",
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(const Radius.circular(25)),
              //elevation: 5.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: new Container(
                  width: 700,
                  height: 45.0,
                  margin: new EdgeInsets.only(left: 10, right: 5),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(HiveManager.get("accentColorValue")),
                        ),
                      ),
                      new Expanded(
                          child: new TextField(
                        autofocus: true,
                        style: new TextStyle(
                          color: Colors.grey[900],
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        decoration: new InputDecoration(
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              fontSize: 15,
                            ),
                            icon: Icon(
                              Icons.search,
                              color: Color(HiveManager.get("accentColorValue")),
                            ),
                            hintText: 'Search settings',
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
        ));
  }
}
