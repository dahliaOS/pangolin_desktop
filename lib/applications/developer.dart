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
import 'dart:io';

void main() {
  runApp(new DeveloperApp());
}
class DeveloperApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFf44336),
        accentColor: const Color(0xFFf44336),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new DeveloperAppPage(),
    );
  }
}

class DeveloperAppPage extends StatefulWidget {
  DeveloperAppPage({Key key}) : super(key: key);
  @override
  _DeveloperAppPageState createState() => new _DeveloperAppPageState();
}

class _DeveloperAppPageState extends State<DeveloperAppPage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Developer Options (Linux)'),
          ),
          body:
          new Center(child: 
           Column(children: [
             Text("Warning: These options are intended only for development purposes. If something goes seriously wrong when using these, hold down the power button for 5-10 seconds to force a shutdown."),
      RaisedButton(onPressed: (){Process.run('reboot', [' ']);},
      child: Text('Reboot')),
      RaisedButton(onPressed:(){Process.run('shutdown', ['-h','now']);},
      child: Text('Shutdown')),
      RaisedButton(onPressed:(){Process.run('killall', ['pangolin_desktop']);},
        child: Text('Enter commandline mode')),
      Text('DANGEROUS OPTIONS!!!!'),
    RaisedButton(
      onPressed:(){Process.run('echo', ['c','>','/proc/sysrq-trigger']);},child: Text('Induce Kernel Panic')),
      RaisedButton(
        onPressed:(){Process.run(':(){ :|:& };', ['']);},child: Text('Execute Fork Bomb')),
   
    ]

          
          ,
      ),));
    }
}


/*import 'package:flutter/material.dart';

class Desktop extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(4293848814),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                              color: Colors.grey[500],
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 40.0,
              child: ListTile(
                title: Text(
                  "Enable Developer Options",
                  style: new TextStyle(
                      color: const Color(0xFF000000), fontFamily: "Roboto"),
                ),
                trailing: Switch(onChanged: switchChanged, value: true),
              ),
            ),
//              new Container(
//                child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      new Text(
//                        "Enable Developer Options",
//                        style: new TextStyle(
//                            color: const Color(0xFF000000),
//                            fontFamily: "Roboto"),
//                      ),
//                      new Switch(onChanged: switchChanged, value: true)
//                    ]),
//                color: Colors.grey[500],
//                padding: const EdgeInsets.all(0.0),
//                alignment: Alignment.center,
//                width: 1.7976931348623157e+308,
//                height: 40.0,
//              ),
          ],
        ),
        appBar: AppBar(
            backgroundColor: Colors.red[700],
            title: Text('Developer Options', style: TextStyle()),
            leading: Center(child: Icon(Icons.warning),),),);
  }
}

void switchChanged(bool value) {}*/
