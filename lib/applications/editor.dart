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

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Editor',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: TextEditor(),
    );
  }
}

class TextEditor extends StatefulWidget {

  final String title="Text Editor";

  @override
  _TextEditorState createState() => _TextEditorState();
}

void textButtonNull() {
    
    print('yep, you pressed it! good job');
  }

class _TextEditorState extends State<TextEditor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        
       new Column(children: [
      Container(
          height: 55,
          color: Colors.amber[500],
          child: Row(children: [
          new IconButton(
            icon: const Icon(Icons.add),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFF222222),
          ),
            Expanded(
                child: Center(
                    child: Text('Notes',
                       style: TextStyle(
                            fontSize: 18, color: Color(0xff222222))))),
            
            new IconButton(
            icon: const Icon(Icons.save),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFF222222),
          ),

            new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFF222222),
          ),
          ])),
         new Expanded(child: 
         
          new Padding(
            child:
new TextFormField(
    onChanged: (text) {
    print("First text field: $text");
  },
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFF222222),
            
            fontFamily: "Roboto",),
          decoration: InputDecoration.collapsed(hintText: ""),
          autocorrect: false,
          minLines: null,
          maxLines: null,
          expands: true,
          
    cursorColor: const Color(0xFF222222),
        ),
padding: const EdgeInsets.fromLTRB(100.0, 2.0, 100.0, 2.0),
          ),
         
         
         ),
          
    ]),        
    );
  }
}
