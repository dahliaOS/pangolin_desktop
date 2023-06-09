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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QuickSettingsButton extends StatelessWidget with StatelessServiceListener<CustomizationService> {
  const QuickSettingsButton({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final theme = ZenitTheme.of(context);
    return TaskbarElement(
      iconSize: 18,
      size: Size.fromWidth(
        148 + (service.enableWifi ? 26 : 0) + (service.enableBluetooth ? 26 : 0),
      ),
      overlayID: QuickSettingsOverlay.overlayId,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: Shell.of(context).getShowingNotifier(QuickSettingsOverlay.overlayId),
          builder: (context, showing, child) {
            final foregroundColor = showing ? theme.accentForegroundColor : theme.foregroundColor;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...items(context, service),
                VerticalDivider(
                  width: 2,
                  endIndent: 12,
                  indent: 12,
                  color: foregroundColor,
                ),
                SizedBox(
                  width: 74,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListenableServiceBuilder<DateTimeService>(
                      builder: (BuildContext context, _) {
                        final DateTimeService service = DateTimeService.current;
                        return Text(
                          service.formattedTime,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: foregroundColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> items(BuildContext context, CustomizationService service) {
    return [
      if (service.enableWifi)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.wifi),
        ),
      if (service.enableBluetooth)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.bluetooth),
        ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Icon(
          Icons.settings_ethernet,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.battery_charging_full),
        ),
      ),
      const SizedBox(width: 4),
    ];
  }
}
