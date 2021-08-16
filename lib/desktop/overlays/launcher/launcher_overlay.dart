/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_categories.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_grid.dart';
import 'package:pangolin/desktop/overlays/launcher/power_menu.dart';
import 'package:pangolin/desktop/overlays/search/search_overlay.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/utils/preference_extension.dart';

class LauncherOverlay extends ShellOverlay {
  static const String overlayId = 'launcher';

  LauncherOverlay() : super(id: overlayId);

  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: CommonData.of(context).animationDuration(),
    );
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  final _focusNode = FocusNode(canRequestFocus: true);
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    final _shell = Shell.of(context);
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );
    final _controller = PageController();

    _focusNode.requestFocus();

    if (!controller.showing) return SizedBox();

    return Positioned(
      top: !_pref.isTaskbarTop ? 0 : 48,
      bottom: _pref.isTaskbarTop
          ? 0
          : _pref.isTaskbarLeft || _pref.isTaskbarRight
              ? 0
              : 48,
      left: _pref.isTaskbarLeft ? 48 : 0,
      right: _pref.isTaskbarRight ? 48 : 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0.5) {
            ac.value = ac.value - details.delta.dy / 1200;
          } else if (details.delta.dy < -1 && ac.value < 1) {
            ac.value = ac.value - details.delta.dy / 800;
          }
        },
        onVerticalDragEnd: (details) async {
          if (ac.value > 0.6) {
            ac.animateBack(1.0);
          } else {
            await ac.reverse();
            _shell.dismissOverlay(LauncherOverlay.overlayId);
          }
        },
        onTap: () async {
          await ac.reverse();
          _shell.dismissOverlay(LauncherOverlay.overlayId);
        },
        child: Stack(
          children: [
            //Positioned.fill(top: 0, child: Wallpaper()),
            BoxContainer(
              useAccentBG: true,
              useSystemOpacity: true,
              useBlur: true,
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) => FadeTransition(
                  opacity: _animation,
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: _pref.taskbarPosition != 0
                        ? FractionalOffset.bottomCenter
                        : FractionalOffset.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Search(),
                        LauncherCategories(controller: _controller),
                        LauncherGrid(controller: _controller),
                        LauncherPowerMenu(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);

    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Searchbar(
        onTextChanged: (change) {
          _shell.dismissOverlay(LauncherOverlay.overlayId);
          _shell.showOverlay(
            SearchOverlay.overlayId,
            args: {"searchQuery": change},
            dismissEverything: false,
          );
        },
        leading: Icon(Icons.search),
        trailing: Icon(Icons.menu),
        hint: "Search Device, Apps and Web",
        controller: TextEditingController(),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
