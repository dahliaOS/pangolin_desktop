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
import 'package:pangolin/components/overlays/keyboard_overlay.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/services/shell.dart';

class KeyboardButton extends StatelessWidget {
  const KeyboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 96,
      width: 48,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          type: MaterialType.transparency,
          shape: Constants.smallShape,
          child: ValueListenableBuilder<bool>(
            valueListenable: ShellService.current
                .getShowingNotifier(QuickSettingsOverlay.overlayId),
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
              onTap: () => showKeyboard(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Center(
                  child: Row(
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
