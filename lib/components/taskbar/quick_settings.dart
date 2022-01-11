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

import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/other/date_time_manager.dart';
import 'package:pangolin/utils/providers/connection_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class QuickSettingsButton extends StatelessWidget {
  const QuickSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    final _connectionProv = ConnectionProvider.of(context);
    return TaskbarElement(
      iconSize: 18,
      size: Size.fromWidth(
        70 +
            24 +
            6 +
            (_connectionProv.wifi ? 26 : 0) +
            (_connectionProv.bluetooth ? 26 : 0) +
            26 +
            26,
      ),
      overlayID: QuickSettingsOverlay.overlayId,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items(context)
            ..add(
              SizedBox(
                width: 74,
                child: Padding(
                  padding: _customizationProvider.isTaskbarHorizontal
                      ? const EdgeInsets.symmetric(horizontal: 8.0)
                      : const EdgeInsets.symmetric(vertical: 8.0),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: Shell.of(context)
                        .getShowingNotifier(QuickSettingsOverlay.overlayId),
                    builder: (context, showing, child) =>
                        ValueListenableBuilder(
                      valueListenable: DateTimeManager.getTimeNotifier()!,
                      builder: (BuildContext context, String time, child) {
                        return Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: showing
                                ? context.accentColor.computeLuminance() < 0.3
                                    ? const Color(0xffffffff)
                                    : const Color(0xff000000)
                                : context.theme.darkMode
                                    ? const Color(0xffffffff)
                                    : const Color(0xff000000),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  List<Widget> items(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    final _connectionProv = ConnectionProvider.of(context);

    return [
      if (_connectionProv.wifi)
        Padding(
          padding: _customizationProvider.isTaskbarHorizontal
              ? const EdgeInsets.symmetric(horizontal: 4.0)
              : const EdgeInsets.symmetric(vertical: 4.0),
          child: const Icon(
            Icons.wifi,
          ),
        )
      else
        const SizedBox.shrink(),
      if (_connectionProv.bluetooth)
        Padding(
          padding: _customizationProvider.isTaskbarHorizontal
              ? const EdgeInsets.symmetric(horizontal: 4.0)
              : const EdgeInsets.symmetric(vertical: 4.0),
          child: const Icon(
            Icons.bluetooth,
          ),
        )
      else
        const SizedBox.shrink(),
      Padding(
        padding: _customizationProvider.isTaskbarHorizontal
            ? const EdgeInsets.symmetric(horizontal: 4.0)
            : const EdgeInsets.symmetric(vertical: 4.0),
        child: const Icon(
          Icons.settings_ethernet,
        ),
      ),
      Padding(
        padding: _customizationProvider.isTaskbarHorizontal
            ? const EdgeInsets.symmetric(horizontal: 4.0)
            : const EdgeInsets.symmetric(vertical: 4.0),
        child: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.battery_charging_full,
          ),
        ),
      ),
      const SizedBox(width: 4),
      Container(
        width: 2,
        height: 16,
        decoration: BoxDecoration(
          color: context.theme.darkMode ? Colors.white : Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    ];
  }
}
