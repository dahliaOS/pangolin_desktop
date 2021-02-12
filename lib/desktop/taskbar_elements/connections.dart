import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/qs_button.dart';
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
      left: sidePadding(context, 500),
      right: sidePadding(context, 500),
      child: BoxContainer(
        useSystemOpacity: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        customBorderRadius: BorderRadius.circular(10),
        width: 500,
        height: 328,
        //margin: EdgeInsets.only(bottom: wmKey.currentState!.insets.bottom + 20),
        child: SizedBox(
          height: 48,
          child: Column(
            children: [
              BoxContainer(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).scaffoldBackgroundColor,
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
              SizedBox(
                height: 280,
                width: 500,
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24),
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  children: [
                    QuickSettingsButton(
                      title: "Wi-Fi",
                      icon: Icons.signal_wifi_4_bar_rounded,
                    ),
                    QuickSettingsButton(
                      title: "Bluetooth",
                      icon: Icons.bluetooth_connected_outlined,
                    ),
                    QuickSettingsButton(
                      title: "Ethernet",
                      icon: Icons.settings_ethernet,
                    ),
                    QuickSettingsButton(
                      title: "LTE",
                      icon: Icons.signal_cellular_4_bar_rounded,
                    ),
                    QuickSettingsButton(
                      title: "Location",
                      icon: Icons.location_on_rounded,
                    ),
                    QuickSettingsButton(
                      title: "Nearby\nShare",
                      icon: Icons.ios_share,
                    ),
                    QuickSettingsButton(
                      title: "Screen\nSharing",
                      icon: Icons.screen_share,
                    ),
                    QuickSettingsButton(
                      color: Colors.grey[850],
                      title: "Airplane\nMode",
                      icon: Icons.airplanemode_active,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
