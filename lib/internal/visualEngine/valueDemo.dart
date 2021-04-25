import 'package:flutter/material.dart';

void main() {
  runApp(ValueDemoApp());
}

class ValueDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: ValueDemoHomePage(),
    );
  }
}

class ValueDemoHomePage extends StatefulWidget {
  ValueDemoHomePage({Key? key}) : super(key: key);
  @override
  _ValueDemoHomePageState createState() => _ValueDemoHomePageState();
}

class _ValueDemoHomePageState extends State<ValueDemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
