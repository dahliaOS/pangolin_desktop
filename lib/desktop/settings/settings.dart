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
import 'package:animations/animations.dart';
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

class Settings extends StatelessWidget {
  static List<TileItem> items = [
    TileItem(
      "Connections",
      "Wi-Fi, Bluetooth, other connections",
      Icons.wifi,
      Connections(),
    ),
    TileItem(
      "Volume and sounds",
      "Sound mode, volume",
      Icons.volume_up,
      Sound(),
    ),
    TileItem(
      "Display",
      "Brightness, Blue light filter",
      Icons.brightness_5,
      Display(),
    ),
    TileItem(
      "Customization",
      "Customize the look and feel of Pangolin",
      Icons.color_lens,
      Customization(),
    ),
    TileItem(
      "Applications",
      "Manage Apps and permissions",
      Icons.apps,
      Applications(),
    ),
    TileItem(
      "Security",
      "Settings for security and privacy",
      Icons.security,
      Security(),
    ),
    TileItem(
      "Accounts",
      "Manage and add accounts",
      Icons.people,
      Accounts(),
    ),
    TileItem(
      "Backup",
      "Backup and Restore",
      Icons.update,
      Backup(),
    ),
    TileItem(
      "Advanced Features",
      "Coming soon!",
      Icons.add_circle_outline,
      AdvancedFeatures(),
    ),
    TileItem(
      "General management",
      "Language, Keyboard, Time",
      Icons.language,
      GeneralManagement(),
    ),
    TileItem(
      "Updates",
      "Download, Sources, Changelog",
      Icons.system_update,
      Updates(),
    ),
    TileItem(
      "About Device",
      "Status, Information",
      Icons.laptop,
      About(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomizationNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
      ],
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
        },
      ),
    );
  }
}

Widget buildSettings(
    IconData icon, String title, Color color, context, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 30,
      margin: EdgeInsets.only(
        left: 15,
        top: 15,
      ),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: Icon(icon, size: 20, color: color)),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff000000),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Container buildSettingsHeader(String title) {
  return Container(
    padding: const EdgeInsets.only(
      top: 25,
      left: 15,
    ),
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        color: Color(0xff222222),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class SettingsPage extends StatefulWidget {
  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
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
                                  vertical: 25,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
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
                                                color: Color(
                                                  HiveManager.get(
                                                      "accentColorValue"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: constraints.maxWidth > 768,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Settings",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                          const Radius.circular(25),
                                        ),
                                        //elevation: 5.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed("/search");
                                          },
                                          child: Container(
                                            width: 700,
                                            height: 45.0,
                                            margin: EdgeInsets.only(
                                                left: 10, right: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: AbsorbPointer(
                                                    child: TextField(
                                                      style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontSize: 15,
                                                      ),
                                                      maxLines: 1,
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1
                                                                    .color,
                                                                fontSize: 15,
                                                              ),
                                                              icon: Icon(
                                                                Icons.search,
                                                                color: Color(
                                                                    HiveManager.get(
                                                                        "accentColorValue")),
                                                              ),
                                                              hintText: constraints
                                                                          .maxWidth >
                                                                      768
                                                                  ? 'Search settings...'
                                                                  : "",
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      onSubmitted: null,
                                                      controller:
                                                          provider.controller,
                                                    ),
                                                  ),
                                                ),
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
                                          color: provider.pageIndex == i
                                              ? Color(
                                                  HiveManager.get(
                                                      "accentColorValue"),
                                                ).withOpacity(0.2)
                                              : Color(
                                                  HiveManager.get(
                                                      "accentColorValue"),
                                                ).withOpacity(0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          dense: true,
                                          title: Visibility(
                                            visible: constraints.maxWidth > 768
                                                ? true
                                                : false,
                                            child: Text(
                                              Settings.items[i].title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          subtitle: Visibility(
                                            visible: constraints.maxWidth > 768
                                                ? true
                                                : false,
                                            child: Text(
                                                Settings.items[i].subtitle),
                                          ),
                                          leading: Icon(
                                            Settings.items[i].icon,
                                            color: Color(
                                              HiveManager.get(
                                                "accentColorValue",
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(
                                              () => provider.pageIndex = i,
                                            );
                                          },
                                        ),
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
                          child: PageTransitionSwitcher(
                            child: IndexedStack(
                              key: ValueKey(provider.pageIndex),
                              index: provider.pageIndex,
                              children:
                                  Settings.items.map((e) => e.page).toList(),
                            ),
                            transitionBuilder:
                                (child, primaryAnimation, secondaryAnimation) {
                              return FadeThroughTransition(
                                animation: primaryAnimation,
                                secondaryAnimation: secondaryAnimation,
                                child: child,
                                fillColor: Colors.transparent,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class TileItem {
  String title, subtitle;
  IconData icon;
  Widget page;

  TileItem(this.title, this.subtitle, this.icon, this.page);
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
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
                child: Container(
                  width: 700,
                  height: 45.0,
                  margin: EdgeInsets.only(left: 10, right: 5),
                  child: Row(
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
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
                            border: InputBorder.none,
                          ),
                          onSubmitted: null,
                          controller: provider.controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SettingsProvider extends ChangeNotifier {
  int _pageIndex = 0;
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
