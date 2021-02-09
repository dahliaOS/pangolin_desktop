import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/pangolin_custom_icons_icons.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class ActionCenterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            WmAPI(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "action_center", content: ActionCenter()));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(
                child: Icon(
              PangolinCustomIcons.action_center,
              size: 20,
            )),
          ),
        ),
      ),
    );
  }
}

class ActionCenter extends StatelessWidget {
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
                      child: Icon(Icons.power_settings_new_rounded),
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    Text(
                      "Action Center",
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
