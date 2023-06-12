import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/status_item.dart';
import 'package:pangolin/widgets/global/dbus/image.dart';
import 'package:pangolin/widgets/global/dbus/menu.dart';
import 'package:uuid/uuid.dart';
import 'package:zenit_ui/zenit_ui.dart';

final class MenuControllerRegistry {
  static final MenuControllerRegistry instance = MenuControllerRegistry._();

  MenuControllerRegistry._();

  final Map<String, MenuController> _registeredControllers = {};

  String register(MenuController controller) {
    if (_registeredControllers.containsValue(controller)) {
      throw Exception("Controller already registered.");
    }

    final id = const Uuid().v4();
    _registeredControllers[id] = controller;
    return id;
  }

  void unregister(String id) {
    if (!_registeredControllers.containsKey(id)) {
      throw Exception("Controller $id not registered.");
    }

    _registeredControllers.remove(id);
  }

  MenuController get(String id) {
    if (!_registeredControllers.containsKey(id)) {
      throw Exception("Controller $id not registered.");
    }

    return _registeredControllers[id]!;
  }

  MenuController? maybeGet(String id) {
    return _registeredControllers[id];
  }

  void open(String id, {Offset? position}) {
    if (!_registeredControllers.containsKey(id)) {
      throw Exception("Controller $id not registered.");
    }

    closeAll();
    _registeredControllers[id]!.open(position: position);
  }

  void closeAll() {
    for (final controller in _registeredControllers.values) {
      controller.close();
    }
  }

  bool anyOpen() {
    return _registeredControllers.values.any((e) => e.isOpen);
  }
}

class QsTrayMenuItem extends StatefulWidget {
  final StatusNotifierItem item;

  const QsTrayMenuItem({required this.item});

  @override
  State<QsTrayMenuItem> createState() => _TrayMenuItemState();
}

class _TrayMenuItemState extends State<QsTrayMenuItem> {
  late final String controllerId =
      MenuControllerRegistry.instance.register(MenuController());
  MenuController get controller =>
      MenuControllerRegistry.instance.get(controllerId);

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
    MenuControllerRegistry.instance.unregister(controllerId);
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

    Widget child = InkWell(
      onTapDown: (details) async {
        final shell = Shell.of(context, listen: false);
        final activated = await widget.item.activate(
          details.globalPosition.dx.round(),
          details.globalPosition.dy.round(),
        );
        if (activated) shell.dismissEverything();
      },
      onSecondaryTapDown: (details) {
        if (!hasMenu) return;

        MenuControllerRegistry.instance.open(
          controllerId,
          position: details.localPosition,
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
    );

    if (hasMenu) {
      final menu = widget.item.menu!;

      child = MenuAnchor(
        style: MenuStyle(
          shape: const MaterialStatePropertyAll(Constants.mediumShape),
          side: MaterialStatePropertyAll(
            BorderSide(
              color: ZenitTheme.of(context).foregroundColor.op(0.1),
            ),
          ),
        ),
        clipBehavior: Clip.none,
        onOpen: () {
          menu.object.callEvent(
            menu.id,
            "opened",
            DBusArray.string([]),
            DateTime.now().millisecondsSinceEpoch,
          );
        },
        onClose: () {
          menu.object.callEvent(
            menu.id,
            "closed",
            DBusArray.string([]),
            DateTime.now().millisecondsSinceEpoch,
          );
        },
        controller: controller,
        menuChildren: menu.children
            .where((e) => e.visible)
            .map((e) => DBusMenuEntry(e))
            .toList(),
        child: child,
      );
    }

    return Material(
      color: ZenitTheme.of(context).surfaceColor,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: Tooltip(
        message: hasTooltipTitle && hasTitle ? widget.item.tooltip!.title : "",
        child: child,
      ),
    );
  }
}
