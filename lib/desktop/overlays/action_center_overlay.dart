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
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/qs_button.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class ActionCenterOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _wm = context.watch<WindowHierarchyState>();
    return Builder(builder: (context) {
      final _ac = context.watch<DismissibleOverlayEntry>().animation;
      return AnimatedBuilder(
          animation: _ac,
          builder: (context, child) {
            return Positioned(
              bottom: _wm.insets.bottom + 20,
              left: horizontalPadding(context, 500),
              right: horizontalPadding(context, 500),
              child: BoxContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                useSystemOpacity: true,
                color: Theme.of(context).scaffoldBackgroundColor,
                customBorderRadius: BorderRadius.circular(10),
                width: 500,
                height: 320 * _ac.value,
                //margin: EdgeInsets.only(bottom: wmKey.currentState!.insets.bottom + 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: Column(
                        children: [
                          BoxContainer(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            useSystemOpacity: true,
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(Icons.power_settings_new_rounded),
                                  mouseCursor: SystemMouseCursors.click,
                                ),
                                Text(
                                  "Action Center",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                InkWell(
                                  child: Icon(Icons.settings_outlined),
                                  mouseCursor: SystemMouseCursors.click,
                                  onTap: () {
                                    WmAPI(context).popOverlayEntry(
                                        Provider.of<DismissibleOverlayEntry>(
                                            context,
                                            listen: false));
                                    WmAPI(context)
                                        .openApp("io.dahlia.settings");
                                    /* WmAPI(context).pushWindowEntry(
                                    WindowEntry.withDefaultToolbar(
                                        content: Settings(),
                                        initialSize: Size(1280, 720))); */
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              QuickSettingsButton(
                                  title: "Power\nMode",
                                  icon: Icons.battery_charging_full_outlined),
                              QuickSettingsButton(
                                title: "Blue light\nfilter",
                                icon: Icons.brightness_4,
                              ),
                              QuickSettingsButton(
                                  title: "Ambient\nDisplay",
                                  icon: Icons.access_time_outlined),
                              QuickSettingsButton(
                                title: "Screen\nRecorder",
                                icon: Icons.fiber_manual_record_outlined,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Icon(Icons.volume_down),
                              ),
                              SizedBox(
                                width: 360,
                                child: Slider(
                                  onChanged: (details) {},
                                  value: 0.5,
                                ),
                              ),
                              InkWell(
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Icon(Icons.brightness_5),
                              ),
                              SizedBox(
                                width: 360,
                                child: Slider(
                                  onChanged: (details) {},
                                  value: 0.5,
                                ),
                              ),
                              InkWell(
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
