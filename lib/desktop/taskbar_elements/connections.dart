import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class ConnectionsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 96,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            WmAPI(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "connection_center", content: ConnectionCenter()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.settings_ethernet,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  Icons.bluetooth,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  Icons.wifi,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.battery_charging_full,
                    size: 18,
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class ConnectionCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _wm = context.watch<WindowHierarchyState>();
    return Positioned(
      bottom: _wm.insets.bottom + 20,
      left: sidePadding(context, 540),
      right: sidePadding(context, 540),
      child: BoxContainer(
        useSystemOpacity: true,
        color: Theme.of(context).cardColor,
        customBorderRadius: BorderRadius.circular(10),
        width: 540,
        height: 320,
        //margin: EdgeInsets.only(bottom: wmKey.currentState!.insets.bottom + 20),
        child: SizedBox(
          height: 48,
          child: Column(
            children: [
              BoxContainer(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).cardColor,
                useSystemOpacity: true,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(Icons.edit),
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    Text(
                      "Connections",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    InkWell(
                      child: Icon(Icons.settings_outlined),
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        WmAPI(context).popOverlayEntry(
                            Provider.of<DismissibleOverlayEntry>(context,
                                listen: false));
                        WmAPI(context).openApp("io.dahlia.settings");
                        /* WmAPI(context).pushWindowEntry(
                            WindowEntry.withDefaultToolbar(
                                content: Settings(),
                                initialSize: Size(1280, 720))); */
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
