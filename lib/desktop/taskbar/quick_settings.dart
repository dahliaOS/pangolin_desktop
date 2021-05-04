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
import 'package:pangolin/desktop/overlays/quicksettings/quick_settings_overlay.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';
import 'package:pangolin/utils/preference_extension.dart';

class QuickSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return SizedBox(
      //width: 96,
      width: _pref.isTaskbarHorizontal ? null : 48,
      height: _pref.isTaskbarHorizontal ? 48 : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          color: Provider.of<WindowHierarchyState>(context)
                  .overlayIsActive("action_center")
              ? Theme.of(context).accentColor
              : Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            hoverColor: Theme.of(context).accentColor.withOpacity(0.5),
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                  uniqueId: "action_center",
                  content: QuickSettingsOverlay(),
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Center(
                child: _pref.isTaskbarHorizontal
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: items(context))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: items(context),
                      ),
              ),
            ),
          ),
        ),
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
