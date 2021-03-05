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
import 'dart:io';

extension CustomColorScheme on ColorScheme {
  Color get foregroundText => brightness == Brightness.light
      ? const Color(0xFF222222)
      : const Color(0xFFffffff);
  Color get cardColor => brightness == Brightness.light
      ? const Color(0xFFffffff)
      : const Color(0xFF333333);
  Color get barIconColor => brightness == Brightness.light
      ? const Color(0xFF454545)
      : const Color(0xFFffffff);
  Color get barColor => brightness == Brightness.light
      ? const Color(0xFFe0e0e0)
      : const Color(0xFF333333);
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          platform: TargetPlatform.fuchsia,
          brightness: Brightness.light,
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.grey[100]),
      darkTheme: ThemeData(
        platform: TargetPlatform.fuchsia,
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
      title: 'Text Editor',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/second',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => TextEditorHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

class TextEditorHomePage extends StatefulWidget {
  TextEditorHomePage({Key key}) : super(key: key);
  @override
  _TextEditorHomePageState createState() => new _TextEditorHomePageState();
}

class _TextEditorHomePageState extends State<TextEditorHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
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
          centerTitle: false,
          title: Text('Untitled Document'),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
        body: Column(children: [
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.barColor,
              child: SingleChildScrollView(
                  //padding:
                  // new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.undo,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.redo,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    VerticalDivider(
                      endIndent: 10,
                      indent: 10,
                      color: Theme.of(context).colorScheme.barIconColor,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_bold,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.strikethrough_s,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_underlined,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_italic,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_quote,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.code,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    VerticalDivider(
                      endIndent: 10,
                      indent: 10,
                      color: Theme.of(context).colorScheme.barIconColor,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H1",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H2",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H3",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H4",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H5",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H6",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).colorScheme.barIconColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    VerticalDivider(
                      endIndent: 10,
                      indent: 10,
                      color: Theme.of(context).colorScheme.barIconColor,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_list_bulleted,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_list_numbered,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    VerticalDivider(
                      endIndent: 10,
                      indent: 10,
                      color: Theme.of(context).colorScheme.barIconColor,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.link,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.image,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.table_chart,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.insert_emoticon,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.functions,
                                size: 25,
                                color: Theme.of(context)
                                    .colorScheme
                                    .barIconColor))),
                  ]))),
          new Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(25.0),
              width: 900,
              height: 1600,
              child: Card(
                color: Theme.of(context).colorScheme.cardColor,
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: new TextFormField(
                    onChanged: (text) {
                      print("First text field: $text");
                    },
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.foregroundText,
                      fontFamily: "Roboto",
                    ),
                    decoration: InputDecoration.collapsed(hintText: ""),
                    autocorrect: false,
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    cursorColor: Theme.of(context).colorScheme.foregroundText,
                  ),
                ),
              ),
            ),
          ))
        ]));
  }
}
//Navigator.pop(context);
