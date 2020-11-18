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

import 'dart:io';
import 'dart:ui';

import 'package:Pangolin/utils/widgets/hover.dart';

import 'searchbar.dart';

import 'package:flutter/material.dart';

import 'package:path/path.dart' as p;

void main() {
  runApp(new Files());
}

class Files extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Files',
      theme: new ThemeData(
        platform: TargetPlatform.fuchsia,
        primarySwatch: Colors.purple,
      ),
      home: new FilesHome(),
    );
  }
}

bool viewTypeList = false;

class Folder extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onClick;

  const Folder({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewTypeList
        ? Container(
            //margin: EdgeInsets.all(5),
            child: Hover(
              opacity: 0.1,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(icon, color: Colors.deepOrange, size: 40.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.grey[900]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            constraints: BoxConstraints(minHeight: 50.0, minWidth: 50.0),
            //margin: EdgeInsets.all(25),
            child: Hover(
              opacity: 0.1,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.deepOrange, size: 50.0),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.grey[900]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class FilesHome extends StatefulWidget {
  FilesHome({Key key}) : super(key: key);
  @override
  _FilesHomeState createState() => new _FilesHomeState();
}

class _FilesHomeState extends State<FilesHome> {
  List<String> foldersandfiles = List<String>();

  @override
  void initState() {
    Directory dir = Directory(".");
    dir.list(recursive: false).forEach((f) {
      foldersandfiles.add(f.uri.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchAppBar(
        actions: [
          IconButton(
            icon: Icon(
              viewTypeList ? Icons.grid_on : Icons.list_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                viewTypeList = !viewTypeList;
              });
            },
          ),
        ],
      ),
      body: new Row(
        children: [
          new Container(
            color: Colors.white,
            width: 250,
            child: Drawer(
              elevation: 3.0,
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text('Home'),
                    leading: Icon(
                      Icons.home,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, "/info");
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Documents'),
                    leading: Icon(
                      Icons.create,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      // Navigator.pop(context);
                      //Navigator.pushNamed(context, "/feedback");
                    },
                  ),
                  ListTile(
                    title: Text('Downloads'),
                    leading: Icon(
                      Icons.file_download,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      //Navigator.pop(context);
                      //Navigator.pushNamed(context, "/social");
                    },
                  ),
                  ListTile(
                    title: Text('Applications'),
                    leading: Icon(
                      Icons.apps,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, "/credits");
                    },
                  ),
                  ListTile(
                    title: Text('Pictures'),
                    leading: Icon(
                      Icons.photo,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, "/software");
                    },
                  ),
                  ListTile(
                    title: Text('Videos'),
                    leading: Icon(
                      Icons.video_library,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, "/software");
                    },
                  ),
                  ListTile(
                    title: Text('Music'),
                    leading: Icon(
                      Icons.music_note,
                      color: Colors.deepOrange,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, "/software");
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
                  //constraints: BoxConstraints(maxWidth: 900),
                  padding: EdgeInsets.all(10.0),
                  child: viewTypeList
                      ? ListView.builder(
                          itemCount: foldersandfiles.length,
                          itemBuilder: (context, index) {
                            return Folder(
                                icon: foldersandfiles[index]
                                        .toString()
                                        .endsWith("/")
                                    ? Icons.folder
                                    : Icons.file_copy,
                                label: foldersandfiles[index].toString(),
                                onClick: () {});
                          },
                          padding: EdgeInsets.all(10.0),
                        )
                      : GridView.builder(
                          itemCount: foldersandfiles.length,
                          itemBuilder: (context, index) {
                            return Folder(
                                icon: foldersandfiles[index]
                                        .toString()
                                        .endsWith("/")
                                    ? Icons.folder
                                    : Icons.file_copy,
                                label: foldersandfiles[index].toString(),
                                onClick: () {});
                          },
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100),
                          //crossAxisCount: 15,
                          //padding: EdgeInsets.all(10.0),
                          //maxCrossAxisExtent: 100,
                          //children: children
                        )))
        ],
      ),
    );
  }
}

class _FilesBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text("Files")),
          Center(
            child: Container(
              color: Colors.black,
              height: 35,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
