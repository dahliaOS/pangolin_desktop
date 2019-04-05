/*This will ultimately be replaced by a global system file, but keep it for android*/
//import 'dart:async';
import 'package:flutter/material.dart';

class AppGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/wallpaper.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class WallpaperIcon extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/wallpaper.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}