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
import 'package:pangolin/settings/pages/customization.dart';
import 'package:pangolin/utils/context_menus/context_menu.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';

class ContextMenuRegion extends StatefulWidget {
  ContextMenuRegion({
    Key? key,
    required this.contextMenu,
    this.child,
  });
  final ContextMenu contextMenu;
  final Widget? child;

  @override
  _ContextMenuRegionState createState() => _ContextMenuRegionState();
}

class _ContextMenuRegionState extends State<ContextMenuRegion> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) => showOverlay(context, details),
      onSecondaryTapDown: (details) => showOverlay(context, details),
      child: widget.child ?? SizedBox.shrink(),
    );
  }

  void showOverlay(BuildContext context, dynamic details) {
    bool rtl =
        details.localPosition.dx < MediaQuery.of(context).size.width * (7 / 8);
    WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
      uniqueId: "context_menu",
      duration: Duration.zero,
      content: Positioned(
          top: details.localPosition.dy,
          left: rtl ? details.localPosition.dx : null,
          right: rtl
              ? null
              : MediaQuery.of(context).size.width - details.localPosition.dx,
          child: widget.contextMenu
          /* BoxContainer(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 50)
            ], borderRadius: BorderRadius.circular(8)),
            useBlur: true,
            useSystemOpacity: true,
            customBorderRadius: BorderRadius.circular(6),
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.image),
                        Text("Change Wallpaper"),
                      ],
                    ),
                  ),
                  onPressed: () {
                    /* WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false)); */
                    showDialog(
                        context: context,
                        builder: (context) {
                          return WallpaperChooser();
                        });
                  },
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.image),
                        Text("Change Wallpaper"),
                      ],
                    ),
                  ),
                  onPressed: () {
                    WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return WallpaperChooser();
                        });
                  },
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.image),
                        Text("Change Wallpaper"),
                      ],
                    ),
                  ),
                  onPressed: () {
                    WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return WallpaperChooser();
                        });
                  },
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.image),
                        Text("Change Wallpaper"),
                      ],
                    ),
                  ),
                  onPressed: () {
                    WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return WallpaperChooser();
                        });
                  },
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.image),
                        Text("Change Wallpaper"),
                      ],
                    ),
                  ),
                  onPressed: () {
                    WmAPI.of(context).popOverlayEntry(
                        Provider.of<DismissibleOverlayEntry>(context,
                            listen: false));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return WallpaperChooser();
                        });
                  },
                ),
              ],
            ),
          ) */
          ),
    ));
    setState(() {});
    /* Overlay.of(context)!.insert(OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => print("hit"),
            ),
          ),
          Positioned(
              top: details.localPosition.dy,
              left: details.localPosition.dx,
              child: Container(
                width: 40,
                height: 40,
                color: Colors.blue,
              )),
        ],
      );
    })); */
    //ShowContextMenuNotification(child: child).dispatch(context);
  }

  void openDockMenu(BuildContext context, dynamic details) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.topLeft(details.localPosition),
            ancestor: overlay),
        button.localToGlobal(button.size.topLeft(details.localPosition),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    var result = await showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: "wallpaper",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.image),
              Text("Change Wallpaper"),
            ],
          ),
        ),
      ],
    );
    if (result != null) {
      switch (result) {
        case "wallpaper":
          await showDialog(
              context: context,
              builder: (context) {
                return WallpaperChooser();
              });
          break;
      }
    }
  }
}
