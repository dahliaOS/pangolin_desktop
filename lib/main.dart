import 'window.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'menu.dart';
import 'package:flutter/services.dart';
import 'system_overlay.dart';
import 'quick_settings.dart';
import 'toggle.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pangolin Desktop',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        canvasColor: const Color(0xFFEEEEEE),
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
  final GlobalKey<ToggleState> _launcherToggleKey = new GlobalKey<ToggleState>();
  final GlobalKey<SystemOverlayState> _launcherOverlayKey = GlobalKey<SystemOverlayState>();
  final GlobalKey<ToggleState> _statusToggleKey = new GlobalKey<ToggleState>();
  final GlobalKey<SystemOverlayState> _statusOverlayKey = new GlobalKey<SystemOverlayState>();
  final Tween<double> _overlayScaleTween = new Tween<double>(begin: 0.9, end: 1.0);
  final Tween<double> _overlayOpacityTween = new Tween<double>(begin: 0.0, end: 1.0);
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

            // Example usage of windows widget
            Window(
              initialPosition: Offset.fromDirection(350.0,-40.0),
              initialSize: Size(355,628),
              child: Container(
                color: Colors.deepOrange[200],
              ),
              color: Colors.deepOrange
            ),
            Window(
              initialPosition: Offset.fromDirection(350.0,-40.0),
              initialSize: Size(355,628),
              child: Container(color: Colors.deepPurple[200]),
              color: Colors.deepPurple //Calculator(),
            ),

            // Launcher Panel
            new SystemOverlay(
              key: _launcherOverlayKey,
              builder: (Animation<double> animation) => new Center(
                child: new AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) =>
                  new FadeTransition(
                    opacity: _overlayOpacityTween.animate(animation),
                    child: new ScaleTransition(
                      scale: _overlayScaleTween.animate(animation),
                      child: child,
                    ),
                  ),
                  child: AppMenu()//Launcher(),
                ),
              ),
              callback: (bool visible) {
                _launcherToggleKey.currentState.toggled = visible;
              },
            ),

            // Quick settings panel
            new SystemOverlay(
              key: _statusOverlayKey,
              builder: (Animation<double> animation) => new Positioned(
                right: 0.0,
                bottom: 48.0,
                child: new AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) =>
                  new FadeTransition(
                    opacity: _overlayOpacityTween.animate(animation),
                    child: new ScaleTransition(
                      scale: _overlayScaleTween.animate(animation),
                      alignment: FractionalOffset.bottomRight,
                      child: child,
                    ),
                  ),
                  child: QuickSettings(),
                ),
              ),
              callback: (bool visible) {
                _statusToggleKey.currentState.toggled = visible;
              },
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
      SystemChrome.setEnabledSystemUIOverlays([]);

      showDialog(


          context: context,

          builder: (_) => Center( // Aligns the container to center

              child: AppMenu()
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
