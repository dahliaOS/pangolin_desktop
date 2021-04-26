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

import 'package:flutter/material.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.useLongPress
          ? HitTestBehavior.opaque
          : HitTestBehavior.translucent,
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
    bool rtl =
        details.globalPosition.dx < MediaQuery.of(context).size.width * (7 / 8);
    bool btt = details.globalPosition.dy >
        MediaQuery.of(context).size.height * (6.5 / 8);
    WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
      uniqueId: "context_menu",
      duration: Duration.zero,
      content: Positioned(
          top: btt ? null : details.globalPosition.dy - 5,
          bottom: btt
              ? -details.globalPosition.dy +
                  MediaQuery.of(context).size.height -
                  5
              : null,
          left: rtl ? details.globalPosition.dx + 5 : null,
          right: rtl
              ? null
              : MediaQuery.of(context).size.width -
                  details.globalPosition.dx +
                  5,
          child: widget.contextMenu),
    ));
    setState(() {});
  }
}
