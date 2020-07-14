import 'package:GeneratedApp/settings/hiveManager.dart';
import 'package:GeneratedApp/widgets/conditionWidget.dart';
import 'package:GeneratedApp/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Customization extends StatefulWidget {
  @override
  _CustomizationState createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
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
                "Customization",
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
                      child: Text("Accent Color",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Text("Choose your accent Color -  restart required"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildAcctenColorButton(
                                  "orange", Colors.deepOrangeAccent[400], () {
                                setState(() {
                                  HiveManager()
                                      .set("accentColorName", "orange");
                                  HiveManager().set("accentColorValue",
                                      Colors.deepOrangeAccent[400].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "red", Colors.redAccent[700], () {
                                setState(() {
                                  HiveManager().set("accentColorName", "red");
                                  HiveManager().set("accentColorValue",
                                      Colors.redAccent[700].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "green", Colors.greenAccent[700], () {
                                setState(() {
                                  HiveManager().set("accentColorName", "green");
                                  HiveManager().set("accentColorValue",
                                      Colors.greenAccent[700].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "blue", Colors.blueAccent[700], () {
                                setState(() {
                                  HiveManager().set("accentColorName", "blue");
                                  HiveManager().set("accentColorValue",
                                      Colors.blueAccent[700].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "purple", Colors.purpleAccent[700], () {
                                setState(() {
                                  HiveManager()
                                      .set("accentColorName", "purple");
                                  HiveManager().set("accentColorValue",
                                      Colors.purpleAccent[700].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "cyan", Colors.cyanAccent[700], () {
                                setState(() {
                                  HiveManager().set("accentColorName", "cyan");
                                  HiveManager().set("accentColorValue",
                                      Colors.cyanAccent[700].value);
                                });
                              }),
                              buildAcctenColorButton(
                                  "amber", Colors.amberAccent[700], () {
                                setState(() {
                                  HiveManager().set("accentColorName", "amber");
                                  HiveManager().set("accentColorValue",
                                      Colors.amberAccent[700].value);
                                  Pangolin.refreshTheme();
                                });
                              }),
                              buildAcctenColorButton("black", Colors.black, () {
                                setState(() {
                                  HiveManager().set("accentColorName", "black");
                                  HiveManager().set(
                                      "accentColorValue", Colors.black.value);
                                });
                              }),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    HiveManager()
                                        .set("accentColorName", "custom");
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.blur_on,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Blur",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Enable Blur Effects on the Desktop - restart required"),
                            Switch(
                              value: HiveManager().get("enableBlur"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("enableBlur", state);
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Dark Mode",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Enable Dark Mode on the Desktop and all Apps"),
                            Switch(
                              value: HiveManager().get("darkMode"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("darkMode", state);
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Taskbar",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Center Taskbar Items - restart required"),
                            Switch(
                              value: HiveManager().get("centerTaskbar"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("centerTaskbar", state);
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Wallpaper",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Enable Random Wallpapers"),
                            Switch(
                              value: HiveManager().get("randomWallpaper"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("randomWallpaper", state);
                                });
                              },
                            )
                          ],
                        ),
                        ConditionWidget(
                            !HiveManager().get("randomWallpaper"),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Choose a Wallpaper"),
                                    FlatButton(
                                      onPressed: () {
                                        wallpaperChooser(context);
                                      },
                                      child: Text("Open Wallpaper Chooser"),
                                    )
                                  ],
                                )
                              ],
                            )),
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

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  GestureDetector buildAcctenColorButton(
      String name, Color color, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          backgroundColor: color,
          child: (HiveManager().get("accentColorName") == name)
              ? Icon(Icons.blur_circular, color: Colors.white)
              : Container(
                  height: 0,
                ),
        ),
      ),
    );
  }
}

void wallpaperChooser(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Center(child: new Text("Wallpaper")),
        content: new Container(
          width: HiveManager.magicNumber,
          height: HiveManager.magicNumber,
          color: Colors.black,
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Save"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
