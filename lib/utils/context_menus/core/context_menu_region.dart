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
import 'package:pangolin/utils/context_menus/context_menu.dart';

class ContextMenuRegion extends StatefulWidget {
  ContextMenuRegion({
    Key? key,
    required this.contextMenu,
    this.child,
    this.useLongPress = true,
  });
  final ContextMenu contextMenu;
  final Widget? child;
  final bool useLongPress;

  @override
  _ContextMenuRegionState createState() => _ContextMenuRegionState();
}

class _ContextMenuRegionState extends State<ContextMenuRegion> {
  static final contextMenuEntry = WindowEntry(
    features: [
      GeometryWindowFeature(),
      ResizeWindowFeature(),
    ],
    properties: {
      WindowExtras.stableId: "shell:context_menu",
      WindowEntry.title: "Context menu",
      WindowEntry.showOnTaskbar: false,
      GeometryWindowFeature.size: Size(200, 300),
      GeometryWindowFeature.position: Offset.zero,
      WindowEntry.icon: null,
      WindowEntry.alwaysOnTop: true,
      WindowEntry.alwaysOnTopMode: AlwaysOnTopMode.systemOverlay,
    },
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressStart: (details) {
        if (widget.useLongPress) {
          showOverlay(context, details);
        } else {
          return;
        }
      },
      onSecondaryTapDown: (details) => showOverlay(context, details),
      child: widget.child ?? SizedBox.shrink(),
    );
  }

  void showOverlay(BuildContext context, dynamic details) {
    List<int> _length = List.empty(growable: true);
    widget.contextMenu.items.forEach((element) {
      _length.add(element.title.characters.length);
    });
    _length.sort();
    final Size size =
        Size(_length.last * 13, widget.contextMenu.items.length * 40);
    final double x = details.globalPosition.dx
        .clamp(8.0, MediaQuery.of(context).size.width - size.width - 8.0);
    final double y = details.globalPosition.dy
        .clamp(8.0, MediaQuery.of(context).size.height - size.height - 8.0);

    WindowHierarchy.of(context, listen: false).addWindowEntry(
      contextMenuEntry.newInstance(
        widget.contextMenu,
        {
          GeometryWindowFeature.position: Offset(x, y),
          GeometryWindowFeature.size: size,
        },
      ),
    );
    setState(() {});
  }
}
