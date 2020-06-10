import 'package:GeneratedApp/applications/calculator.dart';
import 'package:GeneratedApp/applications/editor.dart';
import 'package:GeneratedApp/applications/welcome.dart';
import 'package:GeneratedApp/applications/monitor.dart';

import 'quick_settings.dart';
import 'window_space.dart';
//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'menu.dart';
import 'themes/dynamic_theme.dart';
import 'themes/main.dart';
import 'package:flutter/services.dart';
import 'widgets/system_overlay.dart';
import 'widgets/toggle.dart';
import 'launcher_toggle.dart';
import 'status_tray.dart';
import 'app_toggle.dart';
import 'launcher.dart';
import 'window/model.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'widgets/app_launcher.dart';
import 'applications/calculator.dart';
import 'applications/editor.dart';
import 'applications/terminal.dart';
import 'settings.dart';
import 'commons/key_ring.dart';
import 'commons/functions.dart';

WindowsData provisionalWindowData = new WindowsData();
final GlobalKey<ToggleState> _launcherToggleKey = GlobalKey<ToggleState>();
final GlobalKey<SystemOverlayState> _launcherOverlayKey =
    GlobalKey<SystemOverlayState>();
final GlobalKey<ToggleState> _statusToggleKey = GlobalKey<ToggleState>();
final GlobalKey<SystemOverlayState> _statusOverlayKey =
    GlobalKey<SystemOverlayState>();
final Tween<double> _overlayScaleTween = Tween<double>(begin: 0.9, end: 1.0);
final Tween<double> _overlayOpacityTween = Tween<double>(begin: 0.0, end: 1.0);

/// Hides all overlays except [except] if applicable.
void _hideOverlays({GlobalKey<SystemOverlayState> except}) {
  <GlobalKey<SystemOverlayState>>[
    _launcherOverlayKey,
    _statusOverlayKey,
  ].where((GlobalKey<SystemOverlayState> overlay) => overlay != except).forEach(
      (GlobalKey<SystemOverlayState> overlay) =>
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

List<AppLauncherPanelButton> testLaunchers = [
  AppLauncherPanelButton(
      app: Calculator(), icon: 'lib/images/icons/v2/compiled/calculator.png'),
  AppLauncherPanelButton(
      app: TextEditor(), icon: 'lib/images/icons/v2/compiled/notes.png'),
  AppLauncherPanelButton(
      app: Terminal(), icon: 'lib/images/icons/v2/compiled/terminal.png'),
  AppLauncherPanelButton(
    icon: 'lib/images/icons/v2/compiled/files.png',
    appExists: false,
  ),
  AppLauncherPanelButton(
      app: Settings(), icon: 'lib/images/icons/v2/compiled/settings.png'),
];

void main() {
  /// To keep app in Portrait Mode
  //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Gets DahliaOS UI set up in a familiar way.
  

    return ChangeNotifierProvider<WindowsData>(
      create: (context) => provisionalWindowData,
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (Brightness brightness) => ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          brightness: brightness,
          canvasColor: Colors.black.withOpacity(0.5),
          primaryColor: const Color(0xFFff5722),
        ),
        loadBrightnessOnStart: true,
        themedWidgetBuilder: (BuildContext context, ThemeData theme) {
          return MaterialApp(
            title: 'Pangolin Desktop',
            theme: theme,
            home: MyHomePage(title: 'Pangolin Desktop'),
          );
        },
      ),
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
  final Tween<double> _overlayScaleTween = Tween<double>(begin: 0.9, end: 1.0);
  final Tween<double> _overlayOpacityTween =
      Tween<double>(begin: 0.0, end: 1.0);

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
          key: KeyRing.launcherOverlayKey,
          builder: (Animation<double> animation) => Center(
            child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) => FadeTransition(
                opacity: _overlayOpacityTween.animate(animation),
                child: ScaleTransition(
                  scale: _overlayScaleTween.animate(animation),
                  child: child,
                ),
              ),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(5.0),
                child: Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 1.7976931348623157e+308,
                    child: LauncherWidget() //Launcher(),
                    ),
              ),
            ),
          ),
          callback: (bool visible) {
            KeyRing.launcherToggleKey.currentState.toggled = visible;
          },
        ),

        // 4 - Quick settings panel
        SystemOverlay(
          key: KeyRing.statusOverlayKey,
          builder: (Animation<double> animation) => Positioned(
            right: 0.0,
            bottom: 50.0,
            child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) => FadeTransition(
                opacity: _overlayOpacityTween.animate(animation),
                child: ScaleTransition(
                  scale: _overlayScaleTween.animate(animation),
                  alignment: FractionalOffset.bottomRight,
                  child: child,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Stack(children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.75)),
                      child: QuickSettings(),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          callback: (bool visible) {
            KeyRing.statusToggleKey.currentState.toggled = visible;
          },
        ),

        // 5 - The bottom bar
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: hideOverlays,
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LauncherToggleWidget(
                          toggleKey: KeyRing.launcherToggleKey,
                          callback: toggleCallback,
                        ),
                        AppLauncherPanelButton(
                          app: Calculator(),
                          icon: 'lib/images/icons/v2/compiled/calculator.png',
                          color: Colors.green,
                          callback: toggleCallback,
                        ),
                        AppLauncherPanelButton(
                            app: TextEditor(),
                            icon: 'lib/images/icons/v2/compiled/notes.png',
                            color: Colors.deepOrange[900],
                            callback: toggleCallback),
                        AppLauncherPanelButton(
                            app: Terminal(),
                            icon: 'lib/images/icons/v2/compiled/terminal.png',
                            color: Colors.grey[900],
                            callback: toggleCallback),
                        AppLauncherPanelButton(
                            icon: 'lib/images/icons/v2/compiled/files.png',
                            appExists: false,
                            color: Colors.grey,
                            callback: toggleCallback),
                        AppLauncherPanelButton(
                          app: Tasks(),
                          icon: 'lib/images/icons/v2/compiled/task.png',
                          color: Colors.cyan[900],
                          callback: toggleCallback,
                        ),
                        AppLauncherPanelButton(
                            app: Settings(),
                            icon: 'lib/images/icons/v2/compiled/settings.png',
                            color: Colors.deepOrange,
                            callback: toggleCallback),
                        AppLauncherPanelButton(
                            app: HisApp(),
                            icon: 'lib/images/icons/v2/compiled/theme.png',
                            color: Colors.grey[900],
                            callback: toggleCallback),
                      ]),
                  StatusTrayWidget(
                    toggleKey: KeyRing.statusToggleKey,
                    callback: (bool toggled) => setOverlayVisibility(
                      overlay: KeyRing.statusOverlayKey,
                      visible: toggled,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // WallpaperPicker(),
      ],
    ));
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

//  List<Widget> wrappedLaunchers(List<AppLauncherButton> launcherList) {
//    double positionOffSet = 10.0;
//    List<Widget> list = [];
//
//    for (AppLauncherButton launcher in launcherList) {
//      list.add(Positioned.directional(
//          textDirection: TextDirection.ltr,
//          start: positionOffSet,
//          child: launcher));
//      positionOffSet += 20;
//    }
//    return list;
//  }
}
