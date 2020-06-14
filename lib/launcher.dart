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
import 'searchbar.dart';
import 'dart:ui';
import 'widgets/cards.dart';

class LauncherWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: Colors.black.withOpacity(0.5),
      ),
      home: Launcher(title: 'Launcher'),
    );
  }
}

MaterialButton buildTile(String icon, String label) {
  return MaterialButton(
    onPressed: null //kanou pls help
    ,
    child: Column(
      //mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Image.asset(
          icon,
          fit: BoxFit.fill,
          width: 64.0,
          height: 64.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class Launcher extends StatelessWidget {
  Launcher({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: [
        new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
          ),
        ),
        new Scaffold(
          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.top,
              children: <Widget>[
                new SearchWidget(),
                new SingleChildScrollView(
                    padding:
                        new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    scrollDirection: Axis.horizontal,
                    child: new Row(children: <Widget>[
                      buildCard(
                          Icons.brightness_low,
                          'System',
                          Colors.deepOrange,
                          Colors.deepOrange.withAlpha(30),
                          'Welcome to dahliaOS!',
                          context),
                      buildCard(
                          Icons.info,
                          'Information',
                          Colors.blue,
                          Colors.blue.withAlpha(30),
                          'Warning: You are on a pre-release development build. For your protection, this build has been airgapped.',
                          context),
                      buildCard(
                          Icons.music_note,
                          'Music - Now Playing',
                          Colors.lightGreen,
                          Colors.lightGreen.withAlpha(30),
                          'Powerhouse of the Sell - The Revival',
                          context),
                      buildCard(
                          Icons.lock,
                          'Security',
                          Colors.red,
                          Colors.red.withAlpha(30),
                          'Filesystem lock is ON',
                          context),
                      buildCard(
                          Icons.memory,
                          'Kernel',
                          Colors.pink,
                          Colors.pink.withAlpha(30),
                          'Drivers for Integrated GPU updated',
                          context),
                    ])),
                tileSection
              ],
            ),
          ),
        ),
      ],
    );
  }
}
