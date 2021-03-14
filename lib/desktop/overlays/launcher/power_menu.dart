import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/desktop/overlays/power_overlay.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class LauncherPowerMenu extends StatefulWidget {
  @override
  _LauncherPowerMenuState createState() => _LauncherPowerMenuState();
}

class _LauncherPowerMenuState extends State<LauncherPowerMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: BoxContainer(
        width: 28 * 3 + 16 * 4,
        height: 32 + 16,
        color: Theme.of(context).backgroundColor,
        useSystemOpacity: true,
        customBorderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                WmAPI.of(context).popOverlayEntry(
                    Provider.of<DismissibleOverlayEntry>(context,
                        listen: false));
                WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                    uniqueId: "power_menu",
                    content: PowerOverlay(),
                    duration: Duration.zero,
                    background: BoxContainer(
                      color: Theme.of(context)
                          .dialogBackgroundColor
                          .withOpacity(0.5),
                      useBlur: false,
                    )));
                setState(() {});
              },
              mouseCursor: SystemMouseCursors.click,
              child: Icon(
                Icons.power_settings_new,
                size: 28,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {},
              mouseCursor: SystemMouseCursors.click,
              child: Icon(
                Icons.person,
                size: 28,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                WmAPI.of(context).popOverlayEntry(
                    Provider.of<DismissibleOverlayEntry>(context,
                        listen: false));
                WmAPI.of(context).openApp("io.dahlia.settings");
                setState(() {});
              },
              mouseCursor: SystemMouseCursors.click,
              child: Icon(
                Icons.settings_outlined,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
