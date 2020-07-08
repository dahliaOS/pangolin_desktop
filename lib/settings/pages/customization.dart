import 'package:GeneratedApp/settings/hiveManager.dart';
import 'package:GeneratedApp/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

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
                        Text("Choose your accent Color"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildAcctenColorButton(
                                  Colors.deepOrangeAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.redAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.greenAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.blueAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.purpleAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.cyanAccent[700], () {}),
                              buildAcctenColorButton(
                                  Colors.amberAccent[700], () {}),
                              buildAcctenColorButton(Colors.black, () {}),
                              GestureDetector(
                                onTap: () {},
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
                            Text("Choose a Wallpaper"),
                            FlatButton(
                              onPressed: () {},
                              child: Text("Open Wallpaper Chooser"),
                            )
                          ],
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

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  GestureDetector buildAcctenColorButton(Color color, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
