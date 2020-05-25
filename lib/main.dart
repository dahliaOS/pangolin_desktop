import 'quick_settings.dart';
import 'window_space.dart';
//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'menu.dart';
import 'themes/dynamic_theme.dart';
import 'themes/theme_switcher_widgets.dart';
import 'package:flutter/services.dart';
import 'widgets/system_overlay.dart';
import 'quick_settings.dart';
import 'widgets/toggle.dart';
import 'launcher_toggle.dart';
import 'status_tray.dart';
import 'app_toggle.dart';
import 'launcher.dart';

import 'dart:ui';


void main()  {
  /// To keep app in Portrait Mode
  //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        brightness: brightness,
      ),
      loadBrightnessOnStart: true,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'Pangolin Desktop',
          theme: theme,
          home: MyHomePage(title: 'Pangolin Desktop'),
        );
      },
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
  //String _timeString;

  /*@override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            // 1 - Desktop background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/Desktop/Dahlia/forest.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2 - Example usage of windows widgets
            WindowPlaygroundWidget(),
            /*Window(
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
            ),*/

            // 3 - Launcher Panel
            SystemOverlay(
              key: _launcherOverlayKey,
              builder: (Animation<double> animation) => Center(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) =>
                  FadeTransition(
                    
                    opacity: _overlayOpacityTween.animate(animation),
                    child: ScaleTransition(
                      scale: _overlayScaleTween.animate(animation),
                      child: child,
                    ),
                  ),
                  child:new ClipRRect(
                    
  //borderRadius: BorderRadius.circular(5.0),
                  child:new Container(
            padding: const EdgeInsets.all(0.0),
                    
            alignment: Alignment.center,
            width: 1.7976931348623157e+308,
            height: 1.7976931348623157e+308,
            child: LauncherWidget()//Launcher(),
          ),
          ),
                  
                ),
              ),
              callback: (bool visible) {
                _launcherToggleKey.currentState.toggled = visible;
              },
            ),

            // 4 - Quick settings panel
            SystemOverlay(
              key: _statusOverlayKey,
              builder: (Animation<double> animation) => Positioned(
                right: 0.0,
                bottom: 50.0,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) =>
                  FadeTransition(
                    opacity: _overlayOpacityTween.animate(animation),
                    child: ScaleTransition(
                      scale: _overlayScaleTween.animate(animation),
                      alignment: FractionalOffset.bottomRight,
                      child: child,
                    ),
                  ),
                  child:
                  
                   new ClipRRect(
                    
  borderRadius: BorderRadius.circular(5.0),
  
  child: 
  
  
  new Stack(
      children: [
         new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.75)),
            child: new QuickSettings(),
          ),
        ),
      ]
      ),

  ),
                  
                  
                ),
              ),
              callback: (bool visible) {
                _statusToggleKey.currentState.toggled = visible;
              },
            ),

            // 5 - The bottom bar
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _hideOverlays,
                child: Container(
                  //color: Color.fromARGB(150, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        
                     
                       

                   new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


   
                      LauncherToggleWidget(
                        toggleKey: _launcherToggleKey,
                        callback: (bool toggled) => _setOverlayVisibility(
                            overlay: _launcherOverlayKey,
                            visible: toggled,
                        ),
                        
                      ),



              new Image.asset(
            'lib/images/icons/v2/compiled/calculator.png',
            fit:BoxFit.contain,
            width: 60.0, 
            height: 60.0,
            ),


            new Image.asset(
            'lib/images/icons/v2/compiled/notes.png',
            fit:BoxFit.contain,
            width: 60.0, 
            height: 60.0,
            ),
                
                
                new Image.asset(
            'lib/images/icons/v2/compiled/terminal.png',
            fit:BoxFit.contain,
            width: 60.0, 
            height: 60.0,
            ),


                
                new Image.asset(
            'lib/images/icons/v2/compiled/files.png',
            fit:BoxFit.contain,
            width: 60.0, 
            height: 60.0,
            ),
                
                
                
                new Image.asset(
            'lib/images/icons/v2/compiled/settings.png',
            fit:BoxFit.contain,
            width: 60.0, 
            height: 60.0,
            ),
                


            ]
    
          ),
                        
                        
                      StatusTrayWidget(
                        toggleKey: _statusToggleKey,
                        callback: (bool toggled) => _setOverlayVisibility(
                            overlay: _statusOverlayKey,
                            visible: toggled,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


   // new WallpaperPicker(),

          ],
        )
    );
  }

  /*void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {

    return DateFormat('hh:mm').format(dateTime);
  }*/
  /// Hides all overlays except [except] if applicable.
  void _hideOverlays({GlobalKey<SystemOverlayState> except}) {
    <GlobalKey<SystemOverlayState>>[
      _launcherOverlayKey,
      _statusOverlayKey,
    ]
        .where((GlobalKey<SystemOverlayState> overlay) => overlay != except)
        .forEach((GlobalKey<SystemOverlayState> overlay) =>
    overlay.currentState.visible = false);
  }

  /// Sets the given [overlay]'s visibility to [visible].
  /// When showing an overlay, this also hides every other overlay.
  void _setOverlayVisibility({
    @required GlobalKey<SystemOverlayState> overlay,
    @required bool visible,
  }) {
    if (visible) {
      _hideOverlays(except: overlay);
    }
    overlay.currentState.visible = visible;
  }
}
















