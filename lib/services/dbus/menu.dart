import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/widgets.dart' show ShortcutActivator;
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/objects/remote/dbusmenu.dart';

class MenuEntry {
  final DBusMenuObject object;
  final int id;
  final MenuEntryType type;
  final String label;
  final bool enabled;
  final bool visible;
  final DBusImage? icon;
  final List<ShortcutActivator> shortcuts;
  final EntryToggleType toggleType;
  final bool? toggleState;
  final bool childrenAsSubmenu;
  final MenuDisposition disposition;
  final List<MenuEntry> children;

  const MenuEntry({
    required this.object,
    required this.id,
    this.type = MenuEntryType.standard,
    this.label = "",
    this.enabled = true,
    this.visible = true,
    this.icon,
    this.shortcuts = const [],
    this.toggleType = EntryToggleType.none,
    this.toggleState,
    this.childrenAsSubmenu = false,
    this.disposition = MenuDisposition.normal,
    this.children = const [],
  });

  const MenuEntry.nullable({
    required this.object,
    required this.id,
    MenuEntryType? type,
    String? label,
    bool? enabled,
    bool? visible,
    this.icon,
    List<ShortcutActivator>? shortcuts,
    EntryToggleType? toggleType,
    this.toggleState,
    bool? childrenAsSubmenu,
    MenuDisposition? disposition,
    List<MenuEntry>? children,
  })  : type = type ?? MenuEntryType.standard,
        label = label ?? "",
        enabled = enabled ?? true,
        visible = visible ?? true,
        shortcuts = shortcuts ?? const [],
        toggleType = toggleType ?? EntryToggleType.none,
        childrenAsSubmenu = childrenAsSubmenu ?? false,
        disposition = disposition ?? MenuDisposition.normal,
        children = children ?? const [];

  static MenuEntry? fromDBus(DBusMenuObject object, DBusStruct struct) {
    if (struct.signature != DBusSignature('(ia{sv}av)')) return null;

    final int id = struct.children[0].asInt32();
    final Map<String, DBusValue> properties =
        struct.children[1].asStringVariantDict();
    final List<DBusValue> children =
        struct.children[2].asVariantArray().toList();

    final List<MenuEntry> childEntries = children
        .map((e) => e is DBusStruct ? MenuEntry.fromDBus(object, e) : null)
        .where((e) => e != null)
        .map((e) => e!)
        .toList();

    return MenuEntry.nullable(
      object: object,
      id: id,
      type: _getEnum(
        properties['type']?.asString(),
        MenuEntryType.values,
      ),
      icon: _getIcon(
        properties['icon-data']?.asByteArray().toList(),
        properties['icon-name']?.asString(),
      ),
      label: properties['label']?.asString(),
      enabled: properties['enabled']?.asBoolean(),
      visible: properties['visible']?.asBoolean(),
      toggleType: _getEnum(
        properties['toggle-type']?.asString(),
        EntryToggleType.values,
      ),
      toggleState: _parseToggleType(
        properties['toggle-state']?.asInt32(),
      ),
      childrenAsSubmenu:
          properties['children-display']?.asString() == "submenu",
      disposition: _getEnum(
        properties['disposition']?.asString(),
        MenuDisposition.values,
      ),
      children: childEntries,
    );
  }

  static bool? _parseToggleType(int? value) {
    switch (value) {
      case 1:
        return true;
      case 0:
        return false;
      default:
        return null;
    }
  }

  static DBusImage? _getIcon(
    List<int>? data,
    String? name,
  ) {
    if (data != null) {
      return PngDBusImage(Uint8List.fromList(data));
    } else if (name != null) {
      return NameDBusImage(name);
    }

    return null;
  }

  static T? _getEnum<T extends Enum>(
    String? value,
    List<T> values,
  ) {
    return values.firstWhereOrNull((e) => e.name == value);
  }
}

enum MenuEntryType {
  standard,
  separator,
}

enum EntryToggleType {
  none,
  checkmark,
  radio,
}

enum MenuDisposition {
  normal,
  informative,
  warning,
  alert,
}
