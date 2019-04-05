import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'apps.dart';
//import 'launcher-widget.dart';

class AppMenu extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(// A simplified version of dialog.
      width: 600,
      height: 400,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            color: const Color(0xFFffffff),
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            width: 1.7976931348623157e+308,
            height: 75.0,
            child: SearchWidget(),
          ),
          AppGrid(),
          AppGrid(),
          AppGrid(),
        ],
      ),
    );
  }
}