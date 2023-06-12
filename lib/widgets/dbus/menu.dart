import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/widgets/context_menu.dart';
import 'package:pangolin/widgets/dbus/image.dart';

class DBusMenuEntry extends BaseContextMenuItem {
  final MenuEntry entry;

  const DBusMenuEntry(this.entry) : super();

  @override
  Widget build(BuildContext context) {
    return _DBusMenuEntry(entry);
  }
}

class _DBusMenuEntry extends StatefulWidget {
  final MenuEntry entry;

  const _DBusMenuEntry(this.entry);

  @override
  State<_DBusMenuEntry> createState() => _DBusMenuEntryState();
}

class _DBusMenuEntryState extends State<_DBusMenuEntry> {
  late MenuEntry entry = widget.entry;

  @override
  void didUpdateWidget(covariant _DBusMenuEntry oldWidget) {
    if (widget.entry != oldWidget.entry) {
      entry = widget.entry;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entry.type == MenuEntryType.separator) {
      return const Divider(height: 8);
    }

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: double.infinity,
        child: MenuItemButton(
          style: MenuItemButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            minimumSize: const Size(0, 40),
            maximumSize: const Size(double.infinity, 40),
          ),
          leadingIcon: SizedBox.square(
            dimension: 16,
            child: entry.icon != null
                ? DBusImageWidget(
                    image: entry.icon!,
                    width: 16,
                    height: 16,
                  )
                : null,
          ),
          onPressed: entry.enabled
              ? () {
                  entry.object.callEvent(
                    entry.id,
                    "clicked",
                    DBusArray.variant([]),
                    (DateTime.now().millisecondsSinceEpoch / 1000).round(),
                  );
                }
              : null,
          trailingIcon: _getTrailing(context),
          child: Text(entry.label.replaceAll("_", "")),
        ),
      ),
    );
  }

  Widget? _getTrailing(BuildContext context) {
    if (entry.childrenAsSubmenu && entry.children.isNotEmpty) {
      return const Icon(Icons.chevron_right);
    }

    switch (entry.toggleType) {
      case EntryToggleType.checkmark:
        return Checkbox(
          tristate: true,
          visualDensity: VisualDensity.compact,
          value: entry.toggleState,
          onChanged: (value) {},
        );
      case EntryToggleType.radio:
        return Radio<int>(
          value: entry.toggleState == true ? 1 : 0,
          groupValue: entry.toggleState == true ? 1 : -1,
          onChanged: (value) {},
        );
      case EntryToggleType.none:
        return null;
    }
  }
}
