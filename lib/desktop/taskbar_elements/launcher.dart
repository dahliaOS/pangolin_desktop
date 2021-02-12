import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';

class LauncherButton extends StatelessWidget {
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
                content: Positioned(
                  left: 30,
                  right: 30,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.settings");
                        },
                        child: Text("Settings"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.calculator");
                        },
                        child: Text("Calculator"),
                      ),
                    ],
                  ),
                ),
                uniqueId: 'launcher'));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: Icon(Icons.apps)),
          ),
        ),
      ),
    );
  }
}
