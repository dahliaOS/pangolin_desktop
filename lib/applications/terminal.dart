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
import 'dart:convert';

void main() {
  runApp(new TerminalApp());
}
class TerminalApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
        
      ),
      home: new Terminal(),
    );
  }
}



     

class Terminal extends StatefulWidget {
  Terminal({Key key}) : super(key: key);
  @override
  _TerminalState createState() => new _TerminalState();
}




void terminulll() {
    
    print('yep, you pressed it! good job');
  }


class _TerminalState extends State<Terminal> {


final myController = TextEditingController();

String output = "";
bool yourmotherisbadstreamstate = false;

Future<Process> _process = Process.start('bash', []);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

pressEnter() {
    setState(() {
        output += "\$ " + myController.text + "\n";
    });
}

updateOutput(var data) {
    setState(() {
        print(data);
        output += data;
    });
} 

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: FutureBuilder<Process>(
            future: _process,
            builder: (BuildContext context, AsyncSnapshot<Process> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                var process = snapshot.data; 
                    if (!yourmotherisbadstreamstate) {
                        process.stdout
                            .transform(utf8.decoder)
                            .listen((data) { print(data); updateOutput(data); });
                        process.stderr
                            .transform(utf8.decoder)
                            .listen((data) { print(data); updateOutput(data); });
                        yourmotherisbadstreamstate = true;
                    }
                    children = <Widget>[
                          Container(
          height: 55,
          color: Color(0xff292929),
          child: Row(children: [
          new IconButton(
            icon: const Icon(Icons.add),
            onPressed:terminulll,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
            Expanded(
                child: Center(
                    child: Text('Terminal',
                       style: TextStyle(
                            fontSize: 18, color: Color(0xffffffff))))),
            
           new IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
             process.stdin.writeln(myController.text);
             pressEnter();
            print(myController.text);},
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),

            new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:terminulll,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
          ])),
         new Expanded(child: 
         
          SingleChildScrollView(
                    padding:
                        const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                    scrollDirection: Axis.vertical,
                    child:
            new Container( 


    alignment: Alignment.topLeft,
    child: new Text(
          output,
            style: new TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            fontFamily: "Cousine"),
          ),
            ),
          ),
         
         
         ),
         new Padding(child:
          new TextFormField(
  controller: myController,
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            
            fontFamily: "Cousine",),
          decoration: InputDecoration.collapsed(hintText: "\$", hintStyle: TextStyle(fontWeight: FontWeight.w900,color: const Color(0xFFf2f2f2)),),
          autocorrect: false,
          autofocus: true,
          minLines: null,
          maxLines: null,
          
          //initialValue: "debug_shell \$",
    cursorColor: const Color(0xFFf2f2f2),
  cursorRadius: Radius.circular(0.0),
  cursorWidth: 10.0,
        ),
        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),),
    
                    ];
                } else {
                    children = <Widget>[
                    Text('lol'),
                    ];
                }
                return Column(
                    children: children,
                );
            }
        )
        
        

        
          );
      
    }
}



class RootTerminalApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Root Terminal',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new RootTerminal(),
    );
  }
}



     

class RootTerminal extends StatefulWidget {
  RootTerminal({Key key}) : super(key: key);
  @override
  _RootTerminalState createState() => new _RootTerminalState();
}



class _RootTerminalState extends State<RootTerminal> {
    
    final rootController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    rootController.dispose();
    super.dispose();
  }
    
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        backgroundColor: const Color(0xFF222222),
        body:
          
        
        
       new Column(children: [
      Container(
          height: 55,
          color: Colors.red[600],
          child: Row(children: [
          new IconButton(
            icon: const Icon(Icons.add),
            onPressed:terminulll,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
            Expanded(
                child: Center(
                    child: Text('Root Terminal',
                       style: TextStyle(
                            fontSize: 18, color: Color(0xffffffff))))),
            
            new IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed:() {
            print(rootController.text);},
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),

            new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:terminulll,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
          ])),
         new Expanded(child: 
         
          new Padding(
            child:
new TextFormField(
  controller: rootController,
   onFieldSubmitted: (_) async {
                  print(rootController.text);
                },
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            
            fontFamily: "Cousine",),
          decoration: InputDecoration.collapsed(hintText: ""),
          autocorrect: false,
          minLines: null,
          maxLines: null,
          expands: true,
          //initialValue: "debug_shell \#",
    cursorColor: Colors.red[500],
  cursorRadius: Radius.circular(0.0),
  cursorWidth: 10.0,
        ),
padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
          ),
         
         
         ),
          
    ]),        
        
        

        
          );
      
    }
}


