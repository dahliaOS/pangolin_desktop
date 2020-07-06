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

int selected;

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
    items.add(new TileItem("Wifi", Icons.wifi, true, pageone()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pageone()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagetwo()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagethree()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagefour()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagefive()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagesix()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pageseven()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pageone()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagetwo()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagethree()));
    items.add(new TileItem("Bluetooth", Icons.bluetooth, false, pagefour()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      DrawerHeader(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Colors.deepOrange[700],
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
                            SizedBox(
                              height: 30,
                            ),
                            Material(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(25)),
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
                                        ? Colors.deepOrange[700]
                                            .withOpacity(0.2)
                                        : Colors.deepOrange[700]
                                            .withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                    title: Text(items[i].title),
                                    leading: Icon(
                                      items[i].icon,
                                      color: Colors.deepOrange[600],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        for (int _i = 0;
                                            _i < items.length;
                                            _i++) {
                                          items[_i].selected = false;
                                        }
                                        items[i].selected = true;
                                      });
                                      contoller.animateToPage(i,
                                          duration: Duration(milliseconds: 750),
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
                Flexible(
                    flex: 5,
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        pageSnapping: false,
                        physics: BouncingScrollPhysics(),
                        controller: contoller,
                        onPageChanged: (index) {
                          print(index);
                        },
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return items[index].page;
                        })

                    /*PageView(
                      
                      children: [
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.blue,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                      ],
                    )*/
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TileItem {
  String title;
  IconData icon;
  bool selected;
  Widget page;

  TileItem(this.title, this.icon, this.selected, page);
}

class pageone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class pagetwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
    );
  }
}

class pagethree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}

class pagefour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}

class pagefive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }
}

class pagesix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class pageseven extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
    );
  }
}
