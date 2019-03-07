
import 'dart:async';
import 'package:flutter/material.dart';


class AppMenu extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      body:
      new GridView.extent(
          maxCrossAxisExtent: 150.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            new Image.asset(
              'lib/images/gallery.png',
              fit:BoxFit.fill,
              width: 50.0,
              height: 50.0,
            )
          ]

      ),

    );
  }
}