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
  })
      : _toggleKey = toggleKey,
        _callback = callback;

  @override
  StatusTrayWidgetState createState() => StatusTrayWidgetState();
}

class StatusTrayWidgetState extends State<StatusTrayWidget> {
  String _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
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

    return DateFormat('hh:mm').format(dateTime);
  }
  @override
  Widget build(BuildContext context) => new Toggle(
        key: widget._toggleKey,
        callback: widget._callback,
        builder: (Animation<double> animation) {
          return new AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) => new Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(4.0),
                    color: Colors.grey.withOpacity(
                        widget._backgroundOpacityTween.evaluate(animation)),
                  ),
                  child: child,
                ),
            child: Center(
              child: 
              
              new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              new Icon(
                Icons.signal_wifi_4_bar,
                color: const Color(0xFFffffff),
                size: 20.0),
    
             
              new Icon(
                Icons.bluetooth,
                color: const Color(0xFFffffff),
                size: 20.0),
                
                 new Icon(
                Icons.battery_charging_full,
                color: const Color(0xFFffffff),
                size: 20.0),
    
                Text(
                _timeString,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ]
    
          ),
    
              
              
              
            ),
          );
        },
      );
}