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
          color: Color(0xff292929),
          child: Row(children: [
          new IconButton(
            icon: const Icon(Icons.add),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
            Expanded(
                child: Center(
                    child: Text('Terminal',
                       style: TextStyle(
                            fontSize: 18, color: Color(0xffffffff))))),
            
            new IconButton(
            icon: const Icon(Icons.settings),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),

            new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:textButtonNull,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ),
          ])),
         new Expanded(child: 
         
          new Padding(
            child:
new TextFormField(
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            
            fontFamily: "Cousine",),
          decoration: InputDecoration.collapsed(hintText: ""),
          autocorrect: false,
          minLines: null,
          maxLines: null,
          expands: true,
          initialValue: "debug_shell \$",
    cursorColor: const Color(0xFFf2f2f2),
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
