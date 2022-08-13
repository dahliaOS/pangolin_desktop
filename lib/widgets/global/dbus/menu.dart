import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:mnemonic_label/mnemonic_label.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/widgets/global/dbus/image.dart';

class DBusMenuEntry extends PopupMenuEntry<int> {
  final MenuEntry entry;

  const DBusMenuEntry(this.entry);

  @override
  State<DBusMenuEntry> createState() => _DBusMenuEntryState();

  @override
  double get height {
    switch (entry.type) {
      case MenuEntryType.standard:
        return 32;
      case MenuEntryType.separator:
        return 8;
    }
  }

  @override
  bool represents(int? value) => value == entry.id;
}

class _DBusMenuEntryState extends State<DBusMenuEntry> {
  late MenuEntry entry = widget.entry;

  @override
  void didUpdateWidget(covariant DBusMenuEntry oldWidget) {
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
        height: widget.height,
        child: ListTile(
          dense: true,
          enabled: entry.enabled,
          visualDensity: const VisualDensity(vertical: -4),
          shape: const RoundedRectangleBorder(),
          minLeadingWidth: 16,
          leading: SizedBox.square(
            dimension: 16,
            child: entry.icon != null
                ? DBusImageWidget(
                    image: entry.icon!,
                    width: 16,
                    height: 16,
                  )
                : null,
          ),
          onTap: () {
            entry.object.callEvent(
              entry.id,
              "clicked",
              DBusArray.variant([]),
              0, //DateTime.now().millisecondsSinceEpoch,
            );
            Navigator.pop(context);
          },
          trailing: _getTrailing(context),
          title: Mnemonic(entry.label),
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
