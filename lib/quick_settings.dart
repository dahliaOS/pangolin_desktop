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
           new IconButton(
            
            icon: const Icon(Icons.power_settings_new),
            onPressed:() {
          
          
           showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Feature not implemented"),
          content: new Text("This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
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
        
          
          
        },
           
            color: const Color(0xFFffffff),
          ),

            new IconButton(
            icon: const Icon(Icons.settings),
            onPressed:() {
          
          
           showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Feature not implemented"),
          content: new Text("This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
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
        
          
          
        },
           
            color: const Color(0xFFffffff),
          ),

          
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

          FloatingActionButton(elevation: 0.0,child: Icon(icon, color: Colors.white, size: 30.0),),
          
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
      color: Colors.black.withOpacity(0.0),
        //original color was 29353a, migrated to 2D2D2D
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

