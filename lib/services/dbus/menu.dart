// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object lib/services/dbus/dbusmenu.xml

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show ShortcutActivator;
import 'package:pangolin/services/dbus/image.dart';

/// Signal data for com.canonical.dbusmenu.ItemsPropertiesUpdated.
class DBusMenuItemsPropertiesUpdated extends DBusSignal {
  List<DBusStruct> get updatedProps =>
      values[0].asArray().map((child) => child as DBusStruct).toList();
  List<DBusStruct> get removedProps =>
      values[1].asArray().map((child) => child as DBusStruct).toList();

  DBusMenuItemsPropertiesUpdated(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for com.canonical.dbusmenu.LayoutUpdated.
class DBusMenuLayoutUpdated extends DBusSignal {
  int get revision => values[0].asUint32();
  int get parent => values[1].asInt32();

  DBusMenuLayoutUpdated(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for com.canonical.dbusmenu.ItemActivationRequested.
class DBusMenuItemActivationRequested extends DBusSignal {
  int get id => values[0].asInt32();
  int get timestamp => values[1].asUint32();

  DBusMenuItemActivationRequested(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

class DBusMenu extends DBusRemoteObject {
  /// Stream of com.canonical.dbusmenu.ItemsPropertiesUpdated signals.
  late final Stream<DBusMenuItemsPropertiesUpdated> itemsPropertiesUpdated;

  /// Stream of com.canonical.dbusmenu.LayoutUpdated signals.
  late final Stream<DBusMenuLayoutUpdated> layoutUpdated;

  /// Stream of com.canonical.dbusmenu.ItemActivationRequested signals.
  late final Stream<DBusMenuItemActivationRequested> itemActivationRequested;

  DBusMenu(
    super.client,
    String destination, {
    super.path = DBusObjectPath.root,
  }) : super(name: destination) {
    itemsPropertiesUpdated = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'com.canonical.dbusmenu',
      name: 'ItemsPropertiesUpdated',
      signature: DBusSignature('a(ia{sv})a(ias)'),
    )
        .asBroadcastStream()
        .map((signal) => DBusMenuItemsPropertiesUpdated(signal));

    layoutUpdated = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'com.canonical.dbusmenu',
      name: 'LayoutUpdated',
      signature: DBusSignature('ui'),
    ).asBroadcastStream().map((signal) => DBusMenuLayoutUpdated(signal));

    itemActivationRequested = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'com.canonical.dbusmenu',
      name: 'ItemActivationRequested',
      signature: DBusSignature('iu'),
    )
        .asBroadcastStream()
        .map((signal) => DBusMenuItemActivationRequested(signal));
  }

  /// Gets com.canonical.dbusmenu.Version
  Future<int> getVersion() async {
    final DBusValue value = await getProperty(
      'com.canonical.dbusmenu',
      'Version',
      signature: DBusSignature('u'),
    );
    return value.asUint32();
  }

  /// Gets com.canonical.dbusmenu.TextDirection
  Future<String> getTextDirection() async {
    final DBusValue value = await getProperty(
      'com.canonical.dbusmenu',
      'TextDirection',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets com.canonical.dbusmenu.Status
  Future<String> getStatus() async {
    final DBusValue value = await getProperty(
      'com.canonical.dbusmenu',
      'Status',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets com.canonical.dbusmenu.IconThemePath
  Future<List<String>> getIconThemePath() async {
    final DBusValue value = await getProperty(
      'com.canonical.dbusmenu',
      'IconThemePath',
      signature: DBusSignature('as'),
    );
    return value.asStringArray().toList();
  }

  /// Invokes com.canonical.dbusmenu.GetLayout()
  Future<List<DBusValue>> callGetLayout(
    int parentId,
    int recursionDepth,
    List<String> propertyNames, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'GetLayout',
      [
        DBusInt32(parentId),
        DBusInt32(recursionDepth),
        DBusArray.string(propertyNames)
      ],
      replySignature: DBusSignature('u(ia{sv}av)'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues;
  }

  /// Invokes com.canonical.dbusmenu.GetGroupProperties()
  Future<List<DBusStruct>> callGetGroupProperties(
    List<int> ids,
    List<String> propertyNames, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'GetGroupProperties',
      [DBusArray.int32(ids), DBusArray.string(propertyNames)],
      replySignature: DBusSignature('a(ia{sv})'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues[0]
        .asArray()
        .map((child) => child as DBusStruct)
        .toList();
  }

  /// Invokes com.canonical.dbusmenu.GetProperty()
  Future<DBusValue> callGetProperty(
    int id,
    String name, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'GetProperty',
      [DBusInt32(id), DBusString(name)],
      replySignature: DBusSignature('v'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues[0].asVariant();
  }

  /// Invokes com.canonical.dbusmenu.Event()
  Future<void> callEvent(
    int id,
    String eventId,
    DBusValue data,
    int timestamp, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'com.canonical.dbusmenu',
      'Event',
      [
        DBusInt32(id),
        DBusString(eventId),
        DBusVariant(data),
        DBusUint32(timestamp)
      ],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes com.canonical.dbusmenu.EventGroup()
  Future<List<int>> callEventGroup(
    List<DBusStruct> events, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'EventGroup',
      [DBusArray(DBusSignature('(isvu)'), events.map((child) => child))],
      replySignature: DBusSignature('ai'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues[0].asInt32Array().toList();
  }

  /// Invokes com.canonical.dbusmenu.AboutToShow()
  Future<bool> callAboutToShow(
    int id, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'AboutToShow',
      [DBusInt32(id)],
      replySignature: DBusSignature('b'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues[0].asBoolean();
  }

  /// Invokes com.canonical.dbusmenu.AboutToShowGroup()
  Future<List<DBusValue>> callAboutToShowGroup(
    List<int> ids, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final DBusMethodSuccessResponse result = await callMethod(
      'com.canonical.dbusmenu',
      'AboutToShowGroup',
      [DBusArray.int32(ids)],
      replySignature: DBusSignature('aiai'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues;
  }
}

class MenuEntry {
  final DBusMenu object;
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

  static MenuEntry? fromDBus(DBusMenu object, DBusStruct struct) {
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
