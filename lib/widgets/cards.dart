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
            icon: 'lib/images/icons/v2/compiled/root.png',
            label: 'Root Terminal',
            appExists: false),
        AppLauncherDrawerButton(
            app: TextEditor(),
            icon: 'lib/images/icons/v2/compiled/notes.png',
            label: 'Notes',
            color: Colors.deepOrange,
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
