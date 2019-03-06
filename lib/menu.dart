
import 'dart:async';
import 'package:flutter/material.dart';


class DWidget extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      drawer: new Drawer(
        child: new Text("\n\n\nDrawer Is Here"),
      ),
      appBar: new AppBar(
        title: new Text("Drawer Demo"),
      ),
      body: new Text("Drawer Body"),
    );
  }
}