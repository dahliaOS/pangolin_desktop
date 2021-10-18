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
import 'package:pangolin/components/overlays/quick_settings_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/widgets/taskbar/taskbar_element.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/components/overlays/keyboard_overlay.dart';
import 'package:pangolin/utils/extensions/preference_extension.dart';

class KeyboardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    final _shell = Shell.of(context);

    return SizedBox(
      //width: 96,
      width: _pref.isTaskbarHorizontal ? null : 48,
      height: _pref.isTaskbarHorizontal ? 48 : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius:
              CommonData.of(context).borderRadius(BorderRadiusType.SMALL),
          child: ValueListenableBuilder<bool>(
            valueListenable:
                _shell.getShowingNotifier(QuickSettingsOverlay.overlayId),
            builder: (context, showing, child) {
              return Material(
                color: showing
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
                child: child,
              );
            },
            child: InkWell(
              hoverColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              mouseCursor: SystemMouseCursors.click,
              onTap: () => ShowKeyboard(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Center(
                  child: _pref.isTaskbarHorizontal
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.keyboard_outlined)])
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.keyboard_outlined)],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuickSettingsButton extends StatelessWidget {
  const QuickSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return TaskbarElement(
      size: Size.fromWidth(104),
      overlayID: QuickSettingsOverlay.overlayId,
      child: _pref.isTaskbarHorizontal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items(context))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items(context),
            ),
    );
  }

  List<Widget> items(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return [
      Padding(
        padding: _pref.isTaskbarHorizontal
            ? EdgeInsets.symmetric(horizontal: 6.0)
            : EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          Icons.settings_ethernet,
          size: 18,
        ),
      ),
      _pref.wifi
          ? Padding(
              padding: _pref.isTaskbarHorizontal
                  ? EdgeInsets.symmetric(horizontal: 6.0)
                  : EdgeInsets.symmetric(vertical: 6.0),
              child: Icon(
                Icons.wifi,
                size: 18,
              ),
            )
          : SizedBox.shrink(),
      _pref.bluetooth
          ? Padding(
              padding: _pref.isTaskbarHorizontal
                  ? EdgeInsets.symmetric(horizontal: 6.0)
                  : EdgeInsets.symmetric(vertical: 6.0),
              child: Icon(
                Icons.bluetooth,
                size: 18,
              ),
            )
          : SizedBox.shrink(),
      Padding(
        padding: _pref.isTaskbarHorizontal
            ? EdgeInsets.symmetric(horizontal: 6.0)
            : EdgeInsets.symmetric(vertical: 6.0),
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.battery_charging_full,
            size: 18,
          ),
        ),
      ),
    ];
  }
}
