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

//credits: @HrX03 for basic UI https://github.com/HrX03/Flux

import 'dart:io';

import 'package:Pangolin/applications/files/entity_info.dart';
import 'package:Pangolin/applications/files/folder_provider.dart';
import 'package:Pangolin/applications/files/searchappbar.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new Files());
}

final _folderProvider = FolderProvider();
String _currentDir;
TextEditingController _textcontroller = TextEditingController();
FocusNode _focusNode = FocusNode();

class Files extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Files',
      theme: ThemeData.dark().copyWith(accentColor: Colors.deepOrange),
      home: new FilesHome(),
    );
  }
}

class FilesHome extends StatefulWidget {
  @override
  _FilesHomeState createState() => _FilesHomeState();
}

class _FilesHomeState extends State<FilesHome> {
  List<SideDestination> sideDestinations = [];
  RelativeRect rect;
  ScrollController _controller = ScrollController();

  bool ascending = true;
  int columnIndex = 0;
  @override
  void initState() {
    _folderProvider.directories.forEach((element) {
      sideDestinations.add(
        SideDestination(
          element.value,
          getEntityName(element.key),
          element.key,
        ),
      );
    });
    _currentDir = _folderProvider.directories[0].key;
    super.initState();
  }

  Future<List<EntityInfo>> getInfoForDir(Directory dir) async {
    List<FileSystemEntity> list = await dir.list().toList();
    List<EntityInfo> directories = [];
    List<EntityInfo> files = [];

    for (int i = 0; i < list.length; i++) {
      String name = getEntityName(list[i].path);
      if (name.startsWith(".")) {
        list.removeAt(i);
        continue;
      }

      EntityInfo info = EntityInfo(
        entity: list[i],
        stat: await list[i].stat(),
      );

      if (list[i] is Directory) {
        info.entityType = EntityType.DIRECTORY;
        info.children = await (list[i] as Directory).list().toList();
        directories.add(info);
      } else {
        info.entityType = EntityType.FILE;
        files.add(info);
      }
    }

    directories.sort((a, b) => sort(a, b, isDirectory: true));
    files.sort((a, b) => sort(a, b));

    return [...directories, ...files];
  }

  String getEntityName(String path) {
    return path.split("/").last;
  }

  int sort(EntityInfo a, EntityInfo b, {isDirectory = false}) {
    EntityInfo item1 = a;
    EntityInfo item2 = b;

    if (!ascending) {
      item2 = a;
      item1 = b;
    }

    switch (columnIndex) {
      case 0:
        return getEntityName(item1.path.toLowerCase())
            .compareTo(getEntityName(item2.path.toLowerCase()));
      case 1:
        return item1.stat.modified.compareTo(item2.stat.modified);
      case 2:
        if (isDirectory) {
          return item1.children.length.compareTo(item2.children.length);
        } else {
          return item1.stat.size.compareTo(item2.stat.size);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Drawer(
            child: ListView(
              children: List.generate(
                sideDestinations.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: _currentDir == sideDestinations[index].path
                        ? Theme.of(context).accentColor
                        : null,
                    child: ListTile(
                      dense: true,
                      leading: Icon(sideDestinations[index].icon,
                          color: Colors.white),
                      title: Text(
                        sideDestinations[index].label,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => setState(
                          () => _currentDir = sideDestinations[index].path),
                    ),
                  ),
                ),
              )
                ..insert(
                    0,
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                    ))
                ..insert(
                  0,
                  Container(
                    height: 55,
                    color: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 18.5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.folder_open_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Files",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    List<String> backDir =
                                        _currentDir.split("/")..removeLast();
                                    _currentDir = backDir.join("/");
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: SearchAppBar(
                actions: [
                  Container(
                    width: 290,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.create_new_folder_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Create new Folder"),
                                    content: TextField(
                                      controller: _textcontroller,
                                      focusNode: _focusNode,
                                      onSubmitted: (text) {
                                        Directory(_currentDir + "/$text")
                                            .create(recursive: false);
                                        Navigator.of(context).pop();
                                        _textcontroller.clear();
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Folder Name"),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Cancel"),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Container(
                                        child: FlatButton(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text("Create Folder"),
                                          ),
                                          onPressed: () {
                                            Directory dir = Directory(
                                                _currentDir +
                                                    "/${_textcontroller.text}");
                                            dir.create(recursive: false);
                                            Navigator.of(context).pop();
                                            _textcontroller.clear();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.list_alt_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: FutureBuilder<List<EntityInfo>>(
                future: getInfoForDir(Directory(_currentDir)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.isNotEmpty) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: CupertinoScrollbar(
                          radiusWhileDragging: Radius.circular(10),
                          thicknessWhileDragging: 20,
                          thickness: 10,
                          controller: _controller,
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: DataTable(
                                sortAscending: ascending,
                                sortColumnIndex: columnIndex,
                                showCheckboxColumn: false,
                                columns: [
                                  DataColumn(
                                    label: Text("Name"),
                                    onSort: (newColumnIndex, newAscending) =>
                                        setState(() {
                                      if (columnIndex == newColumnIndex) {
                                        ascending = newAscending;
                                      } else {
                                        ascending = true;
                                        columnIndex = newColumnIndex;
                                      }
                                    }),
                                  ),
                                  DataColumn(
                                    label: Text("Date"),
                                    onSort: (newColumnIndex, newAscending) =>
                                        setState(() {
                                      if (columnIndex == newColumnIndex) {
                                        ascending = newAscending;
                                      } else {
                                        ascending = true;
                                        columnIndex = newColumnIndex;
                                      }
                                    }),
                                  ),
                                  DataColumn(
                                    label: Text("Size"),
                                    onSort: (newColumnIndex, newAscending) =>
                                        setState(() {
                                      if (columnIndex == newColumnIndex) {
                                        ascending = newAscending;
                                      } else {
                                        ascending = true;
                                        columnIndex = newColumnIndex;
                                      }
                                    }),
                                  ),
                                  DataColumn(
                                    label: Text("Type"),
                                  ),
                                ],
                                rows: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    EntityInfo item = snapshot.data[index];

                                    return DataRow(
                                      onSelectChanged: (_) async {
                                        if (item.isDirectory) {
                                          setState(
                                              () => _currentDir = item.path);
                                        } else {
                                          final result =
                                              await OpenFile.open(item.path);
                                          print(result.type);
                                          if (result.type == ResultType.error) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Text(
                                                    "No app registered for this file type."),
                                                actions: [
                                                  TextButton(
                                                    child: Text("Ok"),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(
                                                item.isDirectory
                                                    ? Icons.folder
                                                    : Icons.insert_drive_file,
                                              ),
                                              SizedBox(width: 16),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 400,
                                                ),
                                                child: Text(
                                                  getEntityName(item.path),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            DateFormat("HH:mm - d MMM yyyy")
                                                .format(
                                              item.stat.modified,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            item.isDirectory
                                                ? item.children.length
                                                        .toString() +
                                                    " items"
                                                : filesize(item.stat.size),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            item.isDirectory
                                                ? "Directory"
                                                : "File",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open_outlined,
                                size: 80,
                              ),
                              Text(
                                "This Folder is Empty",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                        ),
                      )),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideDestination {
  final IconData icon;
  final String label;
  final String path;

  const SideDestination(this.icon, this.label, this.path);
}
