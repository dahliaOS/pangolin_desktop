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
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/taskbar/taskbar_element.dart';
import 'package:provider/provider.dart';

class QuickSettingsButton extends StatelessWidget {
  const QuickSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return TaskbarElement(
      iconSize: 18,
      size: Size.fromWidth(
          96 + (_pref.wifi ? 28 : 0) + (_pref.bluetooth ? 28 : 0) + 32 + 32),
      overlayID: QuickSettingsOverlay.overlayId,
      child: _pref.isTaskbarHorizontal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items(context)
                ..add(
                  Padding(
                    padding: _pref.isTaskbarHorizontal
                        ? EdgeInsets.symmetric(horizontal: 8.0)
                        : EdgeInsets.symmetric(vertical: 8.0),
                    child: ValueListenableBuilder(
                      valueListenable: DateTimeManager.getTimeNotifier()!,
                      builder: (BuildContext context, String time, child) {
                        return Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                  ),
                ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items(context)
                ..add(
                  Padding(
                    padding: _pref.isTaskbarHorizontal
                        ? EdgeInsets.symmetric(horizontal: 8.0)
                        : EdgeInsets.symmetric(vertical: 8.0),
                    child: ValueListenableBuilder(
                      valueListenable: DateTimeManager.getTimeNotifier()!,
                      builder: (BuildContext context, String time, child) {
                        return Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ),
    );
  }

  List<Widget> items(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return [
      _pref.wifi
          ? Padding(
              padding: _pref.isTaskbarHorizontal
                  ? EdgeInsets.symmetric(horizontal: 4.0)
                  : EdgeInsets.symmetric(vertical: 4.0),
              child: Icon(
                Icons.wifi,
              ),
            )
          : SizedBox.shrink(),
      _pref.bluetooth
          ? Padding(
              padding: _pref.isTaskbarHorizontal
                  ? EdgeInsets.symmetric(horizontal: 4.0)
                  : EdgeInsets.symmetric(vertical: 4.0),
              child: Icon(
                Icons.bluetooth,
              ),
            )
          : SizedBox.shrink(),
      Padding(
        padding: _pref.isTaskbarHorizontal
            ? EdgeInsets.symmetric(horizontal: 4.0)
            : EdgeInsets.symmetric(vertical: 4.0),
        child: Icon(
          Icons.settings_ethernet,
        ),
      ),
      Padding(
        padding: _pref.isTaskbarHorizontal
            ? EdgeInsets.symmetric(horizontal: 4.0)
            : EdgeInsets.symmetric(vertical: 4.0),
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.battery_charging_full,
          ),
        ),
      ),
      VerticalDivider(
        indent: 8,
        endIndent: 8,
        color: context.theme.textColor.withOpacity(0.25),
      ),
    ];
  }
}
