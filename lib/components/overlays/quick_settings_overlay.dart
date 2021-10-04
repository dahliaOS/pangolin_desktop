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

import 'dart:async';

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/locales/locale_strings.g.dart';
import 'package:pangolin/services/locales/locales.g.dart';
import 'package:pangolin/components/settings/data/presets.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/services/wm_api.dart';
import 'package:pangolin/widgets/quick_settings/qs_appbar.dart';
import 'package:pangolin/widgets/quick_settings/qs_button.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pangolin/utils/extensions/preference_extension.dart';

class QuickSettingsOverlay extends ShellOverlay {
  static const String overlayId = 'quicksettings';

  QuickSettingsOverlay() : super(id: overlayId);

  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

class _QuickSettingsOverlayState extends State<QuickSettingsOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: CommonData.of(context).animationDuration(),
    );
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    // _getTime(context);
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );

    if (!controller.showing) return SizedBox();

    return Positioned(
      bottom: _pref.isTaskbarRight || _pref.isTaskbarLeft
          ? 8
          : !_pref.isTaskbarTop
              ? 48 + 8
              : null,
      top: _pref.isTaskbarTop ? 48 + 8 : null,
      right: _pref.isTaskbarRight
          ? 48 + 8
          : _pref.isTaskbarLeft
              ? null
              : 8,
      left: _pref.isTaskbarLeft ? 48 + 8 : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, chilld) => FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            alignment: FractionalOffset(0.8, !_pref.isTaskbarTop ? 1.0 : 0.0),
            child: BoxSurface(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.BIG),
              /* decoration: BoxDecoration(boxShadow: [
                /* BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 50) */
              ], borderRadius: BorderRadius.circular(10)), */
              width: 500,
              height: 428,
              dropShadow: true,
              child: MaterialApp(
                routes: {
                  "/": (context) => QsMain(),
                  "/wifi": (context) => QsWifi(),
                  "/theme": (context) => QsTheme(),
                  "/bluetooth": (context) => QsBluetooth(),
                  "/language": (context) => QsLanguage(),
                },
                theme: Theme.of(context),
                debugShowCheckedModeBanner: false,
                locale: context.locale,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    final _shell = Shell.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,

      //AppBar
      appBar: AppBar(
        toolbarHeight: 48,
        foregroundColor: Theme.of(context).textTheme.bodyText1?.color,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.0),
        elevation: 0,
        title: Row(
          children: [
            SizedBox(width: 12),
            Text(
              LocaleStrings.qs.quickControls,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {
              _shell.dismissEverything();
              WmAPI.of(context).openApp("io.dahlia.settings");
            },
          ),
          SizedBox(width: 4),
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
            ),
            onPressed: () {
              _shell.showOverlay(
                PowerOverlay.overlayId,
                dismissEverything: false,
              );
            },
          ),
          SizedBox(width: 20),
        ],
        centerTitle: false,
      ),

      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          //Quick Controls Grid
          SizedBox(
            width: 520,
            height: 200,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              //padding: EdgeInsets.only(left: 8, right: 8),
              crossAxisCount: 5,
              mainAxisSpacing: 4,
              children: [
                QuickSettingsButton(
                  enabled: _pref.wifi,
                  title: LocaleStrings.qs.wifi,
                  icon: Icons.wifi,
                  disabledIcon: Icons.wifi_off,
                  onTap: () {
                    _pref.wifi = !_pref.wifi;
                  },
                  onTapSecondary: () {
                    Navigator.pushNamed(context, "/wifi");
                  },
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.bluetooth,
                  icon: Icons.bluetooth,
                  disabledIcon: Icons.bluetooth_disabled_outlined,
                  enabled: _pref.bluetooth,
                  onTap: () {
                    _pref.bluetooth = !_pref.bluetooth;
                  },
                  onTapSecondary: () {
                    Navigator.pushNamed(context, "/bluetooth");
                  },
                ),
                QuickSettingsButton(
                  title: 'Battery\n85%',
                  icon: Icons.battery_full,
                  disabledIcon: Icons.battery_full,
                  enabled: false,
                  onTap: () {},
                  onTapSecondary: () {},
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.dnd,
                  icon: Icons.do_not_disturb_outlined,
                  disabledIcon: Icons.do_not_disturb_off_outlined,
                  enabled: false,
                  onTap: () {},
                  onTapSecondary: () {},
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.flashlight,
                  icon: Icons.flashlight_on_outlined,
                  disabledIcon: Icons.flashlight_off_outlined,
                  enabled: false,
                  onTap: () {},
                  onTapSecondary: () {},
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.autorotate,
                  icon: Icons.screen_rotation,
                  disabledIcon: Icons.screen_lock_rotation,
                  enabled: false,
                  onTap: () {},
                  onTapSecondary: () {},
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.airplanemode,
                  icon: Icons.airplanemode_active,
                  disabledIcon: Icons.airplanemode_inactive,
                  enabled: (!_pref.wifi && !_pref.bluetooth),
                  onTap: () {
                    _pref.wifi = false;
                    _pref.bluetooth = false;
                  },
                  onTapSecondary: () {},
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.theme,
                  icon: Icons.brightness_4_outlined,
                  disabledIcon: Icons.brightness_5_outlined,
                  enabled: _pref.darkMode,
                  onTap: () {
                    _pref.darkMode = !_pref.darkMode;
                  },
                  onTapSecondary: () {
                    Navigator.pushNamed(context, "/theme");
                  },
                ),
                QuickSettingsButton(
                  title: LocaleStrings.qs.changelanguage,
                  icon: Icons.language,
                  disabledIcon: Icons.language,
                  enabled: true,
                  onTap: () {
                    int index = Locales.supported.indexOf(context.locale);
                    if (index + 1 < Locales.supported.length) {
                      context.setLocale(Locales.supported[index + 1]);
                    } else {
                      context.setLocale(Locales.supported[0]);
                    }
                  },
                  onTapSecondary: () {
                    Navigator.pushNamed(context, "/language");
                  },
                ),
                QuickSettingsButton(
                  title: 'TTY Shell',
                  icon: Icons.grid_3x3,
                  disabledIcon: Icons.grid_3x3,
                  enabled: true,
                  onTap: () {
                    SystemCalls().terminal();
                  },
                  onTapSecondary: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //Chip List
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                actionChip(Icons.more_time, "Reminder", context),
                actionChip(
                    Icons.info_outline, "Build $totalVersionNumber", context),
                actionChip(Icons.domain_verification, "dahliaos.io", context),
                actionChip(Icons.edit_outlined, null, context),
                //actionChip(Icons.add, null, context)
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),

          //Sliders
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.brightness_6,
                      size: 20,
                    ),
                    Expanded(
                      child: Slider(
                          value: _pref.brightness,
                          divisions: 10,
                          onChanged: (newBrightness) {
                            _pref.brightness = newBrightness;
                            /* setState(() {
                              brightness = newBrightness;
                            }); */
                          }),
                    ),
                    Container(
                      width: 35,
                      child: Center(
                        child: Text(
                            "${(_pref.brightness * 100).toInt().toString()}",
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.volume_up,
                      size: 20,
                    ),
                    Expanded(
                      child: Slider(
                        value: _pref.volumeLevel,
                        divisions: 20,
                        onChanged: (newVolume) {
                          _pref.volumeLevel = newVolume;
                          /* setState(() {
                            volume = newVolume;
                          }); */
                        },
                      ),
                    ),
                    Container(
                      width: 35,
                      child: Center(
                        child: Text(
                            "${(_pref.volumeLevel * 100).toInt().toString()}",
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Pages

// WiFi

class QsWifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Wi-Fi",
        value: _pref.wifi,
        onTap: () {
          _pref.wifi = !_pref.wifi;
        },
        /* elevation: 0,
        toolbarHeight: 48,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.4),
        centerTitle: true,
        title: Text("Wi-Fi"),
        actions: [
          Switch(value: true, onChanged: (val) {}),
          SizedBox(
            width: 8,
          ),
        ], */
      ),
    );
  }
}

// Bluetooth

class QsBluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Bluetooth",
        value: _pref.bluetooth,
        onTap: () {
          _pref.bluetooth = !_pref.bluetooth;
        },
        /* onTap: () {
          _pref.bluetooth = !_pref.bluetooth;
        }, */
        /* elevation: 0,
        toolbarHeight: 48,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.4),
        centerTitle: true,
        title: Text("Wi-Fi"),
        actions: [
          Switch(value: true, onChanged: (val) {}),
          SizedBox(
            width: 8,
          ),
        ], */
      ),
    );
  }
}

// Language

class QsLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Language",
        onTap: () {},
        withSwitch: false,
      ),
      body: ListView.builder(
        itemCount: Locales.supported.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            Locales.supported[index].toLanguageTag(),
          ),
          onTap: () {
            context.setLocale(Locales.supported[index]);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// Theme

class QsTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: QsAppBar(
          title: "Dark Mode",
          value: _pref.darkMode,
          onTap: () {
            _pref.darkMode = !_pref.darkMode;
          },
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: SettingsPresets.accentColorPresets.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                _pref.accentColor =
                    SettingsPresets.accentColorPresets[index].color.value;
              },
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              leading: AccentColorIcon(
                color: SettingsPresets.accentColorPresets[index].color,
              ),
              title: Text(SettingsPresets.accentColorPresets[index].label),
            );
          },
        ));
  }
}

class AccentColorIcon extends StatelessWidget {
  final Color? color;

  const AccentColorIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: true);
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CircleAvatar(
              backgroundColor: color ?? Theme.of(context).colorScheme.secondary,
              child: Icon(
                  color != null
                      ? _data.accentColor == color?.value
                          ? Icons.blur_circular
                          : null
                      : Icons.add,
                  color: DatabaseManager.get("darkMode")
                      ? Colors.black
                      : Colors.white)),
        ),
      ),
    );
  }
}
