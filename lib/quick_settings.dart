import 'package:flutter/material.dart';

class QuickSettings extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    const biggerFont = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
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
                Text('12:15', style: biggerFont),
                //Icon(Icons.brightness_1, size: 10.0,color: Colors.white),
                Text('  •  ', style: biggerFont),
                Text('Tue, March 11', style: biggerFont),
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
      child: Slider(value: 1.0, onChanged: (double){})
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
          buildTile(Icons.network_wifi, 'Starbucks'),
          buildTile(Icons.network_cell, 'Verizon Wireless'),
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


