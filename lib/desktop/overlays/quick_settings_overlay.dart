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
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/qs_button.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class QuickSettingsOverlay extends StatefulWidget {
  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

class _QuickSettingsOverlayState extends State<QuickSettingsOverlay> {
  double brightness = 0.8;
  double volume = 0.5;
  /*String _dateString;
  String _timeString;
  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now(), 'h:mm');
    _dateString = _formatDateTime(DateTime.now(), 'd MMMM yyyy');

    Timer.periodic(Duration(milliseconds: 100), (Timer t) => _getTime(context));
  }

  void _getTime(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now, 'h:mm');
    final String formattedDate = _formatLocaleDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  String _formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }

  //Format date using language
  String _formatLocaleDate(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }*/

  @override
  Widget build(BuildContext context) {
    // _getTime(context);
    final _animation =
        Provider.of<DismissibleOverlayEntry>(context, listen: false).animation;
    return Positioned(
      bottom: 48 + 8,
      right: 8,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, chilld) => FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            alignment: FractionalOffset(0.8, 1.0),
            child: BoxContainer(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 50)
              ], borderRadius: BorderRadius.circular(10)),
              useSystemOpacity: true,
              color: Theme.of(context).backgroundColor,
              width: 500,
              height: 480,
              child: SizedBox(
                height: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxContainer(
                      color: Theme.of(context).backgroundColor,
                      useSystemOpacity: true,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: new CircleAvatar(
                              radius: 13,
                              backgroundImage: AssetImage(
                                "assets/images/other/null.png",
                              ),
                            ),
                          ),
                          new Text(
                            "Live Session",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          InkWell(
                            child: Icon(Icons.keyboard_arrow_down),
                            mouseCursor: SystemMouseCursors.click,
                          ),
                          new Expanded(
                            child: new Container(),
                          ),
                          InkWell(
                            child: Icon(Icons.settings_outlined),
                            mouseCursor: SystemMouseCursors.click,
                            onTap: () {
                              WmAPI.of(context).popOverlayEntry(
                                  Provider.of<DismissibleOverlayEntry>(context,
                                      listen: false));
                              WmAPI.of(context).openApp("io.dahlia.settings");
                              /* WmAPI.of(context).pushWindowEntry(
                                      WindowEntry.withDefaultToolbar(
                                          content: Settings(),
                                          initialSize: Size(1280, 720))); */
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: InkWell(
                              child: Icon(Icons.power_settings_new),
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                WmAPI.of(context).popOverlayEntry(
                                    Provider.of<DismissibleOverlayEntry>(
                                        context,
                                        listen: false));
                                WmAPI.of(context)
                                    .pushOverlayEntry(DismissibleOverlayEntry(
                                        uniqueId: "power_menu",
                                        content: PowerOverlay(),
                                        duration: Duration.zero,
                                        background: BoxContainer(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor
                                              .withOpacity(0.5),
                                          useBlur: false,
                                        )));
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Quick Controls",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      height: 200,
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                        crossAxisCount: 5,
                        mainAxisSpacing: 10,
                        children: [
                          QuickSettingsButton(
                            title: LocaleStrings.qs.wifi,
                            icon: Icons.network_wifi,
                          ),
                          QuickSettingsButton(
                            //TODO fix locale-gen loader
                            title: '85%',
                            icon: Icons.battery_full,
                          ),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.dnd,
                            icon: Icons.do_not_disturb_off,
                          ),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.flashlight,
                            icon: Icons.lightbulb_outline,
                          ),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.autorotate,
                            icon: Icons.screen_lock_rotation,
                          ),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.bluetooth,
                            icon: Icons.bluetooth,
                          ),
                          QuickSettingsButton(
                              title: LocaleStrings.qs.airplanemode,
                              icon: Icons.airplanemode_inactive),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.invertcolors,
                            icon: Icons.invert_colors_off,
                          ),
                          QuickSettingsButton(
                            title: LocaleStrings.qs.changelanguage,
                            icon: Icons.language,
                            //TODO ADD LANGUAGE CHANGER HERE
                          ),
                          QuickSettingsButton(
                            title: 'TTY Shell',
                            icon: Icons.developer_mode,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            actionChip(Icons.more_time, "Reminder", context),
                            actionChip(Icons.info_outline, totalVersionNumber,
                                context),
                            actionChip(Icons.domain_verification, "dahliaOS.io",
                                context),
                            //actionChip(Icons.add, null, context)
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                                      value: brightness,
                                      divisions: 10,
                                      onChanged: (newBrightness) {
                                        setState(() {
                                          brightness = newBrightness;
                                        });
                                      }),
                                ),
                                Container(
                                  width: 35,
                                  child: Center(
                                    child: Text(
                                        "${(brightness * 100).toInt().toString()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
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
                                    value: volume,
                                    divisions: 20,
                                    onChanged: (newVolume) {
                                      setState(() {
                                        volume = newVolume;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  child: Center(
                                    child: Text(
                                        "${(volume * 100).toInt().toString()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable:
                                        DateTimeManager.getTimeNotifier()!,
                                    builder: (BuildContext context, String time,
                                        Widget? child) {
                                      return Text(
                                        time,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      );
                                    },
                                  ),
                                  //Icon(Icons.brightness_1, size: 10.0,color: Colors.white),
                                  Text('  |  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  ValueListenableBuilder(
                                    valueListenable:
                                        DateTimeManager.getTimeNotifier()!,
                                    builder: (BuildContext context, String date,
                                        Widget? child) {
                                      return Text(
                                        DateTimeManager.getDate().toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
