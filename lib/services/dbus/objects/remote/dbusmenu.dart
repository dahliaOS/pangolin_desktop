// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object lib/services/dbus/specifications/com.canonical.dbusmenu.xml

import 'package:dbus/dbus.dart';

/// Signal data for com.canonical.dbusmenu.ItemsPropertiesUpdated.
class DBusMenuObjectItemsPropertiesUpdated extends DBusSignal {
  List<DBusStruct> get updatedProps =>
      values[0].asArray().map((child) => child as DBusStruct).toList();
  List<DBusStruct> get removedProps =>
      values[1].asArray().map((child) => child as DBusStruct).toList();

  DBusMenuObjectItemsPropertiesUpdated(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for com.canonical.dbusmenu.LayoutUpdated.
class DBusMenuObjectLayoutUpdated extends DBusSignal {
  int get revision => values[0].asUint32();
  int get parent => values[1].asInt32();

  DBusMenuObjectLayoutUpdated(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for com.canonical.dbusmenu.ItemActivationRequested.
class DBusMenuObjectItemActivationRequested extends DBusSignal {
  int get id => values[0].asInt32();
  int get timestamp => values[1].asUint32();

  DBusMenuObjectItemActivationRequested(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

class DBusMenuObject extends DBusRemoteObject {
  /// Stream of com.canonical.dbusmenu.ItemsPropertiesUpdated signals.
  late final Stream<DBusMenuObjectItemsPropertiesUpdated>
      itemsPropertiesUpdated;

  /// Stream of com.canonical.dbusmenu.LayoutUpdated signals.
  late final Stream<DBusMenuObjectLayoutUpdated> layoutUpdated;

  /// Stream of com.canonical.dbusmenu.ItemActivationRequested signals.
  late final Stream<DBusMenuObjectItemActivationRequested>
      itemActivationRequested;

  DBusMenuObject(
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
        .map((signal) => DBusMenuObjectItemsPropertiesUpdated(signal));

    layoutUpdated = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'com.canonical.dbusmenu',
      name: 'LayoutUpdated',
      signature: DBusSignature('ui'),
    ).asBroadcastStream().map((signal) => DBusMenuObjectLayoutUpdated(signal));

    itemActivationRequested = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'com.canonical.dbusmenu',
      name: 'ItemActivationRequested',
      signature: DBusSignature('iu'),
    )
        .asBroadcastStream()
        .map((signal) => DBusMenuObjectItemActivationRequested(signal));
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
