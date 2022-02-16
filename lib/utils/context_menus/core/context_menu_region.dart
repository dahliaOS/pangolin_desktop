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

import 'package:flutter/material.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/wm/wm.dart';

class ContextMenuRegion extends StatefulWidget {
  const ContextMenuRegion({
    Key? key,
    required this.contextMenu,
    this.child,
    this.useLongPress = true,
    this.centerAboveElement,
  }) : super(key: key);
  final ContextMenu contextMenu;
  final Widget? child;
  final bool useLongPress;
  final bool? centerAboveElement;

  @override
  _ContextMenuRegionState createState() => _ContextMenuRegionState();
}

class _ContextMenuRegionState extends State<ContextMenuRegion> {
  final GlobalKey _globalKey = GlobalKey();
  static const contextMenuEntry = WindowEntry(
    features: [],
    layoutInfo: FreeformLayoutInfo(
      size: Size(200, 300),
      alwaysOnTop: true,
      alwaysOnTopMode: AlwaysOnTopMode.systemOverlay,
    ),
    properties: {
      WindowExtras.stableId: "shell:context_menu",
      WindowEntry.title: "Context menu",
      WindowEntry.showOnTaskbar: false,
      WindowEntry.icon: null,
    },
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        key: _globalKey,
        behavior: HitTestBehavior.opaque,
        onLongPressStart: (details) {
          if (widget.useLongPress) {
            showOverlay(context, details.globalPosition, constraints);
          } else {
            return;
          }
        },
        onSecondaryTapDown: (details) =>
            showOverlay(context, details.globalPosition, constraints),
        child: widget.child ?? const SizedBox.shrink(),
      ),
    );
  }

  void showOverlay(
    BuildContext context,
    Offset globalPosition,
    BoxConstraints constraints,
  ) {
    final RenderBox _box =
        _globalKey.currentContext!.findRenderObject()! as RenderBox;
    final buttonRect = _box.localToGlobal(Offset.zero);
    final bool centerAboveElement = widget.centerAboveElement ?? false;

    final List<int> _length = List.empty(growable: true);
    for (final ContextMenuItem element in widget.contextMenu.items) {
      _length.add(element.title.characters.length);
    }
    _length.sort();
    final Size size =
        Size(64 + (_length.last * 8.8), widget.contextMenu.items.length * 44);
    final double x;
    final double y;

    if (centerAboveElement) {
      x = max(
        4.0,
        min(
          MediaQuery.of(context).size.width - 200,
          buttonRect.dx - 100 + (constraints.maxHeight / 2),
        ),
      );
      y = globalPosition.dy
          .clamp(56.0, MediaQuery.of(context).size.height - size.height - 56.0);
    } else {
      x = globalPosition.dx
          .clamp(8.0, MediaQuery.of(context).size.width - size.width - 8.0);
      y = globalPosition.dy
          .clamp(8.0, MediaQuery.of(context).size.height - size.height - 8.0);
    }

    WindowHierarchy.of(context, listen: false).addWindowEntry(
      contextMenuEntry.newInstance(
        content: widget.contextMenu,
        overrideLayout: (info) => info.copyWith(
          position: Offset(x, y),
          size: size,
        ),
      ),
    );
    setState(() {});
  }
}
