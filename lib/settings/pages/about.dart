import 'dart:ui';

import 'package:Pangolin/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            children: [
              Center(
                  child: Text(
                "About Device",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              )),
              SizedBox(height: 20),
              Image(
                image: AssetImage("lib/images/DahliaLogo.png"),
                height: 200,
              ),
              SizedBox(height: 10),
              Text(
                "dahliaOS",
                style: TextStyle(fontSize: 35),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Version",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Version v200630.1")]),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Kernel",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Linux Kernel 5.6.15")]),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Pangolin Version",
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 5),
                SettingsTile(children: [Text("Version v200713.2")]),
                SizedBox(height: 20),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
