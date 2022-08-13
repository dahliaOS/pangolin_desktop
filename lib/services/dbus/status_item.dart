import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/services/dbus/utils.dart';

/// Signal data for org.kde.StatusNotifierItem.NewTitle.
class StatusNotifierItemNewTitle extends DBusSignal {
  StatusNotifierItemNewTitle(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewIcon.
class StatusNotifierItemNewIcon extends DBusSignal {
  StatusNotifierItemNewIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewAttentionIcon.
class StatusNotifierItemNewAttentionIcon extends DBusSignal {
  StatusNotifierItemNewAttentionIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewOverlayIcon.
class StatusNotifierItemNewOverlayIcon extends DBusSignal {
  StatusNotifierItemNewOverlayIcon(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewMenu.
class StatusNotifierItemNewMenu extends DBusSignal {
  StatusNotifierItemNewMenu(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewToolTip.
class StatusNotifierItemNewToolTip extends DBusSignal {
  StatusNotifierItemNewToolTip(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewStatus.
class StatusNotifierItemNewStatus extends DBusSignal {
  String get status => values[0].asString();

  StatusNotifierItemNewStatus(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

/// Signal data for org.kde.StatusNotifierItem.NewIconThemePath.
class StatusNotifierItemNewIconThemePath extends DBusSignal {
  String get iconThemePath => values[0].asString();

  StatusNotifierItemNewIconThemePath(DBusSignal signal)
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
  late final Stream<StatusNotifierItemNewTitle> newTitle;

  /// Stream of org.kde.StatusNotifierItem.NewIcon signals.
  late final Stream<StatusNotifierItemNewIcon> newIcon;

  /// Stream of org.kde.StatusNotifierItem.NewAttentionIcon signals.
  late final Stream<StatusNotifierItemNewAttentionIcon> newAttentionIcon;

  /// Stream of org.kde.StatusNotifierItem.NewOverlayIcon signals.
  late final Stream<StatusNotifierItemNewOverlayIcon> newOverlayIcon;

  /// Stream of org.kde.StatusNotifierItem.NewMenu signals.
  late final Stream<StatusNotifierItemNewMenu> newMenu;

  /// Stream of org.kde.StatusNotifierItem.NewToolTip signals.
  late final Stream<StatusNotifierItemNewToolTip> newToolTip;

  /// Stream of org.kde.StatusNotifierItem.NewStatus signals.
  late final Stream<StatusNotifierItemNewStatus> newStatus;

  /// Stream of org.kde.StatusNotifierItem.NewIconThemePath signals.
  late final Stream<StatusNotifierItemNewIconThemePath> newIconThemePath;

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
    ).asBroadcastStream().map((signal) => StatusNotifierItemNewTitle(signal));

    newIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewIcon',
      signature: DBusSignature(''),
    ).asBroadcastStream().map((signal) => StatusNotifierItemNewIcon(signal));

    newAttentionIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewAttentionIcon',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemNewAttentionIcon(signal));

    newOverlayIcon = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewOverlayIcon',
      signature: DBusSignature(''),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemNewOverlayIcon(signal));

    newMenu = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewMenu',
      signature: DBusSignature(''),
    ).asBroadcastStream().map((signal) => StatusNotifierItemNewMenu(signal));

    newToolTip = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewToolTip',
      signature: DBusSignature(''),
    ).asBroadcastStream().map((signal) => StatusNotifierItemNewToolTip(signal));

    newStatus = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewStatus',
      signature: DBusSignature('s'),
    ).asBroadcastStream().map((signal) => StatusNotifierItemNewStatus(signal));

    newIconThemePath = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'org.kde.StatusNotifierItem',
      name: 'NewIconThemePath',
      signature: DBusSignature('s'),
    )
        .asBroadcastStream()
        .map((signal) => StatusNotifierItemNewIconThemePath(signal));
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

class StatusNotifierItem extends ChangeNotifier {
  final StatusNotifierItemObject object;
  final String? id;
  final StatusNotifierItemCategory? category;
  final int? windowId;
  final bool? itemIsMenu;

  String? title;
  DBusImage? icon;
  DBusImage? attentionIcon;
  DBusImage? overlayIcon;
  StatusNotifierItemStatus? status;
  String? iconThemePath;
  StatusNotifierItemTooltip? tooltip;
  DBusMenu? menu;

  StreamSubscription<StatusNotifierItemNewTitle>? _newTitle;
  StreamSubscription<StatusNotifierItemNewIcon>? _newIcon;
  StreamSubscription<StatusNotifierItemNewAttentionIcon>? _newAttentionIcon;
  StreamSubscription<StatusNotifierItemNewOverlayIcon>? _newOverlayIcon;
  StreamSubscription<StatusNotifierItemNewStatus>? _newStatus;
  StreamSubscription<StatusNotifierItemNewIconThemePath>? _newIconThemePath;
  StreamSubscription<StatusNotifierItemNewMenu>? _newMenu;
  StreamSubscription<StatusNotifierItemNewToolTip>? _newTooltip;

  StatusNotifierItem({
    required this.object,
    required this.title,
    required this.id,
    required this.category,
    required this.windowId,
    required this.itemIsMenu,
    required this.icon,
    required this.attentionIcon,
    required this.overlayIcon,
    required this.status,
    required this.iconThemePath,
    required this.tooltip,
    required this.menu,
  });

  static Future<StatusNotifierItem> fromObject(
    StatusNotifierItemObject object,
  ) async {
    return StatusNotifierItem(
      object: object,
      title: await callAsNullable(object.getTitle),
      icon: await _getIcon(
        object.getIconPixmap,
        object.getIconName,
      ),
      id: await callAsNullable(object.getId),
      category: StatusNotifierItemCategory.fromString(
        await callAsNullable(object.getCategory),
      ),
      windowId: await callAsNullable(object.getWindowId),
      itemIsMenu: await callAsNullable(object.getItemIsMenu),
      attentionIcon: await _getIcon(
        object.getAttentionIconPixmap,
        object.getAttentionIconName,
      ),
      overlayIcon: await _getIcon(
        object.getOverlayIconPixmap,
        object.getOverlayIconName,
      ),
      status: StatusNotifierItemStatus.fromString(
        await callAsNullable(object.getStatus),
      ),
      iconThemePath: await callAsNullable(object.getIconThemePath),
      tooltip: await _getTooltip(object.getToolTip),
      menu: await _getMenu(object, object.getMenu),
    );
  }

  void startListening() {
    _newTitle = object.newTitle.listen(_onNewTitle);
    _newIcon = object.newIcon.listen(_onNewIcon);
    _newAttentionIcon = object.newAttentionIcon.listen(_onNewAttentionIcon);
    _newOverlayIcon = object.newOverlayIcon.listen(_onNewOverlayIcon);
    _newStatus = object.newStatus.listen(_onNewStatus);
    _newIconThemePath = object.newIconThemePath.listen(_onNewIconThemePath);
    _newMenu = object.newMenu.listen(_onNewMenu);
    _newTooltip = object.newToolTip.listen(_onNewTooltip);
  }

  void stopListening() {
    _newTitle?.cancel();
    _newIcon?.cancel();
    _newAttentionIcon?.cancel();
    _newOverlayIcon?.cancel();
    _newStatus?.cancel();
    _newIconThemePath?.cancel();
    _newMenu?.cancel();
    _newTooltip?.cancel();
  }

  Future<void> _onNewTitle(StatusNotifierItemNewTitle event) async {
    title = await callAsNullable(object.getTitle);
    notifyListeners();
  }

  Future<void> _onNewIcon(StatusNotifierItemNewIcon event) async {
    icon = await _getIcon(object.getIconPixmap, object.getIconName);
    notifyListeners();
  }

  Future<void> _onNewAttentionIcon(
    StatusNotifierItemNewAttentionIcon event,
  ) async {
    attentionIcon = await _getIcon(
      object.getAttentionIconPixmap,
      object.getAttentionIconName,
    );
    notifyListeners();
  }

  Future<void> _onNewOverlayIcon(
    StatusNotifierItemNewOverlayIcon event,
  ) async {
    overlayIcon = await _getIcon(
      object.getOverlayIconPixmap,
      object.getOverlayIconName,
    );
    notifyListeners();
  }

  Future<void> _onNewStatus(StatusNotifierItemNewStatus event) async {
    status = StatusNotifierItemStatus.fromString(event.status);
    notifyListeners();
  }

  Future<void> _onNewIconThemePath(
    StatusNotifierItemNewIconThemePath event,
  ) async {
    iconThemePath = event.iconThemePath;
    notifyListeners();
  }

  Future<void> _onNewMenu(StatusNotifierItemNewMenu event) async {
    menu = await _getMenu(object, object.getMenu);
    notifyListeners();
  }

  Future<void> _onNewTooltip(StatusNotifierItemNewToolTip event) async {
    tooltip = await _getTooltip(object.getToolTip);
    notifyListeners();
  }

  static Future<StatusNotifierItemTooltip?> _getTooltip(
    FutureOr<DBusStruct> Function() getTooltip,
  ) async {
    final DBusStruct? tooltipStruct = await callAsNullable(getTooltip);

    if (tooltipStruct == null) return null;

    final String iconName = tooltipStruct.children[0].asString();
    final List<DBusStruct> iconPixmaps = tooltipStruct.children[1]
        .asArray()
        .map((e) => e as DBusStruct)
        .toList();

    final DBusImage? icon = await _getIcon(() => iconPixmaps, () => iconName);
    final String title = tooltipStruct.children[2].asString();
    final String description = tooltipStruct.children[3].asString();

    return StatusNotifierItemTooltip(
      icon: icon,
      title: title,
      description: description.isNotEmpty ? description : null,
    );
  }

  static Future<DBusMenu?> _getMenu(
    DBusRemoteObject refObject,
    FutureOr<DBusObjectPath> Function() getMenu,
  ) async {
    final DBusObjectPath? menuObjectPath = await callAsNullable(getMenu);

    if (menuObjectPath == null) return null;

    return DBusMenu(
      refObject.client,
      refObject.name,
      path: menuObjectPath,
    );
  }

  static Future<DBusImage?> _getIcon(
    FutureOr<List<DBusStruct>> Function() getPixmap,
    FutureOr<String> Function() getName,
  ) async {
    final List<DBusStruct>? rawPixmaps = await callAsNullable(getPixmap);
    final String? rawName = await callAsNullable(getName);

    if (rawPixmaps != null) {
      return _parseRawPixmaps(rawPixmaps);
    } else if (rawName != null) {
      return NameDBusImage(rawName);
    }

    return null;
  }

  static RawDBusImageCollection _parseRawPixmaps(
    List<DBusStruct> pixmaps,
  ) {
    final List<RawDBusImage> parsedPixmaps =
        pixmaps.map(_parseRawPixmap).toList();

    return RawDBusImageCollection(
      Map.fromIterables(
        parsedPixmaps.map((e) => max(e.width, e.height)),
        parsedPixmaps,
      ),
    );
  }

  static RawDBusImage _parseRawPixmap(DBusStruct pixmap) {
    final int width = pixmap.children[0].asInt32();
    final int height = pixmap.children[1].asInt32();
    final List<int> bytes = pixmap.children[2].asByteArray().toList();

    return RawDBusImage(
      width: width,
      height: height,
      rowStride: width * 4,
      hasAlpha: true,
      bytes: Uint8List.fromList(_patchBytes(bytes, width, height)),
    );
  }

  static List<int> _patchBytes(List<int> bytes, int width, int height) {
    final List<int> result = [];

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width * 4; x += 4) {
        final int a = bytes[x + y * width * 4];
        final int r = bytes[x + 1 + y * width * 4];
        final int g = bytes[x + 2 + y * width * 4];
        final int b = bytes[x + 3 + y * width * 4];

        result.addAll([r, g, b, a]);
      }
    }

    return result;
  }

  Future<bool> activate(int x, int y) async {
    try {
      await object.callActivate(x, y);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> scroll(int delta, ScrollOrientation orientation) async {
    try {
      await object.callScroll(delta, orientation.name);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }
}

enum ScrollOrientation {
  vertical,
  horizontal,
}

enum StatusNotifierItemStatus {
  passive,
  active,
  needsAttention;

  static StatusNotifierItemStatus? fromString(String? value) {
    if (value == null) return null;

    return StatusNotifierItemStatus.values
        .firstWhereOrNull((e) => e.name.toLowerCase() == value.toLowerCase());
  }
}

enum StatusNotifierItemCategory {
  applicationStatus,
  communications,
  systemServices,
  hardware;

  static StatusNotifierItemCategory? fromString(String? value) {
    if (value == null) return null;

    return StatusNotifierItemCategory.values
        .firstWhereOrNull((e) => e.name.toLowerCase() == value.toLowerCase());
  }
}

class StatusNotifierItemTooltip {
  final DBusImage? icon;
  final String title;
  final String? description;

  const StatusNotifierItemTooltip({
    required this.icon,
    required this.title,
    required this.description,
  });
}
