import 'package:flutter/material.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/widgets/error_window.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class WmAPI {
  late BuildContext context;
  WmAPI(this.context);
  WmAPI.of(this.context);
  void popOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .popOverlayEntry(entry);
  }

  void popWindowEntry(WindowEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .popWindowEntry(entry);
  }

  void pushOverlayEntry(DismissibleOverlayEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .pushOverlayEntry(entry);
  }

  void pushWindowEntry(WindowEntry entry) {
    Provider.of<WindowHierarchyState>(context, listen: false)
        .pushWindowEntry(entry);
  }

  void openApp(String packageName) {
    if (applications.containsKey(packageName)) {
      pushWindowEntry(WindowEntry.withDefaultToolbar(
        content: applications[packageName]!.app ?? ErrorWindow(),
        initialSize: Size(1280, 720),
        icon: AssetImage(
            "assets/icons/${applications[packageName]!.iconName}.png"),
        title: applications[packageName]!.name,
      ));
    } else {
      pushWindowEntry(WindowEntry.withDefaultToolbar(
          content: ErrorWindow(),
          title: "Error",
          initialSize: Size(1280, 720)));
    }
  }
}
