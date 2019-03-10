
import 'dart:async';
import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'apps.dart';

class AppMenu extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {

    return new Scaffold(

      body:





      new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[




      new Container(
      color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 1.7976931348623157e+308,
        height: 75.0,
        child: new SearchWidget(),
      ),




        new Container(
          color: const Color(0xFFffffff),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.centerLeft,
          width: 250.0,
          height: 75.0,
          child: new WallpaperIcon(),
        ),



      new Container(
        color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 250.0,
        height: 75.0,
        child: new WallpaperIcon(),
      ),

      new Container(
        color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 250.0,
        height: 75.0,
        child: new WallpaperIcon(),
      ),

      new Container(
        color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 250.0,
        height: 75.0,
        child: new WallpaperIcon(),
      ),

      new Container(
        color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 250.0,
        height: 75.0,
        child: new WallpaperIcon(),
      ),

      new Container(
        color: const Color(0xFFffffff),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.centerLeft,
        width: 250.0,
        height: 75.0,
        child: new WallpaperIcon(),
      ),





          ]

      ),




      );







  }
}