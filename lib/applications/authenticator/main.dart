import 'package:flutter/material.dart';

void main() {
  runApp(new AuthApp());
}

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Authenticator',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color(0xFF607d8b),
        accentColor: const Color(0xFF607d8b),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new AuthHomePage(),
    );
  }
}

class AuthHomePage extends StatefulWidget {
  AuthHomePage({Key key}) : super(key: key);
  @override
  _AuthHomePageState createState() => new _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),
      ),
    );
  }
}
