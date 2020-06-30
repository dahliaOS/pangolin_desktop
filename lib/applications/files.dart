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

import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(new Files());
}

class Files extends StatelessWidget {
  final Widget Function() customBar = ({ //customBar in lib/window/window.dart
  /// The function called to close the window.
  Function close,
  /// The function called to minimize the window.
  Function minimize,
  /// The function called to maximize or restore the window.
  Function maximize,
  /// The getter to determine whether or not the window is maximized.
  bool Function() maximizeState}) {
    return FilesBar(close: close, minimize: minimize, maximize: maximize);
  };
  final Color customBackground = const Color(0xFFfafafa);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Files',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new FilesHome(),
    );
  }
}

class FilesBar extends StatelessWidget {
  final Function() minimize;
  final Function() maximize;
  final Function() close;

  FilesBar({
    Key key,
    this.minimize,
    this.maximize,
    this.close
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        height: 50,
        color: Color(0x7fffffff),
        child: Row(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(15),
                child: Text('Files',
                  style:
                    TextStyle(fontSize: 18, color: Color(0xff000000)
                  )
                )
            )
          ),
          Expanded(
            child: new Text('test'),
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
        ])
      )
    ));
  }
}

class FilesHome extends StatefulWidget {
  FilesHome({Key key}) : super(key: key);
  @override
  _FilesHomeState createState() => new _FilesHomeState();
}

class _FilesHomeState extends State<FilesHome> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(children: [
        Row(children: [
          Container(width: 256, color: Color(0xffeeeeee)),
          Expanded(child: Container(color: Color(0xfff3f3f3)))
        ])
      ]),
    );
  }
}
