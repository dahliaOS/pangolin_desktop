import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/services/tray.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/widgets/global/dbus/image.dart';
import 'package:pangolin/widgets/global/dbus/menu.dart';
import 'package:pangolin/widgets/global/surface/surface_layer.dart';

class TrayMenuOverlay extends ShellOverlay {
  static const String overlayId = "tray";

  TrayMenuOverlay({super.key}) : super(id: overlayId);

  @override
  ShellOverlayState<TrayMenuOverlay> createState() => _TrayMenuOverlayState();
}

class _TrayMenuOverlayState extends State<TrayMenuOverlay>
    with
        SingleTickerProviderStateMixin,
        ShellOverlayState,
        StateServiceListener<TrayService, TrayMenuOverlay> {
  static const double _itemSize = 40.0;
  static const double _itemPadding = 8.0;
  static const double _sidePadding = 12.0;
  static const int _itemRowCount = 4;
  static const double _layoutWidth = _itemSize * _itemRowCount +
      _itemPadding * (_itemRowCount - 1) +
      _sidePadding * 2;

  late final AnimationController ac =
      AnimationController(vsync: this, duration: Constants.animationDuration);
  Offset? origin;

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget buildChild(BuildContext context, TrayService service) {
    final Animation<double> animation = CurvedAnimation(
      parent: ac,
      curve: Constants.animationCurve,
    );

    if (!controller.showing && ac.value == 0) return const SizedBox();

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
    await ac.reverse();
  }

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    origin = args["origin"] as Offset?;
    controller.showing = true;
    await ac.forward();
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
          child: InkWell(
            onTapDown: (details) {
              widget.item.activate(
                details.globalPosition.dx.round(),
                details.globalPosition.dy.round(),
              );
            },
            onSecondaryTapDown: (details) async {
              final MenuEntry? menu = widget.item.menu;

              if (menu == null) return;

              menu.object.callEvent(menu.id, "opened", DBusArray.string([]), 0);

              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                ),
                items: menu.children
                    .where((e) => e.visible)
                    .map((e) => DBusMenuEntry(e))
                    .toList(),
              );

              menu.object.callEvent(menu.id, "closed", DBusArray.string([]), 0);
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
                    image:
                        widget.item.icon ?? const IconDataDBusImage(Icons.info),
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
