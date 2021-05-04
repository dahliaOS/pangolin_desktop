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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:pangolin/widgets/wallpaper_picker.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/utils/preference_extension.dart';

class Customization extends StatefulWidget {
  static int selectedWallpaper = 0;
  @override
  _CustomizationState createState() => _CustomizationState();

  static Row accentColors(PreferenceProvider _data, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildAcctenColorButton(Colors.deepOrange, "Orange", context),
        buildAcctenColorButton(Colors.red.shade700, "Red", context),
        buildAcctenColorButton(Colors.greenAccent.shade700, "Green", context),
        buildAcctenColorButton(Colors.blue, "Blue", context),
        buildAcctenColorButton(Colors.purple, "Purple", context),
        buildAcctenColorButton(Colors.cyan, "Cyan", context),
        buildAcctenColorButton(Colors.amber, "Amber", context),
        buildAcctenColorButton((_data.darkMode ? Colors.white : Colors.black),
            _data.darkMode ? "White" : "Black", context),
        buildCustomAcctenColorButton(context)
      ],
    );
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  static InkWell buildAcctenColorButton(
      Color color, String name, BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: true);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        _data.useCustomAccentColor = false;
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

  static InkWell buildCustomAcctenColorButton(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: true);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        accentColorDialog(context, _data);
        //_data.accentColor = color.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Tooltip(
          message: "Custom",
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                  backgroundColor: Color(_data.accentColor),
                  child: (_data
                          .useCustomAccentColor) //_data.accentColor == color.value)
                      ? Icon(Icons.blur_circular,
                          color: DatabaseManager.get("darkMode")
                              ? Colors.black
                              : Colors.white)
                      : Icon(
                          Icons.add,
                          color: _data.accentColor == Colors.white.value
                              ? Colors.black
                              : Colors.white,
                        )),
            ),
          ),
        ),
      ),
    );
  }

  static Future<dynamic> accentColorDialog(
      BuildContext context, PreferenceProvider _data) {
    return showDialog(
        context: context,
        builder: (context) {
          int? _customValue;
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorPicker(
                  showLabel: true,
                  portraitOnly: true,
                  enableAlpha: false,
                  onColorChanged: (Color value) {
                    //_data.accentColor = value.value;
                    _customValue = value.value;
                  },
                  pickerColor: Color(_data.accentColor),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_customValue != null) {
                      _data.accentColor = _customValue!;
                      _data.useCustomAccentColor = true;
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 22),
                    child: Text("Save"),
                  )),
            ],
          );
        });
  }
}

class _CustomizationState extends State<Customization> {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context);
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
              settingsTitle(LocaleStrings.settings.headerCustomization),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsHeader(
                        heading:
                            LocaleStrings.settings.customizationAccentColor),
                    SettingsTile(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          Customization.accentColors(_data, context),
                          SizedBox(height: 15),
                          SwitchListTile(
                              title: Text(LocaleStrings
                                  .settings.customizationColoredTitlebar),
                              value: _data.useColoredTitlebar,
                              onChanged: (val) {
                                _data.useColoredTitlebar =
                                    !_data.useColoredTitlebar;
                              })
                        ],
                      ),
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationDarkMode),
                    SettingsTile(
                      child: SwitchListTile(
                        secondary: Icon(Icons.brightness_4_outlined),
                        value: _data.darkMode,
                        title: Text(
                            LocaleStrings.settings.customizationEnableDarkMode),
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
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationBlur),
                    SettingsTile(
                      child: Column(
                        children: [
                          SwitchListTile(
                            secondary: Icon(Icons.blur_on_outlined),
                            value: _data.enableBlur,
                            title: Text(
                                LocaleStrings.settings.customizationEnableBlur),
                            onChanged: (bool state) {
                              _data.enableBlur = !_data.enableBlur;
                            },
                          ),
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
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationTaskbar),
                    SettingsTile(
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: Text(LocaleStrings
                                .settings.customizationEnableCenteredTaskbar),
                            secondary: Icon(Icons.view_array_outlined),
                            value: _data.centerTaskbar,
                            onChanged: (val) => _data.centerTaskbar = val,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leading: Radio(
                                  groupValue: _data.taskbarPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _data.taskbarPosition = 2;
                                    });
                                  },
                                  value: 2,
                                ),
                                title: Text("Bottom"),
                                onTap: () => _data.taskbarPosition = 2,
                              ),
                              ListTile(
                                leading: Radio(
                                  groupValue: _data.taskbarPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _data.taskbarPosition = 0;
                                    });
                                  },
                                  value: 0,
                                ),
                                title: Text("Top"),
                                onTap: () => _data.taskbarPosition = 0,
                              ),
                              ListTile(
                                leading: Radio(
                                  groupValue: _data.taskbarPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _data.taskbarPosition = 1;
                                    });
                                  },
                                  value: 1,
                                ),
                                title: Text("Left"),
                                onTap: () => _data.taskbarPosition = 1,
                              ),
                              ListTile(
                                leading: Radio(
                                  groupValue: _data.taskbarPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _data.taskbarPosition = 3;
                                    });
                                  },
                                  value: 3,
                                ),
                                title: Text("Right"),
                                onTap: () => _data.taskbarPosition = 3,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationOpacity),
                    SettingsTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Text(
                              LocaleStrings.settings.customizationChangeOpacity,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
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
                                !kIsWeb
                                    ? Text((_data.themeOpacity * 100)
                                            .toString()
                                            .substring(
                                                0,
                                                (_data.themeOpacity
                                                        .toString()
                                                        .startsWith("100")
                                                    ? 2
                                                    : 3))
                                            .replaceAll(".", "") +
                                        " %")
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationFont),
                    SettingsTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Text(
                              LocaleStrings.settings.customizationChooseFont,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: DropdownButton<String>(
                              onChanged: (value) {
                                _data.fontFamily = value.toString();
                              },
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: "Roboto",
                                  child: Text("Roboto"),
                                ),
                                DropdownMenuItem(
                                  value: "DM-Sans",
                                  child: Text("DM Sans"),
                                ),
                                DropdownMenuItem(
                                  value: "Lato",
                                  child: Text("Lato"),
                                ),
                                DropdownMenuItem(
                                  value: "Inter",
                                  child: Text("Inter"),
                                ),
                              ],
                              value: _data.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SettingsHeader(
                        heading: LocaleStrings.settings.customizationDesktop),
                    SettingsTile(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleStrings.settings
                                      .customizationChooseWallpaperDesc,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          barrierColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return WallpaperPicker();
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 12.0),
                                      child: Text(LocaleStrings.settings
                                          .customizationChooseWallpaperBtn),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
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
