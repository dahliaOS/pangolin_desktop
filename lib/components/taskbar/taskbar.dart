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

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:pangolin/components/overlays/launcher/launcher_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/components/taskbar/taskbar_item.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/services.dart';

class Taskbar extends StatefulWidget {
  final List<Widget>? leading;
  final List<Widget>? trailing;

  const Taskbar({
    required this.leading,
    required this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  _TaskbarState createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar>
    with StateServiceListener<CustomizationService, Taskbar> {
  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final List<String> pinnedApps = service.pinnedApps;
    final List<String> taskbarApps = pinnedApps.toList()
      ..addAll(
        WindowHierarchy.of(context)
            .entries
            .map<String>(
              (e) => pinnedApps.contains(e.registry.extra.stableId)
                  ? ""
                  : e.registry.extra.stableId,
            )
            .toList(),
      );

    final Widget items = ReorderableListView(
      shrinkWrap: true,
      primary: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = taskbarApps.removeAt(oldIndex);
          taskbarApps.insert(newIndex, item);
          if (pinnedApps.contains(item)) {
            service.pinnedApps = pinnedApps;
          } else {
            setState(() {
              pinnedApps.add(item);
              service.pinnedApps = pinnedApps;
            });
          }
        });
      },
      children: taskbarApps
          .map<Widget>(
            (e) => e != ""
                ? TaskbarItem(key: ValueKey(e), packageName: e)
                : SizedBox.shrink(
                    key: ValueKey(Random()),
                  ),
          )
          .toList(),
    );
    double scroll = 0;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 48,
      child: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            // do something when scrolled
            setState(() {
              scroll = scroll + pointerSignal.scrollDelta.dy;
            });
            if (scroll > 500) {
              Shell.of(context).dismissOverlay(LauncherOverlay.overlayId);
            }
          }
        },
        // TODO Fix taskbar background position
        /* child: ContextMenuRegion(
          contextMenu: ContextMenu(
            items: [
              const ContextMenuItem(
                icon: Icons.power_input_sharp,
                title: "Taskbar Position",
                onTap: null,
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_drop_down_rounded,
                title: "Bottom",
                onTap: () {
                  _customizationProvider.taskbarPosition = 2.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_drop_up_rounded,
                title: "Top",
                onTap: () {
                  _customizationProvider.taskbarPosition = 0.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_left_rounded,
                title: "Left",
                onTap: () {
                  _customizationProvider.taskbarPosition = 1.0;
                },
                shortcut: "",
              ),
              ContextMenuItem(
                icon: Icons.arrow_right_rounded,
                title: "Right",
                onTap: () {
                  _customizationProvider.taskbarPosition = 3.0;
                },
                shortcut: "",
              ),
            ],
          ), */
        child: BoxContainer(
          opacity: 0.25,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Stack(
                children: [
                  const SizedBox.shrink(),
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.leading ?? [const SizedBox.shrink()],
                      ),
                      Expanded(
                        child: listenerWrapper(items),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.trailing ?? [const SizedBox.shrink()],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      /* ), */
    );
  }

  Widget listenerWrapper(Widget child) {
    return SizedBox.expand(
      child: Listener(
        onPointerDown: (event) {
          Shell.of(context, listen: false).dismissEverything();
        },
        behavior: HitTestBehavior.translucent,
        child: SizedBox.shrink(child: child),
      ),
    );
  }
}
