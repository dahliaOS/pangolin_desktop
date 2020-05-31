import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'dart:ui';
import 'applications/cards.dart';
import 'widgets/app_launcher.dart';

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
      home: Launcher(title: 'Launcher'),
    );
  }
}

class Launcher extends StatelessWidget {
  Launcher({Key key, this.title}) : super(key: key);

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
