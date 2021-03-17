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
import 'package:pangolin/widgets/qs_button.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class ActionCenterOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48 + 8,
      right: 8,
      child: BoxContainer(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 50)
            ],
            border:
                Border.all(color: Theme.of(context).backgroundColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        useSystemOpacity: true,
        color: Theme.of(context).backgroundColor,
        width: 500,
        height: 328,
        child: SizedBox(
          height: 48,
          child: Column(
            children: [
              BoxContainer(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).backgroundColor,
                useSystemOpacity: true,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(Icons.edit),
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    Text(
                      "Connections",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    InkWell(
                      child: Icon(Icons.settings_outlined),
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        WmAPI(context).popOverlayEntry(
                            Provider.of<DismissibleOverlayEntry>(context,
                                listen: false));
                        WmAPI(context).openApp("io.dahlia.settings");
                        /* WmAPI(context).pushWindowEntry(
                                WindowEntry.withDefaultToolbar(
                                    content: Settings(),
                                    initialSize: Size(1280, 720))); */
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                width: 500,
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24),
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  children: [
                    QuickSettingsButton(
                      //TODO fix locale-gen loader
                      title: LocaleStrings.qs.wifi,
                      icon: Icons.signal_wifi_4_bar_rounded,
                    ),
                    QuickSettingsButton(
                      title: LocaleStrings.qs.bluetooth,
                      icon: Icons.bluetooth_connected_outlined,
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
                      title: "Nearby\nShare",
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
    );
  }
}
