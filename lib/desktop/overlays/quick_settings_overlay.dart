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
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/widgets/qs_button.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class QuickSettingsOverlay extends StatefulWidget {
  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

class _QuickSettingsOverlayState extends State<QuickSettingsOverlay> {
  @override
  Widget build(BuildContext context) {
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
              ], borderRadius: BorderRadius.circular(5)),
              useSystemOpacity: true,
              color: Theme.of(context).backgroundColor,
              width: 500,
              height: 500,
              child: SizedBox(
                height: 48,
                child: Column(
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
                    SizedBox(
                      height: 380,
                      width: 500,
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        crossAxisCount: 5,
                        mainAxisSpacing: 10,
                        children: [
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
                            title: "Ethernet",
                            icon: Icons.settings_ethernet,
                          ),
                          QuickSettingsButton(
                            title: "LTE",
                            icon: Icons.signal_cellular_4_bar_rounded,
                          ),
                          QuickSettingsButton(
                            title: "Location",
                            icon: Icons.location_on_rounded,
                          ),
                          QuickSettingsButton(
                            title: "NearbyShare",
                            icon: Icons.ios_share,
                          ),
                          QuickSettingsButton(
                            title: "Screen\nSharing",
                            icon: Icons.screen_share,
                          ),
                          QuickSettingsButton(
                            color: Colors.grey[850],
                            title: LocaleStrings.qs.airplanemode,
                            icon: Icons.airplanemode_active,
                          ),
                        ],
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
