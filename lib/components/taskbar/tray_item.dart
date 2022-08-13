import 'package:dbus/dbus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/widgets/global/dbus/image.dart';
import 'package:pangolin/widgets/global/dbus/menu.dart';

class TrayItem extends StatefulWidget {
  final StatusNotifierItem item;

  const TrayItem({required this.item, super.key});

  @override
  State<TrayItem> createState() => _TrayItemState();
}

class _TrayItemState extends State<TrayItem> {
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
  void didUpdateWidget(covariant TrayItem oldWidget) {
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
      child: GestureDetector(
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
          child: SizedBox.square(
            dimension: 16,
            child: DBusImageWidget(
              height: 16,
              width: 16,
              themePath: widget.item.iconThemePath,
              image: widget.item.icon ?? const IconDataDBusImage(Icons.info),
            ),
          ),
        ),
      ),
    );
  }
}
