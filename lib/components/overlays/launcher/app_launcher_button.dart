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
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:pangolin/widgets/resource/auto_image.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class AppLauncherButton extends StatelessWidget {
  final DesktopEntry application;

  const AppLauncherButton({required this.application, super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: application.getLocalizedComment(context.locale) ?? "",
      waitDuration: const Duration(seconds: 1),
      preferBelow: true,
      verticalOffset: 80,
      child: SizedBox(
        height: 128,
        width: 128,
        child: Material(
          color: Colors.transparent,
          shape: Constants.mediumShape,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onLongPress: () =>
                CustomizationService.current.togglePinnedApp(application.id),
            onTap: () async {
              await ApplicationService.current.startApp(application.id);
              ShellService.current.dismissEverything();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoVisualResource(
                  resource: application.icon?.main ?? "",
                  size: 64,
                ),
                Text(
                  application.getLocalizedName(context.locale),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLauncherTile extends StatefulWidget {
  final DesktopEntry application;

  const AppLauncherTile({
    required this.application,
    super.key,
  });

  @override
  State<AppLauncherTile> createState() => _AppLauncherTileState();
}

class _AppLauncherTileState extends State<AppLauncherTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() => _hover = true),
      onExit: (details) => setState(() => _hover = false),
      child: GestureDetector(
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            shape: Constants.smallShape,
            dense: true,
            leading: SizedBox.fromSize(
              size: const Size.square(32),
              child: AutoVisualResource(
                resource: widget.application.icon?.main ?? "",
                size: 32,
              ),
            ),
            title: Text(
              widget.application.getLocalizedName(context.locale),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: widget.application.comment != null
                ? Text(
                    widget.application.getLocalizedComment(context.locale)!,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: Offstage(
              offstage: !_hover,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuickActionButton(
                    size: 32,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: const Icon(Icons.push_pin_rounded),
                    onPressed: () {
                      CustomizationService.current
                          .togglePinnedApp(widget.application.id);
                    },
                  ),
                  const QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.settings_outlined),
                  ),
                  const QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
            ),
            onTap: () async {
              await ApplicationService.current.startApp(widget.application.id);
              if (mounted) ShellService.current.dismissEverything();
            },
          ),
        ),
      ),
    );
  }
}
