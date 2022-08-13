import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/services/dbus/menu.dart';
import 'package:pangolin/services/dbus/objects/remote/dbusmenu.dart';
import 'package:pangolin/services/dbus/objects/remote/status_item.dart';
import 'package:pangolin/services/dbus/utils.dart';

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
  MenuEntry? menu;

  StreamSubscription<StatusNotifierItemObjectNewTitle>? _newTitle;
  StreamSubscription<StatusNotifierItemObjectNewIcon>? _newIcon;
  StreamSubscription<StatusNotifierItemObjectNewAttentionIcon>?
      _newAttentionIcon;
  StreamSubscription<StatusNotifierItemObjectNewOverlayIcon>? _newOverlayIcon;
  StreamSubscription<StatusNotifierItemObjectNewStatus>? _newStatus;
  StreamSubscription<StatusNotifierItemObjectNewIconThemePath>?
      _newIconThemePath;
  StreamSubscription<StatusNotifierItemObjectNewMenu>? _newMenu;
  StreamSubscription<StatusNotifierItemObjectNewToolTip>? _newTooltip;

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

  Future<void> _onNewTitle(StatusNotifierItemObjectNewTitle event) async {
    title = await callAsNullable(object.getTitle);
    notifyListeners();
  }

  Future<void> _onNewIcon(StatusNotifierItemObjectNewIcon event) async {
    icon = await _getIcon(object.getIconPixmap, object.getIconName);
    notifyListeners();
  }

  Future<void> _onNewAttentionIcon(
    StatusNotifierItemObjectNewAttentionIcon event,
  ) async {
    attentionIcon = await _getIcon(
      object.getAttentionIconPixmap,
      object.getAttentionIconName,
    );
    notifyListeners();
  }

  Future<void> _onNewOverlayIcon(
    StatusNotifierItemObjectNewOverlayIcon event,
  ) async {
    overlayIcon = await _getIcon(
      object.getOverlayIconPixmap,
      object.getOverlayIconName,
    );
    notifyListeners();
  }

  Future<void> _onNewStatus(StatusNotifierItemObjectNewStatus event) async {
    status = StatusNotifierItemStatus.fromString(event.status);
    notifyListeners();
  }

  Future<void> _onNewIconThemePath(
    StatusNotifierItemObjectNewIconThemePath event,
  ) async {
    iconThemePath = event.iconThemePath;
    notifyListeners();
  }

  Future<void> _onNewMenu(StatusNotifierItemObjectNewMenu event) async {
    menu = await _getMenu(object, object.getMenu);
    notifyListeners();
  }

  Future<void> _onNewTooltip(StatusNotifierItemObjectNewToolTip event) async {
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

  static Future<MenuEntry?> _getMenu(
    DBusRemoteObject refObject,
    FutureOr<DBusObjectPath> Function() getMenu,
  ) async {
    final DBusObjectPath? menuObjectPath = await callAsNullable(getMenu);

    if (menuObjectPath == null) return null;

    final DBusMenuObject menu = DBusMenuObject(
      refObject.client,
      refObject.name,
      path: menuObjectPath,
    );

    final List<DBusValue> entries = await menu.callGetLayout(0, -1, []);

    return MenuEntry.fromDBus(menu, entries[1] as DBusStruct);
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
