import 'dart:ui';

import 'package:GeneratedApp/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  double brightness = 0.75;
  double blueLightValue = 0.75;
  bool blueLight = false;
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
                "Display",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Screen",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Text("Set your Screen Brightness"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Slider(
                                  divisions: 20,
                                  label: "${(brightness * 100).toString()}%",
                                  onChanged: (double state) {
                                    setState(() {
                                      brightness = state;
                                    });
                                  },
                                  value: brightness,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Blue Light Filter",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Enable Blue Light Filter to protect your eyes"),
                                Switch(
                                  value: blueLight,
                                  onChanged: (bool state) {
                                    setState(() {
                                      blueLight = state;
                                    });
                                  },
                                )
                              ],
                            ),
                            Slider(
                              divisions: 20,
                              label: "${(blueLightValue * 100).toString()}%",
                              onChanged: (double state) {
                                setState(() {
                                  blueLightValue = state;
                                });
                              },
                              value: blueLightValue,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Resolution",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Text("Adjust your Screen Resolution"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Slider(
                                      divisions: 20,
                                      label:
                                          "${(brightness * 100).toString()}%",
                                      onChanged: (double state) {
                                        setState(() {
                                          brightness = state;
                                        });
                                      },
                                      value: brightness,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 200,
                                    width: 400,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[350],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    width: 400,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[350],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                              //TODO put into Alert Dialog for Help
                              /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "You can adjust your Screen Resolution to to your personal feelings. \nThe Image to the right shows you information about different Screen Reolutions.",
                            style: TextStyle(fontSize: 17, letterSpacing: 0.2),
                          ),
                          Image.network(
                            "https://www.logicalincrements.com/assets/img/peripherals/screen/resolutions_1200.png",
                            height: 300,
                          ),
                        ],
                      ),*/
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
