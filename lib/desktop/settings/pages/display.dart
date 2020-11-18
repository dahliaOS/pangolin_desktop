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

import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/utils/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Display",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Screen",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Text("Set your screen brightness"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Slider(
                                  divisions: 20,
                                  label:
                                      "${(HiveManager.get("brightness") * 100).toString()}%",
                                  onChanged: (double state) {
                                    setState(() {
                                      HiveManager.set("brightness", state);
                                    });
                                  },
                                  value: HiveManager.get("brightness"),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Blue light filter",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          onChanged: (bool value) {
                            setState(() {
                              HiveManager.set("enableBlueLightFilter", value);
                            });
                          },
                          value: HiveManager.get("enableBlueLightFilter"),
                          title: Text(
                              "Enable blue light filter to protect your eyes"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Resolution",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    AbsorbPointer(
                      child: SettingsTile(
                        children: [
                          Text("Adjust your screen resolution"),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Slider(
                                        divisions: 20,
                                        onChanged: (double state) {
                                          setState(() {});
                                        },
                                        value: 0.75,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 400,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[350],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      width: 400,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[350],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                //TODO put into Alert Dialog for Help
                                /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "You can adjust your Screen Resolution to to your personal feelings. \nThe Image to the right shows you information about different Screen Reolutions.",
                              style: TextStyle(fontSize: 17, letterSpacing: 0.2),
                            ),
                            Image.network(
                              "https://www.logicalincrements.com/assets/img/peripherals/screen/resolutions_1200.png",
                              height: 300,
                            ),
                          ],
                        ),*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Color(0x00ffffff),
          child: new SizedBox(
              height: 50,
              width: 15,
              child: new Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    elevation: 0,
                    color: Colors.amber[500],
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.grey[900],
                                  )),
                              new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: new Text(
                                    "WARNING: You need to restart Pangolin to apply your changes.",
                                    style: new TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: Center(
                                        child: new Text(
                                            "Are you sure you want to restart Pangolin?")),
                                    content: new Container(
                                      child: Text(
                                          "The restart will only take a few seconds but your open windows will be closed and unsaved data will be lost"),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("No"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new FlatButton(
                                        child: new Text("Yes, Restart!"),
                                        onPressed: () {
                                          Process.run(
                                              'bash', ['/dahlia/restart.sh']);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Restart",
                              style: new TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
