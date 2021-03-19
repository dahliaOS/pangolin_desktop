/*
Copyright 2021 The dahliaOS Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class Customization extends StatefulWidget {
  static int selectedWallpaper = 0;
  @override
  _CustomizationState createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Customization",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto"),
                  )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsHeader(heading: "Accent Color"),
                    SettingsTile(
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildAcctenColorButton(Colors.deepOrange, "Orange"),
                            buildAcctenColorButton(Colors.red.shade700, "Red"),
                            buildAcctenColorButton(
                                Colors.greenAccent.shade700, "Green"),
                            buildAcctenColorButton(Colors.blue, "Blue"),
                            buildAcctenColorButton(Colors.purple, "Purple"),
                            buildAcctenColorButton(Colors.cyan, "Cyan"),
                            buildAcctenColorButton(Colors.amber, "Amber"),
                            buildAcctenColorButton(
                                (_data.darkMode ? Colors.white : Colors.black),
                                _data.darkMode ? "White" : "Black"),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SettingsHeader(heading: "Blur"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                            secondary: Icon(Icons.blur_on_outlined),
                            value: _data.enableBlur,
                            title: Text("Enable blur effects on the desktop"),
                            onChanged: (bool state) {
                              _data.enableBlur = !_data.enableBlur;
                            }),
                        _data.enableBlur
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: FloatingActionButton(
                                          elevation: 1.0,
                                          onPressed: () {
                                            if (_data.blur > 5) {
                                              _data.blur = _data.blur - 5;
                                            }
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      Text(
                                        _data.blur.toString(),
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: FloatingActionButton(
                                          elevation: 1.0,
                                          onPressed: () {
                                            if (_data.blur < 50) {
                                              _data.blur = _data.blur + 5;
                                            }
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                    SettingsHeader(heading: "Dark Mode"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.brightness_4_outlined),
                          value: _data.darkMode,
                          title: Text("Enable Dark mode on all applications"),
                          onChanged: (bool state) {
                            _data.darkMode = !_data.darkMode;
                            if (_data.darkMode &&
                                _data.accentColor == Colors.black.value) {
                              _data.accentColor = Colors.white.value;
                            } else if (!_data.darkMode &&
                                _data.accentColor == Colors.white.value) {
                              _data.accentColor = Colors.black.value;
                            }
                          },
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Opacity"),
                    SettingsTile(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Text(
                            "Change system opacity",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              Icon(Icons.adjust_rounded),
                              Expanded(
                                child: Slider(
                                  onChanged: (double value) {
                                    _data.themeOpacity = value;
                                  },
                                  value: _data.themeOpacity,
                                  divisions: 10,
                                ),
                              ),
                              Text((_data.themeOpacity * 100)
                                      .toString()
                                      .substring(
                                          0,
                                          (_data.themeOpacity
                                                  .toString()
                                                  .startsWith("100")
                                              ? 2
                                              : 3))
                                      .replaceAll(".", "") +
                                  " %"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Font"),
                    SettingsTile(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Text(
                            "Choose system font family",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            onChanged: (value) {
                              _data.fontFamily = value.toString();
                            },
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                child: Text("Roboto"),
                                value: "Roboto",
                              ),
                              DropdownMenuItem(
                                child: Text("DM Sans"),
                                value: "DM-Sans",
                              ),
                              DropdownMenuItem(
                                child: Text("Lato"),
                                value: "Lato",
                              ),
                            ],
                            value: _data.fontFamily,
                          ),
                        )
                      ],
                    ),
                    SettingsHeader(heading: "Deskotop"),
                    SettingsTile(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose your Desktop Wallpaper",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return WallpaperChooser();
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12.0),
                                  child: Text("Choose Wallpaper"),
                                ))
                          ],
                        ),
                      ),
                    ])

                    /*SettingsHeader(heading: "Taskbar"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.view_array),
                          value: true,
                          title: Text("Center taskbar icons"),
                          onChanged: (bool state) {
                            setState(() {
                              DatabaseManager.set("centerTaskbar", state);
                            });
                          },
                        )
                      ],
                    ),
                    SettingsHeader(heading: "Wallpaper"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.replay),
                          value: true, //DatabaseManager.get("randomWallpaper"),
                          title: Text("Enable random wallpapers"),
                          onChanged: (bool state) {
                            setState(() {
                              DatabaseManager.set("randomWallpaper", state);
                            });
                          },
                        ),
                        /* ConditionWidget(
                            !DatabaseManager.get("randomWallpaper"),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Choose a wallpaper"),
                                      FlatButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return WallpaperChooser();
                                              });
                                        },
                                        child: Text("Wallpaper chooser"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )), */
                      ],
                    ),
                    SettingsHeader(heading: "Launcher"),
                    SettingsTile(
                      children: [
                        Column(
                          children: [
                            SwitchListTile(
                              secondary: Icon(Icons.view_comfortable),
                              value:
                                  true, // DatabaseManager.get("launcherWideMode"),
                              title: Text(
                                  "Span applications across the full width of the launcher"),
                              onChanged: (bool state) {
                                setState(() {
                                  DatabaseManager.set(
                                      "launcherWideMode", state);
                                });
                              },
                            ),
                            SwitchListTile(
                              secondary: Icon(Icons.widgets),
                              value:
                                  true, //DatabaseManager.get("showIntentCardsInLauncher"),
                              title: Text("Show Intent Cards in the launcher"),
                              onChanged: (bool state) {
                                setState(() {
                                  DatabaseManager.set(
                                      "showIntentCardsInLauncher", state);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Window titlebars"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: RotatedBox(
                              quarterTurns: 2, child: Icon(Icons.video_label)),
                          value: true, //DatabaseManager.get("coloredTitlebar"),
                          title: Text("Enabled colored titlebar"),
                          onChanged: (bool state) {
                            setState(() {
                              DatabaseManager.set("coloredTitlebar", state);
                            });
                          },
                        ),
                      ],
                    ), */
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

  InkWell buildAcctenColorButton(Color color, String name) {
    final _data = Provider.of<PreferenceProvider>(context, listen: true);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        _data.accentColor = color.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Tooltip(
          message: name,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                  backgroundColor: color,
                  child: (_data.accentColor == color.value)
                      ? Icon(Icons.blur_circular,
                          color: DatabaseManager.get("darkMode")
                              ? Colors.black
                              : Colors.white)
                      : SizedBox.shrink()),
            ),
          ),
        ),
      ),
    );
  }
}

class WallpaperChooser extends StatefulWidget {
  const WallpaperChooser({
    Key? key,
  }) : super(key: key);

  @override
  _WallpaperChooserState createState() => _WallpaperChooserState();
}

class _WallpaperChooserState extends State<WallpaperChooser> {
  //int _index = DatabaseManager.get("wallpaper");
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    final _controller = TextEditingController();
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text("Choose a Wallpaper"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 300,
        height: MediaQuery.of(context).size.height - 300,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 16 / 9),
          itemCount: wallpapers.length,
          itemBuilder: (BuildContext context, int index) {
            //_index = index;
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _data.wallpaper = wallpapers[index];
                      //_index = index;
                      //Customization.selectedWallpaper = index;
                    });
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          wallpapers[index].toString(),
                          fit: BoxFit.cover,
                          scale: 1.0,
                        ),
                      ),
                      (_data.wallpaper == wallpapers[index])
                          ? Positioned(
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                foregroundColor: Colors.white,
                                child: Icon(Icons.check),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ));
          },
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
                child: TextField(
              decoration: InputDecoration(hintText: "Set wallpaper from URL"),
              maxLines: 1,
              controller: _controller,
              onSubmitted: (text) {
                if (text.startsWith("http")) {
                  _data.wallpaper = text;
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
            )),
            TextButton(
                onPressed: () {
                  if (_controller.text.startsWith("http")) {
                    _data.wallpaper = _controller.text;
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 22),
                  child: Text("Save"),
                ))
          ],
        ),
      ],
    );
  }
}
