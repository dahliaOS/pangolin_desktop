/*

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: const Color(0xFF3f51b5),
        accentColor: const Color(0xFF3f51b5),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


@override
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}






class _MyHomePageState extends State<MyHomePage> {


  String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/login-bg.jpg"),
                  fit: BoxFit.cover,),
              ),

            ),



            new Container(
              color: const Color(0xFF000000),

              width: 1.7976931348623157e+308,
              height: 75.0,



              child: Text(_timeString),
            ),



          ],
        )
    );
  }

}




void _getTime() {
  final DateTime now = DateTime.now();
  final String formattedDateTime = _formatDateTime(now);
  setState(() {
    _timeString = formattedDateTime;
  });
}

String _formatDateTime(DateTime dateTime) {
  return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
}
}
*/

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Time Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Time Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/login-bg.jpg"),
                  fit: BoxFit.cover,),
              ),

            ),



            new Container(
              color: const Color(0xFF000000),

              width: 1.7976931348623157e+308,
              height: 75.0,



              child: Text(_timeString),
            ),



          ],
        )
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }
}*/
/*
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
      new Container(
        child:
        new Image.asset(
          'lib/images/login-bg.png',
          fit:BoxFit.fitHeight,
        ),


        alignment: Alignment.bottomCenter,
      ),

    );
  }
}*/


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pangolin Desktop',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Pangolin Desktop'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          alignment: Alignment.bottomCenter,

          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("lib/images/login-bg.png"),
                  fit: BoxFit.cover,
                ),
              ),

            ),



            new Container(

              color: Color.fromARGB(150, 0, 0, 0),
              width: 1.7976931348623157e+308,
              height: 50.0,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 13,13),

             child: Text(_timeString,

               style:
               TextStyle(fontSize: 20, color: Colors.white),),






            ),



new Container(
  alignment: Alignment.bottomLeft,
  padding: const EdgeInsets.fromLTRB(12.5 ,12.5 , 0,0),
  child: new IconButton(

    icon: const Icon(Icons.panorama_fish_eye),

    onPressed: () {
      showDialog(context: context, child:
      new AlertDialog(
        title: new Text("Apps"),
        content: new Text("no apps installed..."),
      )
      );
    },
    iconSize: 25.0,
    color: const Color(0xFFFFFFFF),
  ),
)




          ],
        )
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {

    return DateFormat('hh:mm').format(dateTime);
  }
}
