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
import '../applications/calculator.dart';
import '../applications/editor.dart';
import '../applications/terminal.dart';
import '../settings.dart';
import '../applications/monitor.dart';
import 'package:GeneratedApp/widgets/app_launcher.dart';
import 'package:GeneratedApp/applications/welcome.dart';
import 'package:GeneratedApp/themes/main.dart';
import 'package:GeneratedApp/commons/key_ring.dart';
import 'package:GeneratedApp/commons/functions.dart';

Widget tileSection = Expanded(
  child: Container(
      constraints: BoxConstraints(maxWidth: 900),
      padding: EdgeInsets.all(10.0),
      child: GridView.count(crossAxisCount: 5, children: [
        AppLauncherDrawerButton(
          app: Terminal(),
          icon: 'lib/images/icons/v2/compiled/terminal.png',
          label: 'Terminal',
          color: Colors.grey[900],
          callback: toggleCallback,
        ),
        AppLauncherDrawerButton(
          app: Tasks(),
          icon: 'lib/images/icons/v2/compiled/task.png',
          label: 'Task Manager',
          color: Colors.cyan[900],
          callback: toggleCallback,
        ),
        AppLauncherDrawerButton(
            app: Settings(),
            icon: 'lib/images/icons/v2/compiled/settings.png',
            label: 'Settings',
            color: Colors.deepOrange,
            callback: toggleCallback),
        AppLauncherDrawerButton(
            app: RootTerminal(),
            icon: 'lib/images/icons/v2/compiled/root.png',
            label: 'Root Terminal',
           color: Colors.red[700],
            callback: toggleCallback),
        AppLauncherDrawerButton(
            app: TextEditorApp(),
            icon: 'lib/images/icons/v2/compiled/notes.png',
            label: 'Notes',
            color: Colors.amber[700],
            callback: toggleCallback),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/note_mobile.png',
            label: 'Notes (mobile)',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/logs.png',
            label: 'System Logs',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/files.png',
            label: 'Files',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/disks.png',
            label: 'Disks',
            appExists: false),
        AppLauncherDrawerButton(
            app: Calculator(),
            icon: 'lib/images/icons/v2/compiled/calculator.png',
            label: 'Calculator',
            color: Colors.green,
            callback: toggleCallback),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/android.png',
            label: 'Android Subsystem',
            appExists: false),
        AppLauncherDrawerButton(
            app: HisApp(),
            icon: 'lib/images/icons/v2/compiled/theme.png',
            label: 'Theme Demo',
            color: Colors.grey[900],
            callback: toggleCallback),
        AppLauncherDrawerButton(
            app: Welcome(),
            icon: 'lib/images/dahlia.png',
            label: 'Welcome',
            color: Colors.grey[900],
            callback: toggleCallback),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/clock.png',
            label: 'Clock',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/messages.png',
            label: 'Messages',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/music.png',
            label: 'Music',
            appExists: false),
        AppLauncherDrawerButton(
            icon: 'lib/images/icons/v2/compiled/photos.png',
            label: 'Media',
            appExists: false),








      ])),
);

class SysInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Feature not implemented"),
                content: new Text(
                    "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 300,
          height: 100,
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.info, color: Colors.blue, size: 20.0),
                        new Text(
                          " " + "System Information",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        )
                      ]),
                  new Text(
                    "pangolin-desktop, commit 'varCommit'",
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        splashColor: Colors.deepOrange.withAlpha(30),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Feature not implemented"),
                content: new Text(
                    "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 300,
          height: 100,
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.speaker_notes,
                            color: Colors.deepOrange, size: 20.0),
                        new Text(
                          " " + "News",
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        )
                      ]),
                  new Text(
                    "UNABLE TO PARSE JSON!!!",
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

Card buildCard(IconData icon, String title, Color color, Color splash,
    String text, BuildContext context) {
  return new Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: InkWell(
      splashColor: splash,
      onTap: () {
        showDialog(
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Feature not implemented"),
              content: new Text(
                  "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
          context: context,
        );
      },
      child: Container(
        width: 300,
        height: 100,
        child: new Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(icon, color: color, size: 20.0),
                      new Text(
                        " " + title,
                        style: new TextStyle(
                            fontSize: 15.0,
                            color: color,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      )
                    ]),
                new Text(
                  text,
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                )
              ]),
        ),
      ),
    ),
  );
}
