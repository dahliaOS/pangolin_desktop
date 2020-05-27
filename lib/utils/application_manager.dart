import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'palette_generator.dart';

/// Note: Don't use! Not yet completed.
/// TODO: develop application manager.
/// This [Applications] generates a List of [AppInfo] (which has application information) for better access.
/// It needs a list with map of applications obtained from platform operations to create [AppInfo].
class Applications {
  /// List with [AppInfo]s containing information for apps
  List<AppInfo> _apps;

  Applications(List appList) {
    this._apps = [];
    for (var appData in appList) {
      AppInfo appInfo = AppInfo(
        label: appData["label"],
        packageName: appData["package"],
        iconData: appData["icon"],
      );
      this._apps.add(appInfo);
    }
  }

  int get length => _apps.length;

  /// Creates a [List] containing the [AppInfo] elements of this [Applications] instance.
  ///
  /// The elements are in iteration order.
  /// The list is fixed-length if [growable] is false.
  List<AppInfo> toList({growable = false}) =>
      List<AppInfo>.from(this._apps, growable: growable);
}

/// [AppInfo] containing Application information obtained from [Applications]'s list.
///
/// This represents a package label as [label], package name as [packageName] and
/// icon [iconData] as a [Uint8List].
///
/// Flutter Image widget can be obtained from [getIconAsImage].
/// Color palette for icon can be obtained through [getIconPalette].
class AppInfo {
  String label;
  String packageName;
  Uint8List iconData;
  AppInfo({String label, String packageName, Uint8List iconData})
      : this.label = label,
        this.packageName = packageName,
        this.iconData = iconData;

  /// Creates a flutter Image widget from obtained iconData [Uint8List]
  Image getIconAsImage() {
    return Image.memory(this.iconData);
  }

  Future<PaletteGenerator> getIconPalette() async {
    return await PaletteGenerator.fromUint8List(this.iconData);
  }
}

///[AppInfoList]
