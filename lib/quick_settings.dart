import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class QuickSettings extends StatefulWidget {
  @override
  QuickSettingsState createState() => QuickSettingsState();
}

class QuickSettingsState extends State<QuickSettings> {
  String _timeString;
  String _dateString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now(),'hh:mm');
    _dateString = _formatDateTime(DateTime.now(),'E, MMM d');
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now,'hh:mm');
    final String formattedDate = _formatDateTime(now,'E, MMM d');
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }
  String _formatDateTime(DateTime dateTime, String pattern) {

    return DateFormat(pattern).format(dateTime);
  }

  @override
  Widget build (BuildContext context) {
    const biggerFont = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
    );
    Widget topSection = Container(
      padding: EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Expanded(
            child:*/ Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_timeString, style: biggerFont),
                //Icon(Icons.brightness_1, size: 10.0,color: Colors.white),
                Text('  •  ', style: biggerFont),
                Text(_dateString, style: biggerFont),
              ],
            ),
          //),
          Icon(Icons.notifications_none, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );

    Widget sliderSection = Container(
      padding: EdgeInsets.all(15.0),
      child: Slider(value: 0.75, onChanged: (double){} )
    );

    Column buildTile(IconData icon, String label) {
      return Column(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30.0),
          Container(
            margin: EdgeInsets.only(top: 8),
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
      padding: EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          buildTile(Icons.network_wifi, 'Wifi Network'),
          buildTile(Icons.network_cell, 'LTE'),
          buildTile(Icons.battery_full, '85%'),
          buildTile(Icons.do_not_disturb_off, 'Do not disturb'),
          buildTile(Icons.lightbulb_outline, 'Flashlight'),
          buildTile(Icons.screen_lock_rotation, 'Auto-rotate'),
          buildTile(Icons.bluetooth, 'Bluetooth'),
          buildTile(Icons.airplanemode_inactive, 'Airplane mode'),
          buildTile(Icons.invert_colors_off, 'Invert colors'),
        ]
      )
        ),
    );

    return Container(
      color: Color(0xFF29353A),
            //padding: const EdgeInsets.all(10.0),
            //alignment: Alignment.centerLeft,
            width: 350,
            height: 350,
            child: Column(
              children: [
                topSection,
                sliderSection,
                tileSection
              ],
            ),
          );
  }
}


