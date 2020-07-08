import 'package:flutter/material.dart';

void main() {
  runApp(new Logs());
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LogsPage(),
    );
  }
}

class LogsPage extends StatefulWidget {
  LogsPage({Key key}) : super(key: key);
  @override
  _LogsPageState createState() => new _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),
      ),
    );
  }
}
