import 'package:collection/collection.dart';
import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/taskbar/taskbar_item.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/wm/properties.dart';

class AppListElement extends StatefulWidget {
  const AppListElement({super.key});

  @override
  State<AppListElement> createState() => _AppListElementState();
}

class _AppListElementState extends State<AppListElement> {
  CustomizationService get customization => CustomizationService.current;
  WindowManagerService get wm => WindowManagerService.current;

  final List<_AppSlot> _slots = [];

  List<String> get _pinnedApps =>
      _slots.where((e) => e.pinned).map((e) => e.id).toList();

  List<String> get _runningApps =>
      _slots.where((e) => e.running).map((e) => e.id).toList();

  @override
  void initState() {
    super.initState();
    _onPinnedAppsChanged();
    _onCurrentEntriesChanged();
    customization.addListener(_onPinnedAppsChanged);
    wm.controller.addListener(_onCurrentEntriesChanged);
  }

  @override
  void dispose() {
    customization.removeListener(_onPinnedAppsChanged);
    wm.controller.removeListener(_onCurrentEntriesChanged);
    super.dispose();
  }

  void _onPinnedAppsChanged() {
    if (listEquals(customization.pinnedApps, _pinnedApps)) return;

    final diff = calculateListDiff(
      _pinnedApps,
      customization.pinnedApps,
      detectMoves: false,
    );

    for (final update in diff.getUpdatesWithData()) {
      update.when(
        insert: (position, data) {
          // A pinned shortcut refers to an app that can't be found for whatever
          // reason, so we just skip it
          if (ApplicationService.current.getApp(data) == null) return;

          final runningItem =
              _slots.firstWhereOrNull((e) => e.id == data && e.running);

          if (runningItem != null) {
            final index = _slots.indexOf(runningItem);
            _slots[index] = runningItem.copyWith(pinned: true);
          } else {
            _slots.add(_AppSlot(id: data, pinned: true, running: false));
          }

          setState(() {});
        },
        remove: (position, data) {
          final runningItem =
              _slots.firstWhereOrNull((e) => e.id == data && e.running);

          if (runningItem != null) {
            final index = _slots.indexOf(runningItem);
            _slots[index] = runningItem.copyWith(pinned: false);
          } else {
            _slots.removeWhere((e) => e.id == data);
          }

          setState(() {});
        },
        change: (position, oldData, newData) {},
        move: (from, to, data) {},
      );
    }
  }

  void _onCurrentEntriesChanged() {
    final entries =
        wm.controller.entries.map((e) => e.registry.extra.appId).toList();

    final diff = calculateListDiff(
      _runningApps,
      entries,
      detectMoves: false,
    );

    for (final update in diff.getUpdatesWithData()) {
      update.when(
        insert: (position, data) {
          final pinnedItem =
              _slots.firstWhereOrNull((e) => e.id == data && e.pinned);

          if (pinnedItem != null) {
            final index = _slots.indexOf(pinnedItem);
            _slots[index] = pinnedItem.copyWith(running: true);
          } else {
            _slots.add(
              _AppSlot(
                id: data,
                pinned: false,
                running: true,
              ),
            );
          }

          setState(() {});
        },
        remove: (position, data) {
          final item = _slots.firstWhereOrNull((e) => e.id == data);

          if (item == null) return;

          if (item.pinned) {
            _slots[position] = item.copyWith(running: false);
          } else {
            _slots.remove(item);
          }

          setState(() {});
        },
        change: (position, oldData, newData) {},
        move: (from, to, data) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }

        final item = _slots[oldIndex];
        _slots
          ..removeAt(oldIndex)
          ..insert(newIndex, item);

        setState(() {});

        if (item.pinned) {
          // if a pinned item is moved then we might need to update the order
          // it's saved inside the preferences, time to check

          final orderChanged =
              !listEquals(_pinnedApps, customization.pinnedApps);

          if (orderChanged) {
            customization.pinnedApps = _pinnedApps;
          }
        }
      },
      buildDefaultDragHandles: false,
      proxyDecorator: (child, index, animation) {
        return child;
      },
      itemBuilder: (context, index) => ReorderableDragStartListener(
        key: ValueKey(_slots[index]),
        index: index,
        child: TaskbarItem(packageName: _slots[index].id),
      ),
      itemCount: _slots.length,
    );
  }
}

class _AppSlot {
  const _AppSlot({
    required this.id,
    required this.pinned,
    required this.running,
  });
  final String id;
  final bool pinned;
  final bool running;

  _AppSlot copyWith({
    String? id,
    bool? pinned,
    bool? running,
  }) {
    return _AppSlot(
      id: id ?? this.id,
      pinned: pinned ?? this.pinned,
      running: running ?? this.running,
    );
  }
}
