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
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:pangolin/widgets/resource/auto_image.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class TaskbarItem extends StatefulWidget {
  final DesktopEntry entry;

  const TaskbarItem({required this.entry, super.key});

  @override
  _TaskbarItemState createState() => _TaskbarItemState();
}

class _TaskbarItemState extends State<TaskbarItem>
    with
        SingleTickerProviderStateMixin,
        StateServiceListener<CustomizationService, TaskbarItem> {
  late AnimationController _ac;
  late Animation<double> _anim;
  bool _hovering = false;
  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _anim = CurvedAnimation(
      parent: _ac,
      curve: Curves.ease,
      reverseCurve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final hierarchy = WindowManagerService.current.controller;
    final windows = hierarchy.entries;
    //Check if App is running or just pinned
    final bool appIsRunning = windows.any(
      (element) => element.registry.extra.appId == widget.entry.id,
    );
    //get the WindowEntry when the App is running
    final LiveWindowEntry? entry = appIsRunning
        ? windows.firstWhere(
            (element) => element.registry.extra.appId == widget.entry.id,
          )
        : null;
    //check if the App is focused
    final LiveWindowEntry? focusedEntry = appIsRunning
        ? windows.firstWhere(
            (element) =>
                element.registry.extra.appId ==
                hierarchy.sortedEntries.last.registry.extra.appId,
          )
        : null;
    final bool focused = windows.length > 1 &&
        (focusedEntry?.registry.extra.appId == widget.entry.id &&
            !windows.last.layoutState.minimized);

    final bool showSelected =
        appIsRunning && focused && !entry!.layoutState.minimized;

    if (showSelected) {
      _ac.animateTo(1);
    } else {
      _ac.animateBack(0);
    }

    //Build Widget
    final Widget finalWidget = LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
        child: SizedBox(
          height: 44,
          width: 42,
          child: ContextMenu(
            entries: [
              ContextMenuItem(
                leading: const Icon(Icons.info_outline_rounded),
                child: Text(widget.entry.name.resolve(context.locale)),
                onTap: () {},
              ),
              ContextMenuItem(
                leading: const Icon(Icons.push_pin_outlined),
                child: Text(
                  service.pinnedApps.contains(widget.entry.id)
                      ? "Unpin from Taskbar"
                      : "Pin to Taskbar",
                ),
                onTap: () {
                  service.togglePinnedApp(widget.entry.id);
                },
              ),
              if (appIsRunning)
                ContextMenuItem(
                  leading: const Icon(Icons.close_outlined),
                  child: const Text("Close Window"),
                  onTap: () =>
                      WindowManagerService.current.pop(entry!.registry.info.id),
                ),
            ],
            child: Material(
              borderRadius: BorderRadius.circular(4),
              color: appIsRunning
                  ? (showSelected
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color
                          ?.withOpacity(0.2)
                      : Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.0))
                  : Colors.transparent,
              child: InkWell(
                onHover: (value) {
                  _hovering = value;
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  //open the app or toggle
                  if (appIsRunning) {
                    _onTap(context, entry!);
                  } else {
                    ApplicationService.current.startApp(widget.entry.id);
                    //print(packageName);
                  }
                },
                child: AnimatedBuilder(
                  animation: _anim,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 5, 6, 7),
                            child: appIsRunning
                                ? Image(
                                    image: entry?.registry.info.icon ??
                                        const NetworkImage(""),
                                  )
                                : AutoVisualResource(
                                    resource: widget.entry.icon!.main,
                                    size: 36,
                                  ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.ease,
                          bottom: 1,
                          left: appIsRunning
                              ? _hovering
                                  ? showSelected
                                      ? 4
                                      : 8
                                  : showSelected
                                      ? 4
                                      : constraints.maxHeight / 2 - 8
                              : 50 / 2,
                          right: appIsRunning
                              ? _hovering
                                  ? showSelected
                                      ? 4
                                      : 8
                                  : showSelected
                                      ? 4
                                      : constraints.maxHeight / 2 - 8
                              : 50 / 2,
                          height: 3,
                          child: Material(
                            borderRadius: BorderRadius.circular(2),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return finalWidget;
  }

  void _onTap(BuildContext context, LiveWindowEntry entry) {
    final hierarchy = WindowHierarchy.of(context, listen: false);
    final windows = hierarchy.entriesByFocus;

    final bool focused = hierarchy.isFocused(entry.registry.info.id);
    setState(() {});
    if (focused && !entry.layoutState.minimized) {
      entry.layoutState.minimized = true;
      if (windows.length > 1) {
        hierarchy.requestEntryFocus(
          windows[windows.length - 2].registry.info.id,
        );
      }
      setState(() {});
    } else {
      entry.layoutState.minimized = false;
      hierarchy.requestEntryFocus(entry.registry.info.id);
      setState(() {});
    }
  }
}
