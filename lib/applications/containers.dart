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
  runApp(new Containers());
}

class Containers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Containers',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

class ContainersApp extends StatefulWidget {
  ContainersApp({Key key}) : super(key: key);
  @override
  _ContainersAppState createState() => new _ContainersAppState();
}

class _ContainersAppState extends State<ContainersApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Containers'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Downloads',
            onPressed: null,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: null,
          ),
        ],
      ),
      body: new SingleChildScrollView(
        padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          new Center(
            child: Container(
                width: 600,
                
                child: Card(
                    color: Color(0xffffffff),
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Image.asset(
                                  'lib/images/icons/v2/compiled/debian.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.fill)),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 10.0),
                              child: Text('Debian Buster',
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 18.0,
                                  ))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 10.0),
                              child: Text('debian.org',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ))),
                          new Container(
                            height: 175,
                            child: new Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 0.0,
                                      bottom: 0.0),
                                  child: new Expanded(
                                    child: new SingleChildScrollView(
                                        scrollDirection:
                                            Axis.vertical, //.horizontal
                                        child: Text(
                                            "The Debian Project is an association of individuals who have made common cause to create a free operating system. This operating system is called Debian. Debian systems currently use the Linux kernel. Linux is a completely free piece of software started by Linus Torvalds and supported by thousands of programmers worldwide. Of course, the thing that people want is application software: programs to help them get what they want to do done, from editing documents to running a business to playing games to writing more software. Debian comes with over 50,000 packages (precompiled software that is bundled up in a nice format for easy installation on your machine) - all of it free. It's a bit like a tower. At the base is the kernel. On top of that are all the basic tools. Next is all the software that you run on the computer. At the top of the tower is Debian -- carefully organizing and fitting everything so it all works together.",
                                            style: TextStyle(
                                              color: Color(0xff222222),
                                              fontSize: 15.0,
                                            ))),
                                  )),
                            ),
                          ),
                          new Center(
                            child: Expanded(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.brightness_5,
                                                size: 28,
                                                color: Color(0xffff3b00))),
                                        Center(child: Text('dahliaOS Verified'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.developer_board,
                                                size: 28,
                                                color: Colors.green)),
                                        Center(child: Text('Developer Friendly'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.file_download,
                                                size: 28,
                                                color: Colors.blue)),
                                        Center(child: Text('300MB'))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          Align(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0, right: 20, bottom: 15),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/second');
                                      },
                                      elevation: 1.0,
                                      color: Colors.blue[500],
                                      child: Text('Install'),
                                      textColor: Colors.white,
                                    )),
                              ]))
                        ]))),
          ),










new Center(
            child: Container(
                width: 600,
                
                child: Card(
                    color: Color(0xffffffff),
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Image.asset(
                                  'lib/images/icons/v2/compiled/ubuntu.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.fill)),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 10.0),
                              child: Text('Ubuntu 20.04',
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 18.0,
                                  ))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 10.0),
                              child: Text('ubuntu.com',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ))),
                          new Container(
                            height: 175,
                            child: new Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 0.0,
                                      bottom: 00.0),
                                  child: new Expanded(
                                    child: new SingleChildScrollView(
                                        scrollDirection:
                                            Axis.vertical, //.horizontal
                                        child: Text(
                                            "Ubuntu is a complete desktop Linux operating system, freely available with both community and professional support. The Ubuntu community is built on the ideas enshrined in the Ubuntu Manifesto: that software should be available free of charge, that software tools should be usable by people in their local language and despite any disabilities, and that people should have the freedom to customise and alter their software in whatever way they see fit. \"Ubuntu\" is an ancient African word, meaning \"humanity to others\". The Ubuntu distribution brings the spirit of Ubuntu to the software world.",
                                            style: TextStyle(
                                              color: Color(0xff222222),
                                              fontSize: 15.0,
                                            ))),
                                  )),
                            ),
                          ),
                          new Center(
                            child: Expanded(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.brightness_5,
                                                size: 28,
                                                color: Color(0xffff3b00))),
                                        Center(child: Text('dahliaOS Verified'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.developer_board,
                                                size: 28,
                                                color: Colors.green)),
                                        Center(child: Text('Developer Friendly'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.file_download,
                                                size: 28,
                                                color: Colors.blue)),
                                        Center(child: Text('1.2GB'))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          Align(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0, right: 20, bottom: 15),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/second');
                                      },
                                      elevation: 1.0,
                                      color: Colors.blue[500],
                                      child: Text('Install'),
                                      textColor: Colors.white,
                                    )),
                              ]))
                        ]))),
          ),




new Center(
            child: Container(
                width: 600,
                
                child: Card(
                    color: Color(0xffffffff),
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Image.asset(
                                  'lib/images/icons/v2/compiled/android.png',
                                  width: 32.0,
                                  height: 32.0,
                                  fit: BoxFit.fill)),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 10.0),
                              child: Text('Lineage OS 17.1 (Android Q)',
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 18.0,
                                  ))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 0.0,
                                  bottom: 0.0),
                              child: Text('lineageos.org',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ))),
                          new Container(
                            height: 175,
                            child: new Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 0.0,
                                      bottom: 0.0),
                                  child: new Expanded(
                                    child: new SingleChildScrollView(
                                        scrollDirection:
                                            Axis.vertical, //.horizontal
                                        child: Text(
                                            "LineageOS is an operating system for smartphones, tablet computers, and set-top boxes, based on Android with mostly free and open-source software. On dahliaOS, Lineage OS powers the Android container, allowing you to use your favorite mobile apps with dahliaOS.",
                                            style: TextStyle(
                                              color: Color(0xff222222),
                                              fontSize: 15.0,
                                            ))),
                                  )),
                            ),
                          ),
                          new Center(
                            child: Expanded(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.brightness_5,
                                                size: 28,
                                                color: Color(0xffff3b00))),
                                        Center(child: Text('dahliaOS Verified'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.supervisor_account,
                                                size: 28,
                                                color: Colors.green)),
                                        Center(child: Text('General Use'))
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: new Column(
                                      children: [
                                        Center(
                                            child: Icon(Icons.file_download,
                                                size: 28,
                                                color: Colors.blue)),
                                        Center(child: Text('1.5GB'))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          Align(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0, right: 20, bottom: 15),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/second');
                                      },
                                      elevation: 1.0,
                                      color: Colors.blue[500],
                                      child: Text('Install'),
                                      textColor: Colors.white,
                                    )),
                              ]))
                        ]))),
          )




        ]),
      ),

      /* Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
      */

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Containers'),
              decoration: BoxDecoration(
                color: Colors.blue,
                
              ),
            ),
            ListTile(
              title: Text('Debian'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/second');
              },
            ),
            ListTile(
              title: Text('Android'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/second');
              },
            ),
              ListTile(
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/second');
              },
            ),
          ],
        ),
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
