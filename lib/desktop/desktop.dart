import 'package:flutter/material.dart';
import 'package:pangolin/desktop/taskbar_elements/action_center.dart';
import 'package:pangolin/desktop/taskbar_elements/clock.dart';
import 'package:pangolin/desktop/taskbar_elements/connections.dart';
import 'package:pangolin/desktop/taskbar_elements/launcher.dart';
import 'package:pangolin/desktop/taskbar_elements/music.dart';
import 'package:pangolin/desktop/taskbar_elements/notifications.dart';
import 'package:pangolin/desktop/taskbar_elements/overview.dart';
import 'package:pangolin/desktop/taskbar_elements/search.dart';
import 'package:pangolin/desktop/taskbar.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:utopia_wm/wm.dart';

// ignore: must_be_immutable
class Desktop extends StatelessWidget {
  static final GlobalKey<WindowHierarchyState> wmKey =
      GlobalKey<WindowHierarchyState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowHierarchy(
          key: wmKey,
          rootWindow: Wallpaper(),
          alwaysOnTopWindows: [
            Taskbar(
              leading: [
                LauncherButton(),
                SearchButton(),
                OverviewButton(),
                NotificationsButton(),
                MusicButton()
              ],
              trailing: [
                ConnectionsButton(),
                ActionCenterButton(),
                DateClockWidget()
              ],
            ),
          ],
          margin: EdgeInsets.only(
            bottom: 48,
          )),
    );
  }
}
