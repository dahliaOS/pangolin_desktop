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

import 'package:Pangolin/utils/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                "About Device",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              )),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 100,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage(
                      "assets/images/dahliaOS/Logos/compiled/dahliaOS_logo_drop_shadow.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "dahliaOS",
                style: TextStyle(fontSize: 35),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Version",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Version 200830")]),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Kernel",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Linux Kernel 5.7.19")]),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Pangolin Version",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Version v200917")]),
                SizedBox(height: 20),
              ]),
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
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Row(
                        children: [
                          new Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.grey[900],
                                  ))),
                          Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: new Text(
                                    "WARNING: You are on a pre-release build of dahliaOS. Some settings don't work yet.",
                                    style: new TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  )))),
    );
  }
}
