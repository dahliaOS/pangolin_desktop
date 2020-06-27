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
  runApp(new Files());
}
class Files extends StatelessWidget {
  final customBar = true;

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

class FilesHome extends StatefulWidget {
  FilesHome({Key key}) : super(key: key);
  @override
  _FilesHomeState createState() => new _FilesHomeState();
}

class _FilesHomeState extends State<FilesHome> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:
        

 Column(children: [
      Container(
          height: 50,
          color: Color(0xffffffff),
          child: Row(children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Files',
                        style: TextStyle(
                            fontSize: 18, color: Color(0xff000000))))),
            Expanded(child: new Text('test'),),
            Row(children: [
              new IconButton(
            icon: const Icon(Icons.minimize),
            onPressed:null,
            iconSize: 18.0,
            color: const Color(0xFF000000),
          ),
               new IconButton(
            icon: const Icon(Icons.crop_square),
            onPressed:null,
            iconSize: 18.0,
            color: const Color(0xFF000000),
          ),
             new IconButton(
            icon: const Icon(Icons.close),
            onPressed:null,
            iconSize: 18.0,
            color: const Color(0xFF000000),
          ),
            ])
          ])),
      Row(children: [
        Container(width: 256, color: Color(0xffeeeeee)),
        Expanded(child: Container(color: Color(0xfff3f3f3)))
      ])
    ]),


      );
    }
}