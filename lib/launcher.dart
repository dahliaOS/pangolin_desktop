import 'package:GeneratedApp/widgets/app_launcher.dart';
import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'dart:ui';
import 'applications/cards.dart';
import 'applications/calculator.dart';
import 'applications/editor.dart';
import 'applications/terminal.dart';
import 'settings.dart';

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
      home: launcher(title: 'Launcher'),
    );
  }
}

Column buildTile({Widget app, String icon, String label, bool appExists}) {
  return Column(
    //mainAxisSize: MainAxisSize.min,
    //mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppLauncherButton(app, icon, appExists: appExists)
          .copyWith(childWidth: 64.0, childHeight: 64.0),
//      new Image.asset(
//        icon,
//        fit: BoxFit.fill,
//        width: 64.0,
//        height: 64.0,
//      ),
      Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget tileSection = Expanded(
  child: Container(
      padding: EdgeInsets.all(10.0),
      child: GridView.count(crossAxisCount: 5, children: [
        buildTile(
            app: Terminal(),
            icon: 'lib/images/icons/v2/compiled/terminal.png',
            label: 'Terminal'),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/task.png',
            label: 'Task Manager',
            appExists: false),
        buildTile(
            app: Settings(),
            icon: 'lib/images/icons/v2/compiled/settings.png',
            label: 'Settings'),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/root.png',
            label: 'Root Terminal',
            appExists: false),
        buildTile(
            app: TextEditor(),
            icon: 'lib/images/icons/v2/compiled/notes.png',
            label: 'Notes'),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/note_mobile.png',
            label: 'Notes (mobile)',
            appExists: false),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/logs.png',
            label: 'System Logs',
            appExists: false),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/files.png',
            label: 'Files',
            appExists: false),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/disks.png',
            label: 'Disks',
            appExists: false),
        buildTile(
            app: Calculator(),
            icon: 'lib/images/icons/v2/compiled/calculator.png',
            label: 'Calculator'),
        buildTile(
            icon: 'lib/images/icons/v2/compiled/android.png',
            label: 'Android Subsystem',
            appExists: false),
      ])),
);

class launcher extends StatelessWidget {
  launcher({Key key, this.title}) : super(key: key);

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
                      new SysInfoCard(),
                      new NewsCard(),
                      new NewsCard(),
                      new NewsCard(),
                      new NewsCard(),
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
