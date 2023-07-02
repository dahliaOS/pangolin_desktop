import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/services/tray.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:pangolin/widgets/dbus/image.dart';
import 'package:pangolin/widgets/dbus/menu.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';

class TrayMenuOverlay extends ShellOverlay {
  static const String overlayId = "tray";

  TrayMenuOverlay({super.key}) : super(id: overlayId);

  @override
  ShellOverlayState<TrayMenuOverlay> createState() => _TrayMenuOverlayState();
}

class _TrayMenuOverlayState extends ShellOverlayState<TrayMenuOverlay>
    with StateServiceListener<TrayService, TrayMenuOverlay> {
  static const double _itemSize = 40.0;
  static const double _itemPadding = 8.0;
  static const double _sidePadding = 12.0;
  static const int _itemRowCount = 4;
  static const double _layoutWidth = _itemSize * _itemRowCount +
      _itemPadding * (_itemRowCount - 1) +
      _sidePadding * 2;
  Offset? origin;

  @override
  Widget buildChild(BuildContext context, TrayService service) {
    if (shouldHide) return const SizedBox();

    final origin = this.origin ??
        Offset(
          MediaQuery.of(context).size.width / 2,
          WindowManagerService.current.controller.wmBounds.bottom,
        );
    final rowCount =
        service.items.isNotEmpty ? (service.items.length / 4).ceil() : 1;
    final layoutHeight =
        _itemSize * rowCount + _itemPadding * (rowCount - 1) + _sidePadding * 2;

    return Positioned(
      left: origin.dx - _layoutWidth / 2,
      top: origin.dy - layoutHeight - 8.0,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          alignment: FractionalOffset.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _layoutWidth),
            child: Center(
              child: SurfaceLayer(
                outline: true,
                dropShadow: true,
                shape: Constants.bigShape,
                child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.all(_sidePadding),
                    child: service.items.isNotEmpty
                        ? Wrap(
                            spacing: _itemPadding,
                            runSpacing: _itemPadding,
                            children: service.items
                                .map((e) => _TrayMenuItem(item: e))
                                .toList(),
                          )
                        : const SizedBox(
                            height: _itemSize,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: IntrinsicWidth(
                                child: Center(
                                  child: Text("Empty"),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    controller.showing = false;
    await animationController.reverse();
  }

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    origin = args["origin"] as Offset?;
    controller.showing = true;
    await animationController.forward();
  }
}

class _TrayMenuItem extends StatefulWidget {
  final StatusNotifierItem item;

  const _TrayMenuItem({required this.item});

  @override
  State<_TrayMenuItem> createState() => _TrayMenuItemState();
}

class _TrayMenuItemState extends State<_TrayMenuItem> {
  @override
  void initState() {
    super.initState();
    _startListening(widget.item);
  }

  void _startListening(StatusNotifierItem item) {
    item.addListener(update);
    item.startListening();
  }

  void _stopListening(StatusNotifierItem item) {
    item.stopListening();
    item.removeListener(update);
  }

  @override
  void didUpdateWidget(covariant _TrayMenuItem oldWidget) {
    if (widget.item != oldWidget.item) {
      _stopListening(oldWidget.item);
      _startListening(widget.item);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.item.removeListener(update);
    super.dispose();
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.item.tooltip?.title ?? widget.item.title,
      waitDuration: const Duration(seconds: 1),
      child: SizedBox.square(
        dimension: _TrayMenuOverlayState._itemSize,
        child: Material(
          shape: Constants.smallShape,
          clipBehavior: Clip.antiAlias,
          child: ContextMenu(
            entries: widget.item.menu != null
                ? widget.item.menu!.children
                    .where((e) => e.visible)
                    .map((e) => DBusMenuEntry(e))
                    .toList()
                : null,
            onOpen: () {
              widget.item.menu!.object.callEvent(
                widget.item.menu!.id,
                "opened",
                DBusArray.string([]),
                (DateTime.now().millisecondsSinceEpoch / 1000).round(),
              );
            },
            onClose: () {
              widget.item.menu!.object.callEvent(
                widget.item.menu!.id,
                "closed",
                DBusArray.string([]),
                (DateTime.now().millisecondsSinceEpoch / 1000).round(),
              );
            },
            child: InkWell(
              onTapDown: (details) {
                widget.item.activate(
                  details.globalPosition.dx.round(),
                  details.globalPosition.dy.round(),
                );
              },
              child: Listener(
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) {
                    if (event.scrollDelta.dx != 0) {
                      widget.item.scroll(
                        event.scrollDelta.dx.round(),
                        ScrollOrientation.horizontal,
                      );
                    }

                    if (event.scrollDelta.dy != 0) {
                      widget.item.scroll(
                        event.scrollDelta.dy.round(),
                        ScrollOrientation.vertical,
                      );
                    }
                  }
                },
                child: Center(
                  child: SizedBox.square(
                    dimension: 20,
                    child: DBusImageWidget(
                      height: 20,
                      width: 20,
                      themePath: widget.item.iconThemePath,
                      image: widget.item.icon ??
                          const IconDataDBusImage(Icons.info),
                    ),
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
