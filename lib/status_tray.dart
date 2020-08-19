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

import 'package:Pangolin/main.dart';
import 'package:Pangolin/settings/hiveManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'widgets/toggle.dart';

/// Hosts a collection of status icons.
class StatusTrayWidget extends StatefulWidget {
  final ValueChanged<bool> _callback;
  final GlobalKey<ToggleState> _toggleKey;

  final Tween<double> _backgroundOpacityTween =
      new Tween<double>(begin: 0.0, end: 0.33);

  /// Constructor.
  StatusTrayWidget({
    GlobalKey<ToggleState> toggleKey,
    ValueChanged<bool> callback,
  })  : _toggleKey = toggleKey,
        _callback = callback;

  @override
  StatusTrayWidgetState createState() => StatusTrayWidgetState();
}

class StatusTrayWidgetState extends State<StatusTrayWidget> {
  String _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    if (!isTesting)
      Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    else
      print("WARNING: Clock was disabled due to testing flag!");
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return HiveManager.get("showSeconds")
        ? (HiveManager.get("enable24hTime")
            ? DateFormat.Hms().format(dateTime)
            : DateFormat('hh:mm:ss').format(dateTime))
        : (HiveManager.get("enable24hTime")
            ? DateFormat.Hm().format(dateTime)
            : DateFormat('hh:mm').format(dateTime));
  }

  @override
  Widget build(BuildContext context) => new Toggle(
        key: widget._toggleKey,
        callback: widget._callback,
        builder: (Animation<double> animation) {
          return new AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) => new Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                color: Colors.grey.withOpacity(
                    widget._backgroundOpacityTween.evaluate(animation)),
              ),
              child: child,
            ),
            child: Center(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.signal_wifi_4_bar,
                        color: HiveManager.get("darkMode")
                            ? Colors.white
                            : Colors.black,
                        size: 20.0),
                    new Icon(Icons.bluetooth,
                        color: HiveManager.get("darkMode")
                            ? Colors.white
                            : Colors.black,
                        size: 20.0),
                    new Icon(Icons.battery_charging_full,
                        color: HiveManager.get("darkMode")
                            ? Colors.white
                            : Colors.black,
                        size: 20.0),
                    VerticalDivider(
                      thickness: 2,
                      endIndent: 10,
                      indent: 10,
                      color: HiveManager.get("darkMode")
                          ? Colors.grey
                          : Colors.grey[800],
                    ),
                    Text(
                      _timeString,
                      style: TextStyle(
                          fontSize: 20,
                          color: HiveManager.get("darkMode")
                              ? Colors.white
                              : Colors.black),
                    ),
                  ]),
            ),
          );
        },
      );
}
