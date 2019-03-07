

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
                  image: new AssetImage("lib/images/def.png"),
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


   // new WallpaperPicker(),

new Container(
  alignment: Alignment.bottomLeft,
  padding: const EdgeInsets.fromLTRB(12.5 ,12.5 , 0,0),
  child: new IconButton(

    icon: const Icon(Icons.panorama_fish_eye),

    onPressed: () {
      showDialog(
          context: context,
          builder: (_) => Center( // Aligns the container to center
              child: Container( // A simplified version of dialog.
                width: 600,
                height: 400,
                color: Colors.white,
                child:
                new AppMenu()
                ,
              )
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
