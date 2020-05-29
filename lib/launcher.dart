import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'dart:ui';
import 'applications/cards.dart';

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

Column buildTile(String icon, String label) {
  return Column(
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
     constraints: BoxConstraints(maxWidth: 900),
      padding: EdgeInsets.all(10.0),
      child: GridView.count(crossAxisCount: 5, children: [
        buildTile('lib/images/icons/v2/compiled/terminal.png', 'Terminal'),
        buildTile('lib/images/icons/v2/compiled/task.png', 'Task Manager'),
        buildTile('lib/images/icons/v2/compiled/settings.png', 'Settings'),
        buildTile('lib/images/icons/v2/compiled/root.png', 'Root Terminal'),
        buildTile('lib/images/icons/v2/compiled/notes.png', 'Notes'),
        buildTile('lib/images/icons/v2/compiled/note_mobile.png', 'Notes (mobile)'),
        buildTile('lib/images/icons/v2/compiled/logs.png', 'System Logs'),
        buildTile('lib/images/icons/v2/compiled/files.png', 'Files'),
        buildTile('lib/images/icons/v2/compiled/disks.png', 'Disks'),
        buildTile('lib/images/icons/v2/compiled/calculator.png', 'Calculator'),
        buildTile('lib/images/icons/v2/compiled/android.png', 'Android Subsystem'),
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
                      buildCard(Icons.brightness_low, 'System', Colors.deepOrange, Colors.deepOrange.withAlpha(30), 'Welcome to dahliaOS!'),
                       buildCard(Icons.info, 'Information', Colors.blue, Colors.blue.withAlpha(30), 'You are on a pre-release development build!'),
                        buildCard(Icons.music_note, 'Music - Now Playing', Colors.lightGreen, Colors.lightGreen.withAlpha(30), 'Powerhouse of the Sell - The Revival'),
                         buildCard(Icons.lock, 'Security', Colors.red, Colors.red.withAlpha(30), 'Filesystem lock is ON'),
                      buildCard(Icons.memory, 'Kernel', Colors.pink, Colors.pink.withAlpha(30), 'Drivers for Integrated GPU updated'),
                         
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
