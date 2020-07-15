/*
Copyright 2019 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:io';
import 'dart:math';

import 'package:Pangolin/applications/calculator.dart';
import 'package:Pangolin/applications/editor.dart';
import 'package:Pangolin/applications/welcome.dart';
import 'package:Pangolin/applications/monitor.dart';
import 'package:Pangolin/applications/files.dart';
import 'package:Pangolin/localization/localization.dart';
import 'package:Pangolin/settings/hiveManager.dart';
import 'package:Pangolin/widgets/blur.dart';
import 'package:Pangolin/widgets/conditionWidget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

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
import 'settings/settings.dart';
import 'commons/key_ring.dart';
import 'commons/functions.dart';

/// Set this to disable certain things during testing.
/// Use this sparingly, or better yet, not at all.
bool isTesting = false;

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
      app: TextEditorApp(), icon: 'lib/images/icons/v2/compiled/notes.png'),
  AppLauncherPanelButton(
      app: Terminal(), icon: 'lib/images/icons/v2/compiled/terminal.png'),
  AppLauncherPanelButton(
    icon: 'lib/images/icons/v2/compiled/files.png',
    appExists: false,
  ),
  AppLauncherPanelButton(
      app: Settings(), icon: 'lib/images/icons/v2/compiled/settings.png'),
];

void main() async {
  //init hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //await Hive.openBox<String>("settings");
  Pangolin.settingsBox = await Hive.openBox("settings");
  HiveManager().initializeHive();
  Pangolin.refreshTheme();

  /// To keep app in Portrait Mode
  //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(Pangolin());
}

class Pangolin extends StatefulWidget {
  @override
  _PangolinState createState() => _PangolinState();

  static void setLocale(BuildContext context, Locale locale) {
    _PangolinState state = context.findAncestorStateOfType<_PangolinState>();
    state.setLocale(locale);
  }

  static Box<dynamic> settingsBox;
  static Locale locale;
  static ThemeData theme;

  static List<String> wallpapers = [
    "lib/images/Desktop/Dahlia/forest.jpg",
    "lib/images/Desktop/Dahlia/Brick-Wall.jpg",
    "lib/images/Desktop/Dahlia/dahlia_material_background.jpg",
    "lib/images/Desktop/Dahlia/dahlia_material_background-1.jpg",
    "lib/images/Desktop/Dahlia/Mountain.jpg",
    "lib/images/Desktop/Dahlia/Sunset.png",
  ];

  static refreshTheme() {
    Pangolin.theme = (Pangolin.settingsBox.get("darkMode") == null
            ? ThemeData.dark()
            : ThemeData.light())
        .copyWith(
            primaryColor: Color(Pangolin.settingsBox.get("accentColorValue") ??
                Colors.deepOrangeAccent[700].value),
            accentColor: Color(Pangolin.settingsBox.get("accentColorValue") ??
                Colors.deepOrangeAccent[700].value),
            appBarTheme: AppBarTheme(
              color: Pangolin.settingsBox.get("darkMode") == null
                  ? ThemeData.dark().cardColor
                  : null,
            )
            //TODO: add Twemoji, Roboto fonts
            );
  }
}

class _PangolinState extends State<Pangolin> {
  @override
  void initState() {
    List<String> language = ["en", "US"];
    getLangFromHive() {
      if (Pangolin.settingsBox.get("language") == null) {
        language = ["en", "US"];
      } else {
        language = Pangolin.settingsBox.get("language").split("_");
      }
    }

    getLangFromHive();

    Pangolin.locale = Locale(language[0], language[1]);
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      Pangolin.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Gets DahliaOS UI set up in a familiar way.
    return ChangeNotifierProvider<WindowsData>(
        create: (context) => provisionalWindowData,
        child: DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (Brightness brightness) => ThemeData(
                  sliderTheme: SliderThemeData(
                    activeTickMarkColor:
                        Color(HiveManager().get("accentColorValue")),
                    thumbColor: Color(HiveManager().get("accentColorValue")),
                    activeTrackColor:
                        Color(HiveManager().get("accentColorValue")),
                    inactiveTrackColor:
                        Color(HiveManager().get("accentColorValue"))
                            .withAlpha(90),
                    inactiveTickMarkColor:
                        Color(HiveManager().get("accentColorValue")),
                  ),
                  accentColor: Color(HiveManager().get("accentColorValue")),
                  brightness: brightness,
                  canvasColor: Colors.black.withOpacity(0.5),
                  primaryColor: Color(HiveManager().get("accentColorValue")),
                ),
            loadBrightnessOnStart: true,
            themedWidgetBuilder: (BuildContext context, ThemeData theme) {
              return MaterialApp(
                title: 'Pangolin Desktop',
                theme: theme,
                home: MyHomePage(title: 'Pangolin Desktop'),
                supportedLocales: [
                  Locale("en", "US"),
                  Locale("de", "DE"),
                  Locale("fr", "FR"),
                  Locale("pl", "PL"),
                  Locale("hr", "HR"),
                  Locale("nl", "BE"),
                  Locale("nl", "NL"),
                ],
                localizationsDelegates: [
                  Localization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Pangolin.locale,
              );
            }));
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
    final _random = new Random();
    return Scaffold(
        body: Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        // 1 - Desktop background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(HiveManager().get("randomWallpaper")
                  ? Pangolin
                      .wallpapers[_random.nextInt(Pangolin.wallpapers.length)]
                  : "lib/images/Desktop/Dahlia/forest.jpg"),
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
                child: SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(animation),
                  child: child,
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                  width: 1.7976931348623157e+308,
                  height: 1.7976931348623157e+308,
                  child: LauncherWidget() //Launcher(),
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
            right: 5.0,
            bottom: 55.0,
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
              child: Blur(
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
          //change below values to 15 or something to give it a starlight-like look
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: hideOverlays,
            child: Blur(
                child: Container(
                    //color: Color.fromARGB(150, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(150, 0, 0, 0),
                      //uncomment below to add radius to the launcher panel
                      //borderRadius: BorderRadius.circular(100),
                    ),
                    height: 50.0,
                    padding: const EdgeInsets.all(8.0),
                    child: CustomConditionWidget(
                      HiveManager().get("centerTaskbar"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LauncherToggleWidget(
                            toggleKey: KeyRing.launcherToggleKey,
                            callback: toggleCallback,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AppLauncherPanelButton(
                                      app: Calculator(),
                                      icon:
                                          'lib/images/icons/v2/compiled/calculator.png',
                                      callback: toggleCallback,
                                    ),
                                    AppLauncherPanelButton(
                                        app: TextEditorApp(),
                                        icon:
                                            'lib/images/icons/v2/compiled/notes.png',
                                        callback: toggleCallback),
                                    AppLauncherPanelButton(
                                        app: Terminal(),
                                        icon:
                                            'lib/images/icons/v2/compiled/terminal.png',
                                        callback: toggleCallback),
                                    AppLauncherPanelButton(
                                        app: Files(),
                                        icon:
                                            'lib/images/icons/v2/compiled/files.png',
                                        callback: toggleCallback),
                                    AppLauncherPanelButton(
                                      app: Tasks(),
                                      icon:
                                          'lib/images/icons/v2/compiled/task.png',
                                      callback: toggleCallback,
                                    ),
                                    AppLauncherPanelButton(
                                        app: Settings(),
                                        icon:
                                            'lib/images/icons/v2/compiled/settings.png',
                                        callback: toggleCallback),
                                    AppLauncherPanelButton(
                                        app: HisApp(),
                                        icon:
                                            'lib/images/icons/v2/compiled/theme.png',
                                        callback: toggleCallback),
                                  ]),
                            ],
                          ),
                          StatusTrayWidget(
                            toggleKey: KeyRing.statusToggleKey,
                            callback: (bool toggled) => setOverlayVisibility(
                              overlay: KeyRing.statusOverlayKey,
                              visible: toggled,
                            ),
                          ),
                        ],
                      ),
                      Row(
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
                                  icon:
                                      'lib/images/icons/v2/compiled/calculator.png',
                                  callback: toggleCallback,
                                ),
                                AppLauncherPanelButton(
                                    app: TextEditorApp(),
                                    icon:
                                        'lib/images/icons/v2/compiled/notes.png',
                                    callback: toggleCallback),
                                AppLauncherPanelButton(
                                    app: Terminal(),
                                    icon:
                                        'lib/images/icons/v2/compiled/terminal.png',
                                    callback: toggleCallback),
                                AppLauncherPanelButton(
                                    app: Files(),
                                    icon:
                                        'lib/images/icons/v2/compiled/files.png',
                                    callback: toggleCallback),
                                AppLauncherPanelButton(
                                  app: Tasks(),
                                  icon: 'lib/images/icons/v2/compiled/task.png',
                                  callback: toggleCallback,
                                ),
                                AppLauncherPanelButton(
                                    app: Settings(),
                                    icon:
                                        'lib/images/icons/v2/compiled/settings.png',
                                    callback: toggleCallback),
                                AppLauncherPanelButton(
                                    app: HisApp(),
                                    icon:
                                        'lib/images/icons/v2/compiled/theme.png',
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
                    ))),
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
