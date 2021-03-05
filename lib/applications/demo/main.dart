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

import 'package:Pangolin/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new ThemeDemoApp());
}

class ThemeDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.grey[100]),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: Pangolin.settingsBox.get("darkMode")
          ? ThemeMode.dark
          : ThemeMode.light,
      home: new ThemeDemoHomePage(),
    );
  }
}

class ThemeDemoHomePage extends StatefulWidget {
  ThemeDemoHomePage({Key key}) : super(key: key);
  @override
  _ThemeDemoHomePageState createState() => new _ThemeDemoHomePageState();
}

class _ThemeDemoHomePageState extends State<ThemeDemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Theme Demo'),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.insert_emoticon,
                color: const Color(0xFFff0000), size: 200.0),
            new Text(
              "Some Text to theme",
              style: new TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            )
          ]),
    );
  }
}
