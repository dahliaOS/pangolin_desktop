import 'package:flutter/material.dart';

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

class _TextEditorState extends State<TextEditor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: TextField(
          style: Theme.of(context).textTheme.display1,
          minLines: null,
          maxLines: null,
          expands: true,
        ),
      ),
    );
  }
}
