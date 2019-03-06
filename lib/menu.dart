
import 'dart:async';
import 'package:flutter/material.dart';


class AppMenu extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Wallpapers'),
      ),
      body:
      new Container(
        child:
        new Card(key: null,
          child:
          new Image.asset(
            'lib/images/def.png',
            fit:BoxFit.fill,
            width: 500.0,
            height: 500.0,
          ),

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),

    );
  }
}