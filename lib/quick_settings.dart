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

import 'dart:ui';
import 'dart:io';
import 'package:GeneratedApp/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'commons/functions.dart';
import 'main.dart';
import 'themes/dynamic_theme.dart';

class QuickSettings extends StatefulWidget {
  @override
  QuickSettingsState createState() => QuickSettingsState();
}

class QuickSettingsState extends State<QuickSettings> {
  double brightness = 0.8;
  double volume = 0.5;

  String _dateString;
  String _timeString;

  @override
  void initState() {
    super.initState();
    Pangolin.settingsBox = Hive.box("settings");
    _timeString = _formatDateTime(DateTime.now(), 'hh:mm');
    _dateString = _formatDateTime(DateTime.now(), 'E, d MMMM yyyy');
    if (!isTesting)
      Timer.periodic(
          Duration(milliseconds: 100), (Timer t) => _getTime(context));
    else
      print("WARNING: Clock was disabled due to testing flag!");
  }

  void _getTime(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now, 'hh:mm');
    final String formattedDate = _formatLocaleDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  //Default date format
  String _formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }

  //Format date using language
  String _formatLocaleDate(DateTime dateTime) {
    return DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
        .format(dateTime);
  }

  MaterialButton buildPowerItem(
      IconData icon, String label, String function, String subARG) {
    return MaterialButton(
      onPressed: () {
        Process.run(
          function,
          [subARG],
        );
      },
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey[900],
            size: scale(25.0),
            semanticLabel: 'Power off',
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: scale(15.0),
                color: Colors.grey[900],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Localization local = Localization.of(context);
    _getTime(context);
    var biggerFont = TextStyle(
      fontSize: scale(15.0),
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
    Widget topSection = Container(
      padding: EdgeInsets.all(scale(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Expanded(
            child:*/
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scale(8.0)),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_timeString, style: biggerFont),
                      //Icon(Icons.brightness_1, size: 10.0,color: Colors.white),
                      Text('  •  ', style: biggerFont),
                      Text(_dateString, style: biggerFont),
                    ],
                  )),
            ),
          ),
          //Spacer(),
          //),
          new IconButton(
            icon: Icon(
              Icons.power_settings_new,
              size: scale(24.0),
            ),
            onPressed: () {
              showGeneralDialog(
                barrierLabel: "Barrier",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 120),
                context: context,
                pageBuilder: (_, __, ___) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: scale(90),
                      width: scale(400),
                      child: SizedBox.expand(
                        child: new Center(
                            child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(Icons.power_settings_new,
                                  'Power off', 'poweroff', '-f'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(
                                  Icons.refresh, 'Restart', 'reboot', ''),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: scale(20.0), right: scale(20)),
                              child: buildPowerItem(Icons.developer_mode,
                                  'Terminal', 'killall', 'pangolin_desktop'),
                            ),
                          ],
                        )),
                      ),
                      margin: EdgeInsets.only(
                          bottom: scale(75), left: scale(12), right: scale(12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                transitionBuilder: (_, anim, __, child) {
                  return FadeTransition(
                    opacity: anim,
                    child: child,
                  );
                },
              );
            },
            color: const Color(0xFFffffff),
          ),
//Navigator.of(context).pop();
          new IconButton(
            icon: Icon(Icons.settings, size: scale(24.0)),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => new Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.black,
                      title: new Text(
                        "FILESYSTEM EXPANSION MODE",
                        style: new TextStyle(fontSize: 15),
                      ),
                    ),
                    body: Container(
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.memory,
                                color: const Color(0xFFffffff), size: 75.0),
                            new Container(
                              padding: const EdgeInsets.only(top: 15),
                              width: 450,
                              child: new Text(
                                "Filesystem expansion will allow the system to use the entire live disk as storage. Warning: Expanding the filesystem may cause a loss of data!",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: EdgeInsets.all(10),
                                  child: OutlineButton(
                                    child: new Text("CANCEL"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.white,
                                    textColor: Colors.white,
                                    borderSide: BorderSide(
                                      color: Color(0xFFFFFFff),
                                      //Color of the border
                                      style: BorderStyle
                                          .solid, //Style of the border
                                      width: 2,
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: EdgeInsets.all(10),
                                  child: MaterialButton(
                                    child: new Text("CONTINUE"),
                                    onPressed: () {},
                                    color: Colors.white,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            )
                          ]),
                      color: const Color(0xFF0a0a0a),
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: 1.7976931348623157e+308,
                      height: 1.7976931348623157e+308,
                    ),
                  ),
                );
              });
            },
            color: const Color(0xFFffffff),
          ),
        ],
      ),
    );

    void changeColor() {
      DynamicTheme.of(context).setThemeData(
        ThemeData(
          primaryColor: Theme.of(context).primaryColor == Colors.indigo
              ? Colors.red
              : Colors.indigo,
        ),
      );
    }

    Widget sliderSection = Container(
        margin: EdgeInsets.fromLTRB(scale(25), 0, scale(25), scale(10)),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.brightness_6,
                  size: scale(24.0),
                  color: Colors.white,
                ),
                Expanded(
                  child: Slider(
                      value: brightness,
                      divisions: 10,
                      onChanged: (newBrightness) {
                        setState(() {
                          brightness = newBrightness;
                        });
                      }),
                ),
                Container(
                  width: scale(35),
                  child: Center(
                    child: Text(
                      "${(brightness * 100).toInt().toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontSize: scale(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.volume_up,
                  size: scale(24.0),
                  color: Colors.white,
                ),
                Expanded(
                  child: Slider(
                    value: volume,
                    divisions: 20,
                    onChanged: (newVolume) {
                      setState(() {
                        volume = newVolume;
                      });
                    },
                  ),
                ),
                Container(
                  width: scale(35),
                  child: Center(
                    child: Text(
                      "${(volume * 100).toInt().toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontSize: scale(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

    Column buildTile(IconData icon, String label, Function onClick) {
      return Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: scale(55),
            height: scale(55),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: onClick,
                elevation: 0.0,
                child: Icon(icon, color: Colors.white, size: scale(30.0)),
              ),
            ),
          ),
          Container(
            width: 50,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              label,
              style: biggerFont,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    Widget tileSection = Expanded(
      child: Container(
          padding: EdgeInsets.all(scale(10.0)),
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 2.5 / 4,
              children: [
                buildTile(
                    Icons.network_wifi, local.get("qs_wifi"), changeColor),
                buildTile(Icons.palette, local.get("qs_theme"), changeColor),
                buildTile(Icons.battery_full, '85%', changeColor),
                buildTile(
                    Icons.do_not_disturb_off, local.get("qs_dnd"), changeColor),
                buildTile(Icons.lightbulb_outline, local.get("qs_flashlight"),
                    changeColor),
                buildTile(Icons.screen_lock_rotation,
                    local.get("qs_autorotate"), changeColor),
                buildTile(
                    Icons.bluetooth, local.get("qs_bluetooth"), changeColor),
                buildTile(Icons.airplanemode_inactive,
                    local.get("qs_airplanemode"), changeColor),
                buildTile(Icons.invert_colors_off, local.get("qs_invertcolors"),
                    changeColor),
                buildTile(Icons.language, local.get("qs_changelanguage"), () {
                  /*if (Localizations.localeOf(context).toString() == "en") {
                    Pangolin.setLocale(context, Locale("de"));
                    Pangolin.settingsBox.put("language", "de");
                  }
                  if (Localizations.localeOf(context).toString() == "de") {
                    Pangolin.setLocale(context, Locale("en"));
                    Pangolin.settingsBox.put("language", "en");
                  }*/
                  switch (Localizations.localeOf(context).toString()) {
                    case "en":
                      Pangolin.setLocale(context, Locale("de"));
                      Pangolin.settingsBox.put("language", "de");
                      break;
                    case "de":
                      Pangolin.setLocale(context, Locale("fr"));
                      Pangolin.settingsBox.put("language", "fr");
                      break;
                    case "fr":
                      Pangolin.setLocale(context, Locale("pl"));
                      Pangolin.settingsBox.put("language", "pl");
                      break;
                    case "pl":
                      Pangolin.setLocale(context, Locale("hr"));
                      Pangolin.settingsBox.put("language", "hr");
                      break;
                    case "hr":
                      Pangolin.setLocale(context, Locale("nl"));
                      Pangolin.settingsBox.put("language", "nl");
                      break;
                    case "nl":
                      Pangolin.setLocale(context, Locale("es"));
                      Pangolin.settingsBox.put("language", "es");
                      break;
                    case "es":
                      Pangolin.setLocale(context, Locale("pt"));
                      Pangolin.settingsBox.put("language", "pt");
                      break;
                    case "pt":
                      Pangolin.setLocale(context, Locale("id"));
                      Pangolin.settingsBox.put("language", "id");
                      break;
                    case "id":
                      Pangolin.setLocale(context, Locale("en"));
                      Pangolin.settingsBox.put("language", "en");
                      break;
                    default:
                      Pangolin.setLocale(context, Locale("en"));
                      Pangolin.settingsBox.put("language", "en");
                      break;
                  }
                }),
              ])),
    );

    return Container(
      color: Colors.black.withOpacity(0.0),
      //original color was 29353a, migrated to 2D2D2D
      //padding: const EdgeInsets.all(10.0),
      //alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(15.0),
      width: scale(375),
      height: scale(600),
      child: Column(
        children: [topSection, sliderSection, tileSection],
      ),
    );
  }
}

void notImplemented(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
            Localization.of(context).get("featurenotimplemented_title")),
        content: new Text(
            Localization.of(context).get("featurenotimplemented_value")),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
