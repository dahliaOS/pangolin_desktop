import 'package:flutter/material.dart';

void main() {
  runApp(new ValueDemoApp());
}

class ValueDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new ValueDemoHomePage(),
    );
  }
}

class ValueDemoHomePage extends StatefulWidget {
  ValueDemoHomePage({Key? key}) : super(key: key);
  @override
  _ValueDemoHomePageState createState() => new _ValueDemoHomePageState();
}

class _ValueDemoHomePageState extends State<ValueDemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
