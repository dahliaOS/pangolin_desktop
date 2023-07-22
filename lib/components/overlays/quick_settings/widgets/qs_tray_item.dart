import 'package:dbus/dbus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:pangolin/widgets/dbus/image.dart';
import 'package:pangolin/widgets/dbus/menu.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QsTrayMenuItem extends StatefulWidget {
  final StatusNotifierItem item;

  const QsTrayMenuItem({required this.item});

  @override
  State<QsTrayMenuItem> createState() => _TrayMenuItemState();
}

class _TrayMenuItemState extends State<QsTrayMenuItem> {
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
  void didUpdateWidget(covariant QsTrayMenuItem oldWidget) {
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
    final hasTooltipTitle = widget.item.tooltip?.title != null &&
        widget.item.tooltip!.title.isNotEmpty;
    final hasTitle = widget.item.title != null && widget.item.title!.isNotEmpty;
    final String? title;

    if (hasTitle) {
      title = widget.item.title;
    } else if (hasTooltipTitle) {
      title = widget.item.tooltip!.title;
    } else {
      title = null;
    }

    final hasMenu =
        widget.item.menu != null && widget.item.menu!.children.isNotEmpty;
    final menu = widget.item.menu;

    final child = ContextMenu(
      entries: hasMenu
          ? menu!.children
              .where((e) => e.visible)
              .map((e) => DBusMenuEntry(e))
              .toList()
          : null,
      onOpen: () {
        menu!.object.callEvent(
          menu.id,
          "opened",
          DBusArray.string([]),
          (DateTime.now().millisecondsSinceEpoch / 1000).round(),
        );
      },
      onClose: () {
        menu!.object.callEvent(
          menu.id,
          "closed",
          DBusArray.string([]),
          (DateTime.now().millisecondsSinceEpoch / 1000).round(),
        );
      },
      child: InkWell(
        onTapDown: (details) async {
          final activated = await widget.item.activate(
            details.globalPosition.dx.round(),
            details.globalPosition.dy.round(),
          );
          if (activated) ShellService.current.dismissEverything();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 16,
                  child: DBusImageWidget(
                    height: 16,
                    width: 16,
                    themePath: widget.item.iconThemePath,
                    image:
                        widget.item.icon ?? const IconDataDBusImage(Icons.info),
                  ),
                ),
                if (title != null) const SizedBox(width: 8),
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(fontSize: 13),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    return Material(
      color: Theme.of(context).surfaceColor,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: Tooltip(
        message: hasTooltipTitle && hasTitle ? widget.item.tooltip!.title : "",
        child: child,
      ),
    );
  }
}
