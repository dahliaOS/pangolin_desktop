/*
Copyright 2020 The dahliaOS Authors
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
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'terminal-widget.dart';

void main() => runApp(TerminalApp());

class TerminalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFFff6507),
        canvasColor: const Color(0xFF303030),
        platform: TargetPlatform.fuchsia,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => TerminalUI(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SettingsScreen(),
      },
    );
  }
}

class TerminalUI extends StatefulWidget {
  TerminalUI({Key key}) : super(key: key);
  @override
  TerminalUIState createState() => new TerminalUIState();
}

class TerminalUIState extends State<TerminalUI> with TickerProviderStateMixin {
  List<Tab> tabs = [];
  TabController tabController;
  var count = 1;
  void newTab() {
    setState(() {
      tabs.add(
        Tab(
          child: Row(
            children: <Widget>[
              Text('Session ' '$count'),
              Padding(
                padding: EdgeInsets.only(left: 8),
              ),
              new Expanded(child: new Container()),
              GestureDetector(
                child: Icon(
                  Icons.clear,
                  size: 16,
                  //color: Colors.black,
                ),
                onTap: closeCurrentTab,
              ),
            ],
          ),
        ),
      );
      count++;
      tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  void closeCurrentTab() {
    setState(() {
      tabs.removeAt(tabController.index);
      tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  @override
  void initState() {
    super.initState();
    tabs.add(
      Tab(
        child: Row(
          children: <Widget>[
            Text('Session ' '0'),
            Padding(
              padding: EdgeInsets.only(left: 8),
            ),
            new Expanded(child: new Container()),
            GestureDetector(
              child: Icon(
                Icons.clear,
                size: 16,
                //color: Colors.black,
              ),
              onTap: closeCurrentTab,
            ),
          ],
        ),
      ),
    );
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF212121),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0), // here the desired height
            child: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xFF282828),
                bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(55.0), // here the desired height
                    child: new Row(
                      children: [
                        new Expanded(
                            child: new Container(
                          child: TabBar(
                              controller: tabController,
                              labelColor: Color(0xFFffffff),
                              unselectedLabelColor: Colors.white,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  color: Color(0xFF212121)),
                              tabs: tabs.map((tab) => tab).toList()),
                        )),
                        new Center(
                          child: new IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: newTab),
                        ),
                        new Center(
                          child: new IconButton(
                            icon: Icon(Icons.settings),
                            color: Colors.white,
                            onPressed: () {
                              // Navigate to the second screen using a named route.
                              Navigator.pushNamed(context, '/second');
                            },
                          ),
                        ),
                      ],
                    )) // A trick to trigger TabBar rebuild.
                )),
        body: TabBarView(
          controller: tabController,
          children: tabs.map((tab) => Terminal()).toList(),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF282828),
            title: Text("Settings"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Appearance",
                ),
                Tab(text: "Keyboard & mouse"),
                Tab(
                  text: "Behavior",
                ),
                Tab(
                  text: "About",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new Center(
                child: new Container(
                  width: 800,
                  child: AppearanceWidget(),
                ),
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}

Widget themeCard(Color bgcolor, Color fgcolor1, Color fgcolor2, Color fgcolor3,
    String themeName) {
  return new Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          height: 100,
          width: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: new Column(children: <Widget>[
                Container(
                  height: 75,
                  width: 120,
                  color: bgcolor,
                  child: new Center(
                    child: new RichText(
                      text: TextSpan(
                          text: 'user@host',
                          style: TextStyle(
                              fontFamily: "Cousine",
                              fontSize: 12,
                              color: fgcolor1),
                          children: <TextSpan>[
                            TextSpan(
                              text: '~',
                              style: TextStyle(
                                  fontFamily: "Cousine",
                                  fontSize: 12,
                                  color: fgcolor2),
                            ),
                            TextSpan(
                              text: '\$',
                              style: TextStyle(
                                fontSize: 12,
                                color: fgcolor3,
                                fontFamily: "Cousine",
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                new Container(
                  height: 25,
                  width: 120,
                  color: Colors.grey[800],
                  child: new Center(
                    child: new Text(themeName),
                  ),
                )
              ]))));
}

class AppearanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            padding: EdgeInsets.all(25),
            child: new Expanded(
                child: new SingleChildScrollView(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  new Text(
                    "Theme",
                    style: new TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Wrap(
                        children: [
                          themeCard(
                              Color(0xFF222222),
                              Color(0xFFf2f2f2),
                              Color(0xFFf2f2f2),
                              Color(0xFFf2f2f2),
                              "Default Dark"),
                          themeCard(Color(0xff150896), Color(0xff766CF9),
                              Color(0xff766CF9), Color(0xff766CF9), "C64"),
                          themeCard(Colors.white, Colors.black, Colors.black,
                              Colors.black, "xterm"),
                          themeCard(
                              Color(0xff37474f),
                              Color(0xff4caf50),
                              Color(0xff4caf50),
                              Color(0xff4caf50),
                              "San Gorgonio"),
                          themeCard(
                              Color(0xff000000),
                              Color(0xff32cd32),
                              Color(0xff32cd32),
                              Color(0xff32cd32),
                              "Hackerman"),
                          themeCard(Color(0xff282a36), Color(0xffbd93f9),
                              Color(0xff50fa7b), Color(0xfff8f8f2), "Dracula"),
                          themeCard(Color(0xff2D0922), Color(0xff7EDA34),
                              Color(0xff1D89D6), Color(0xffFDFEFC), "Unity"),
                          themeCard(Color(0xff26292E), Color(0xffF85A5A),
                              Color(0xff39ABDC), Color(0xffFDFEFC), "Subspace"),
                          themeCard(Color(0xff212D34), Color(0xff55B1C2),
                              Color(0xff32A5F1), Color(0xff7DE5D2), "Argon"),
                          themeCard(
                              Color(0xffe0e0e0),
                              Color(0xff616161),
                              Color(0xff424242),
                              Color(0xff212121),
                              "Noir Light"),
                        ],
                      )
                    ],
                  ),
                ])))));
  }
}
