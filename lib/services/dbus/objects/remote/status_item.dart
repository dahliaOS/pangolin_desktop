// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object lib/services/dbus/specifications/org.kde.StatusNotifierItem.xml

import 'package:dbus/dbus.dart';

/// Signal data for org.kde.StatusNotifierItem.NewTitle.
class StatusNotifierItemObjectNewTitle extends DBusSignal {
  StatusNotifierItemObjectNewTitle(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewIcon.
class StatusNotifierItemObjectNewIcon extends DBusSignal {
  StatusNotifierItemObjectNewIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewAttentionIcon.
class StatusNotifierItemObjectNewAttentionIcon extends DBusSignal {
  StatusNotifierItemObjectNewAttentionIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewOverlayIcon.
class StatusNotifierItemObjectNewOverlayIcon extends DBusSignal {
  StatusNotifierItemObjectNewOverlayIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewMenu.
class StatusNotifierItemObjectNewMenu extends DBusSignal {
  StatusNotifierItemObjectNewMenu(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewToolTip.
class StatusNotifierItemObjectNewToolTip extends DBusSignal {
  StatusNotifierItemObjectNewToolTip(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewStatus.
class StatusNotifierItemObjectNewStatus extends DBusSignal {
  String get status => values[0].asString();

  StatusNotifierItemObjectNewStatus(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewIconThemePath.
class StatusNotifierItemObjectNewIconThemePath extends DBusSignal {
  String get iconThemePath => values[0].asString();

  StatusNotifierItemObjectNewIconThemePath(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

class StatusNotifierItemObject extends DBusRemoteObject {
  /// Stream of org.kde.StatusNotifierItem.NewTitle signals.
  late final Stream<StatusNotifierItemObjectNewTitle> newTitle;

  /// Stream of org.kde.StatusNotifierItem.NewIcon signals.
  late final Stream<StatusNotifierItemObjectNewIcon> newIcon;

  /// Stream of org.kde.StatusNotifierItem.NewAttentionIcon signals.
  late final Stream<StatusNotifierItemObjectNewAttentionIcon> newAttentionIcon;

  /// Stream of org.kde.StatusNotifierItem.NewOverlayIcon signals.
  late final Stream<StatusNotifierItemObjectNewOverlayIcon> newOverlayIcon;

  /// Stream of org.kde.StatusNotifierItem.NewMenu signals.
  late final Stream<StatusNotifierItemObjectNewMenu> newMenu;

  /// Stream of org.kde.StatusNotifierItem.NewToolTip signals.
  late final Stream<StatusNotifierItemObjectNewToolTip> newToolTip;

  /// Stream of org.kde.StatusNotifierItem.NewStatus signals.
  late final Stream<StatusNotifierItemObjectNewStatus> newStatus;

  /// Stream of org.kde.StatusNotifierItem.NewIconThemePath signals.
  late final Stream<StatusNotifierItemObjectNewIconThemePath> newIconThemePath;

  StatusNotifierItemObject(
    super.client,
    String destination,
    DBusObjectPath path,
  ) : super(name: destination, path: path) {
    newTitle = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewTitle',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewTitle(signal));

    newIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewIcon',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewIcon(signal));

    newAttentionIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewAttentionIcon',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewAttentionIcon(signal));

    newOverlayIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewOverlayIcon',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewOverlayIcon(signal));

    newMenu = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewMenu',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewMenu(signal));

    newToolTip = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewToolTip',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewToolTip(signal));

    newStatus = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewStatus',
      signature: DBusSignature('s'),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewStatus(signal));

    newIconThemePath = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewIconThemePath',
      signature: DBusSignature('s'),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemObjectNewIconThemePath(signal));
  }

  /// Gets org.kde.StatusNotifierItem.Category
  Future<String> getCategory() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'Category',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.Id
  Future<String> getId() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'Id',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.Title
  Future<String> getTitle() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'Title',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.Status
  Future<String> getStatus() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'Status',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.WindowId
  Future<int> getWindowId() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'WindowId',
      signature: DBusSignature('i'),
    );
    return value.asInt32();
  }

  /// Gets org.kde.StatusNotifierItem.IconThemePath
  Future<String> getIconThemePath() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'IconThemePath',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.Menu
  Future<DBusObjectPath> getMenu() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'Menu',
      signature: DBusSignature('o'),
    );
    return value.asObjectPath();
  }

  /// Gets org.kde.StatusNotifierItem.ItemIsMenu
  Future<bool> getItemIsMenu() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'ItemIsMenu',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.kde.StatusNotifierItem.IconName
  Future<String> getIconName() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'IconName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.IconPixmap
  Future<List<DBusStruct>> getIconPixmap() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'IconPixmap',
      signature: DBusSignature('a(iiay)'),
    );
    return value.asArray().map((child) => child as DBusStruct).toList();
  }

  /// Gets org.kde.StatusNotifierItem.OverlayIconName
  Future<String> getOverlayIconName() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'OverlayIconName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.OverlayIconPixmap
  Future<List<DBusStruct>> getOverlayIconPixmap() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'OverlayIconPixmap',
      signature: DBusSignature('a(iiay)'),
    );
    return value.asArray().map((child) => child as DBusStruct).toList();
  }

  /// Gets org.kde.StatusNotifierItem.AttentionIconName
  Future<String> getAttentionIconName() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'AttentionIconName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.AttentionIconPixmap
  Future<List<DBusStruct>> getAttentionIconPixmap() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'AttentionIconPixmap',
      signature: DBusSignature('a(iiay)'),
    );
    return value.asArray().map((child) => child as DBusStruct).toList();
  }

  /// Gets org.kde.StatusNotifierItem.AttentionMovieName
  Future<String> getAttentionMovieName() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'AttentionMovieName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.kde.StatusNotifierItem.ToolTip
  Future<DBusStruct> getToolTip() async {
    final DBusValue value = await getProperty(
      'org.kde.StatusNotifierItem',
      'ToolTip',
      signature: DBusSignature('(sa(iiay)ss)'),
    );
    return value as DBusStruct;
  }

  /// Invokes org.kde.StatusNotifierItem.ContextMenu()
  Future<void> callContextMenu(
    int x,
    int y, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.kde.StatusNotifierItem',
      'ContextMenu',
      [DBusInt32(x), DBusInt32(y)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.kde.StatusNotifierItem.Activate()
  Future<void> callActivate(
    int x,
    int y, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.kde.StatusNotifierItem',
      'Activate',
      [DBusInt32(x), DBusInt32(y)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.kde.StatusNotifierItem.SecondaryActivate()
  Future<void> callSecondaryActivate(
    int x,
    int y, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.kde.StatusNotifierItem',
      'SecondaryActivate',
      [DBusInt32(x), DBusInt32(y)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.kde.StatusNotifierItem.Scroll()
  Future<void> callScroll(
    int delta,
    String orientation, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.kde.StatusNotifierItem',
      'Scroll',
      [DBusInt32(delta), DBusString(orientation)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }
}
