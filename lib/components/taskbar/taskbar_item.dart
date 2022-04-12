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

import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/context_menus/core/context_menu_region.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/utils/wm/wm_api.dart';

class TaskbarItem extends StatefulWidget {
  final String packageName;
  const TaskbarItem({required this.packageName, Key? key}) : super(key: key);

  @override
  _TaskbarItemState createState() => _TaskbarItemState();
}

class _TaskbarItemState extends State<TaskbarItem>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    //Selected App
    final _app = applications
        .firstWhere((element) => element.packageName == widget.packageName);

    //Running apps
    //// ITS FAILING HERE
    final hierarchy = WindowHierarchy.of(context);
    final windows = hierarchy.entries;
    //Check if App is running or just pinned
    final bool appIsRunning = windows.any(
      (element) => element.registry.extra.stableId == widget.packageName,
    );
    //get the WindowEntry when the App is running
    final LiveWindowEntry? entry = appIsRunning
        ? windows.firstWhere(
            (element) => element.registry.extra.stableId == widget.packageName,
          )
        : null;
    //check if the App is focused
    final LiveWindowEntry? focusedEntry = appIsRunning
        ? windows.firstWhere(
            (element) =>
                element.registry.extra.stableId ==
                hierarchy.sortedEntries.last.registry.extra.stableId,
          )
        : null;
    final bool focused = windows.length > 1
        ? focusedEntry?.registry.extra.stableId == widget.packageName &&
            !windows.last.layoutState.minimized
        : true;

    final bool showSelected =
        appIsRunning ? focused && !entry!.layoutState.minimized : false;

    if (showSelected) {
      _ac.animateTo(1);
    } else {
      _ac.animateBack(0);
    }

    final _customizationProvider = CustomizationProvider.of(context);
    //Build Widget
    final Widget finalWidget = LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
        child: SizedBox(
          height: 44,
          width: 42,
          child: ContextMenuRegion(
            centerAboveElement: true,
            useLongPress: false,
            contextMenu: ContextMenu(
              items: [
                ContextMenuItem(
                  icon: Icons.info_outline_rounded,
                  title: _app.name ?? "Error",
                  onTap: () {},
                  shortcut: "",
                ),
                ContextMenuItem(
                  icon: Icons.push_pin_outlined,
                  title: _customizationProvider.pinnedApps
                          .contains(_app.packageName)
                      ? "Unpin from Taskbar"
                      : "Pin to Taskbar",
                  onTap: () {
                    _customizationProvider.togglePinnedApp(_app.packageName);
                  },
                  shortcut: "",
                ),
                if (appIsRunning)
                  ContextMenuItem(
                    icon: Icons.close_outlined,
                    title: "Close Window",
                    onTap: () => WmAPI.of(context)
                        .popWindowEntry(entry!.registry.info.id),
                    shortcut: "",
                  ),
              ],
            ),
            child: GestureDetector(
              //key: _globalKey,
              child: Material(
                borderRadius: BorderRadius.circular(4),
                //set a background color if the app is running or focused
                color: appIsRunning
                    ? (showSelected
                        ? Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color
                            ?.withOpacity(0.2)
                        : Theme.of(context).backgroundColor.withOpacity(0.0))
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
                      WmAPI.of(context).openApp(widget.packageName);
                      //print(packageName);
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _anim,
                    builder: (context, child) => Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 5, 6, 7),
                            child: Image(
                              image: appIsRunning
                                  ? entry?.registry.info.icon ??
                                      const NetworkImage("")
                                  : AssetImage(
                                      "assets/icons/${_app.iconName}.png",
                                    ),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    if (!_app.canBeOpened) {
      return IgnorePointer(
        child: Opacity(
          opacity: 0.4,
          child: finalWidget,
        ),
      );
    }
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
