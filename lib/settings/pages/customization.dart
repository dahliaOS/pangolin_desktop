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
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:pangolin/widgets/wallpaper_picker.dart';
import 'package:provider/provider.dart';

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

class _CustomizationState extends State<Customization>
    with TickerProviderStateMixin {
  Size size = Size.zero;
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context);
    return Scaffold(
      appBar: _CustomizationHeader(controller: _controller),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 16),
        child: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: _controller,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsHeader(
                      heading: LocaleStrings.settings.customizationAccentColor),
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
                  SettingsHeader(heading: "Theme Presets"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        SettingsPreset(
                          blur: 50,
                          dark: true,
                          opacity: 0.3,
                        ),
                        SettingsPreset(
                          blur: 50,
                          dark: false,
                          opacity: 0.4,
                        ),
                        SettingsPreset(
                          blur: 25,
                          dark: true,
                          opacity: 0.5,
                        ),
                        SettingsPreset(
                          blur: 25,
                          dark: false,
                          opacity: 0.5,
                        ),
                        SettingsPreset(
                          blur: 5,
                          dark: true,
                          opacity: 0.8,
                        ),
                        SettingsPreset(
                          blur: 5,
                          dark: false,
                          opacity: 0.7,
                        ),
                        SettingsPreset(
                          blur: 0,
                          dark: true,
                          opacity: 1.0,
                        ),
                        SettingsPreset(
                          blur: 0,
                          dark: false,
                          opacity: 1.0,
                        ),
                        SettingsPreset(
                          blur: 0,
                          dark: true,
                          opacity: 0.6,
                        ),
                        SettingsPreset(
                          blur: 0,
                          dark: false,
                          opacity: 0.5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          title: Text(LocaleStrings
                              .settings.customizationEnableCenteredTaskbar),
                          secondary: Icon(Icons.view_array_outlined),
                          value: _data.centerTaskbar,
                          onChanged: (val) => _data.centerTaskbar = val,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Set the Position of the Taskbar",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton<double>(
                              value: _data.taskbarPosition,
                              icon: Icon(null),
                              hint: Text("Taskbar Position"),
                              items: [
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Bottom",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "Top",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "Left",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text(
                                    "Right",
                                  ),
                                ),
                              ],
                              onChanged: (double? val) {
                                _data.taskbarPosition = val ?? 0.0;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Set the Launcher Icon",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton<int>(
                              value: _data.launcherIcon,
                              icon: Icon(null),
                              hint: Text("Taskbar Position"),
                              items: [
                                DropdownMenuItem(
                                  value: Icons.apps.codePoint,
                                  child: Row(
                                    children: [
                                      Icon(Icons.apps),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text("Icon 1")
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Icons.panorama_fisheye.codePoint,
                                  child: Row(
                                    children: [
                                      Icon(Icons.panorama_fisheye),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text("Icon 2")
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Icons.brightness_low.codePoint,
                                  child: Row(
                                    children: [
                                      Icon(Icons.brightness_low),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text("Icon 3")
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Icons.radio_button_checked.codePoint,
                                  child: Row(
                                    children: [
                                      Icon(Icons.radio_button_checked),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text("Icon 4")
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (val) {
                                _data.launcherIcon = val!;
                              },
                            ),
                          ),
                        ),
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
                                LocaleStrings
                                    .settings.customizationChooseWallpaperDesc,
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
    );
  }
}

class _CustomizationHeader extends StatelessWidget with PreferredSizeWidget {
  final TabController controller;
  const _CustomizationHeader({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 40, 8.0, 24),
            child: settingsTitle("Customization")),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            labelColor: Theme.of(context).textTheme.bodyText1?.color,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1?.color,
            physics: BouncingScrollPhysics(),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            controller: controller,
            tabs: [
              Tab(
                text: "Basic Customization",
              ),
              Tab(
                text: "Advanced Customization",
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(148);
}

class SettingsPreset extends StatelessWidget {
  final double blur, opacity;
  final bool dark;
  const SettingsPreset(
      {required this.blur, required this.opacity, required this.dark});
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return SizedBox(
      width: 210,
      height: 120,
      child: BoxContainer(
        useBlur: false,
        useSystemOpacity: false,
        useShadows: true,
        color: Colors.transparent,
        customBorderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!)),
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Expanded(child: wallpaperImage(_pref.wallpaper)),
              BoxContainer(
                customBlur: blur,
                useBlur: true,
                color: Colors.transparent,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      dark
                          ? Colors.black.withOpacity(opacity)
                          : Colors.white.withOpacity(opacity),
                      dark
                          ? Colors.black.withOpacity(opacity)
                          : Colors.white.withOpacity(opacity),
                      dark
                          ? Colors.black.withOpacity(opacity)
                          : Colors.white.withOpacity(opacity),
                      dark
                          ? Colors.black.withOpacity(opacity)
                          : Colors.white.withOpacity(opacity),
                      dark
                          ? Colors.black.withOpacity(opacity)
                          : Colors.white.withOpacity(opacity),
                      opacity == 1
                          ? dark
                              ? Colors.black.withOpacity(opacity)
                              : Colors.white.withOpacity(opacity)
                          : Colors.transparent,
                      opacity == 1
                          ? dark
                              ? Colors.black.withOpacity(opacity)
                              : Colors.white.withOpacity(opacity)
                          : Colors.transparent,
                      opacity == 1
                          ? dark
                              ? Colors.black.withOpacity(opacity)
                              : Colors.white.withOpacity(opacity)
                          : Colors.transparent,
                      opacity == 1
                          ? dark
                              ? Colors.black.withOpacity(opacity)
                              : Colors.white.withOpacity(opacity)
                          : Colors.transparent,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dark ? "Dark" : "Light",
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Blur: ${blur.toString().replaceAll(".0", "")}",
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Opacity: ${(opacity * 100).toString().replaceAll(".0", "")}%",
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  onTap: () {
                    _pref.blur = blur;
                    _pref.darkMode = dark;
                    _pref.themeOpacity = opacity;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
