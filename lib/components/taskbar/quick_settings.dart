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
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:pangolin/services/power.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/widgets/battery_indicator.dart';
import 'package:pangolin/widgets/separated_flex.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QuickSettingsButton extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  const QuickSettingsButton({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final theme = Theme.of(context);
    return TaskbarElement(
      iconSize: 18,
      overlayID: QuickSettingsOverlay.overlayId,
      height: 40.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: ShellService.current
              .getShowingNotifier(QuickSettingsOverlay.overlayId),
          builder: (context, showing, child) {
            final foregroundColor =
                showing ? theme.accentForegroundColor : theme.foregroundColor;
            return SeparatedFlex(
              axis: Axis.horizontal,
              separator: const SizedBox(width: 8),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...items(context, foregroundColor, service),
                VerticalDivider(
                  width: 2,
                  endIndent: 12,
                  indent: 12,
                  color: foregroundColor,
                ),
                SizedBox(
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
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> items(
    BuildContext context,
    Color foregroundColor,
    CustomizationService service,
  ) {
    return [
      if (service.enableWifi) const Icon(Icons.wifi),
      if (service.enableBluetooth) const Icon(Icons.bluetooth),
      const Icon(Icons.settings_ethernet),
      if (PowerService.current.hasBattery)
        PowerServiceBuilder(
          builder: (context, child, percentage, charging, powerSaver) {
            return BatteryIndicator(
              percentage: percentage,
              charging: charging,
              color: foregroundColor,
              powerSaving: powerSaver,
              size: 18,
            );
          },
        ),
    ];
  }
}
