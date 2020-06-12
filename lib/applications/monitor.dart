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

/*import 'package:flutter/material.dart';

class MonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: 
        
        new Column(children: [

 Container(
            height: 45,
            color: Color(0xff00838f),
            child: Row(children: [
              new Expanded(child: 
              new Container(
                  width: 256,
                  child: Row(children: [
                    new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 10, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('PROCESSES',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),

                new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 5, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('RESOURCES',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),




                                    new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 5, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('CONTAINERS',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),
                
                
                  ])),),
              
             new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:null,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ), 
             
            ])),

new Expanded(child: new Row(children: [






],),)


        ],)
       );
  }
}

void main() {
  runApp(new Tasks());
}
class Tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);
  @override
  _TasksState createState() => new _TasksState();
}

class _TasksState extends State<TasksPage> {
    @override
    Widget build(BuildContext context) {
      return new MonitorApp();
    }
}

*/

import 'package:flutter/material.dart';

void main() {
  runApp(new Tasks());
}

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Task Manager',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        canvasColor: const Color(0xFFfffffff),
      ),
      home: new TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);
  @override
  _TasksState createState() => new _TasksState();
}

class _TasksState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(52.0), // here the desired height
            child: AppBar(
              backgroundColor: Color(0xff00838f),
              elevation: 0,
              bottom: TabBar(
                  labelColor: Color(0xFF222222),
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: Colors.white),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("PROCESSES"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("RESOURCES"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("CONTAINERS"),
                      ),
                    ),
                  ]),
            ),
          ),
          body: TabBarView(children: [
            new Process(),
            Icon(Icons.movie),
            Icon(Icons.games),
          ]),
        ));
  }
}

Container buildProcess(String icon, String name) {
  return new Container(
    padding: const EdgeInsets.only(
      top: 25,
      left: 15,
    ),
    alignment: Alignment.centerLeft,
    child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            icon,
            fit: BoxFit.fill,
            width: 30.0,
            height: 30.0,
          ),
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Text(
              name,
              style: new TextStyle(
                  fontSize: 15.0,
                  color: const Color(0xFF000000),
                  fontFamily: "Roboto"),
            ),
          ),
        ]),
  );
}

class Process extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      Expanded(
        child: Container(
          color: Color(0xffeeeeee),
          margin: EdgeInsets.all(10),
          child: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
              children: [
                buildProcess('lib/images/icons/v2/compiled/calculator.png',
                    'Calculator'),
                buildProcess('lib/images/icons/v2/compiled/disks.png', 'Disks'),
                buildProcess('lib/images/icons/v2/compiled/files.png', 'Files'),
                buildProcess('lib/images/icons/v2/compiled/logs.png', 'Logs'),
                buildProcess('lib/images/icons/v2/compiled/note_mobile.png',
                    'Notes (Mobile)'),
                buildProcess('lib/images/icons/v2/compiled/notes.png', 'Notes'),
                buildProcess(
                    'lib/images/icons/v2/compiled/root.png', 'Root Terminal'),
                buildProcess(
                    'lib/images/icons/v2/compiled/settings.png', 'Settings'),
                buildProcess(
                    'lib/images/icons/v2/compiled/task.png', 'Task Manager'),
                buildProcess(
                    'lib/images/icons/v2/compiled/terminal.png', 'Terminal'),
                buildProcess(
                    'lib/images/icons/v2/compiled/theme.png', 'Theme Demo'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
                buildProcess('lib/images/icons/v2/compiled/android.png',
                    'Android Subsystem'),
              ],
            ),
          ),
        ),
      ),
      Container(
        width: 300,
        color: Color(0x0),
        child: new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Column(
              children: [
                new Image.asset(
                  'lib/images/icons/v2/compiled/grey-drag.png',
                  fit: BoxFit.fill,
                  width: 64.0,
                  height: 64.0,
                ),
                //
                new Text(
                  "Select a process to view stats and manage functionality.",
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: const Color(0xFF000000),
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.center,
                ),
                new Text(
                  "io.dahliaos.null",
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: const Color(0xFF000000),
                      fontFamily: "Roboto"),
                ),
                new Text(
                  "null",
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: const Color(0xFF000000),
                      fontFamily: "Roboto"),
                ),
                new RaisedButton(
                    key: null,
                    onPressed: null,
                    color: Colors.cyan[800],
                    child: new Text(
                      "LAUNCH",
                    )),
                new RaisedButton(
                    key: null,
                    onPressed: null,
                    color: Colors.cyan[800],
                    child: new Text(
                      "ABOUT",
                    )),
                new RaisedButton(
                    key: null,
                    onPressed: null,
                    color: Colors.red,
                    child: new Text(
                      "KILL",
                    )),
              ],
            )),
      )
    ]));
  }
}
