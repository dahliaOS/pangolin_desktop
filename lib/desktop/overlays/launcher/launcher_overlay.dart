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
import 'package:flutter/services.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_categories.dart';
import 'package:pangolin/desktop/overlays/launcher/launcher_grid.dart';
import 'package:pangolin/desktop/overlays/launcher/power_menu.dart';
import 'package:pangolin/desktop/overlays/search_overlay.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';
import 'package:pangolin/utils/preference_extension.dart';

class LauncherOverlay extends StatefulWidget {
  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay> {
  final _focusNode = FocusNode(canRequestFocus: true);
  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    final _animation =
        Provider.of<DismissibleOverlayEntry>(context, listen: false).animation;
    final _animationController =
        Provider.of<DismissibleOverlayEntry>(context, listen: false)
            .animationController;
    final _controller = PageController();

    _focusNode.requestFocus();

    return Positioned(
      top: !_pref.isTaskbarTop ? 0 : 48,
      bottom: _pref.isTaskbarTop
          ? 0
          : _pref.isTaskbarLeft || _pref.isTaskbarRight
              ? 0
              : 48,
      left: _pref.isTaskbarLeft ? 48 : 0,
      right: _pref.isTaskbarRight ? 48 : 0,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (details) {
          WmAPI.of(context).popCurrentOverlayEntry();
          WmAPI.of(context).pushOverlayEntry(
            DismissibleOverlayEntry(
                uniqueId: "search",
                content: SearchOverlay(
                  text: details.data.keyLabel.toString(),
                ),
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut),
          );
        },
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0) {
              _animationController.value =
                  _animationController.value - details.delta.dy / 1200;
            } else if (details.delta.dy < -1 &&
                _animationController.value < 1) {
              _animationController.value =
                  _animationController.value - details.delta.dy / 800;
            }
            //print(_animationController.value);
          },
          onVerticalDragEnd: (details) async {
            if (_animationController.value > 0.6) {
              _animationController.animateBack(1.0);
            } else {
              await _animationController.reverse();
              WmAPI.of(context).popCurrentOverlayEntry();
            }
          },
          onTap: () async {
            await _animationController.reverse();
            WmAPI.of(context).popOverlayEntry(
                Provider.of<DismissibleOverlayEntry>(context, listen: false));
            setState(() {});
          },
          child: Stack(
            children: [
              Wallpaper(),
              BoxContainer(
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
                          LauncherCategories(
                            controller: _controller,
                          ),
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
    return Container(
        padding: EdgeInsets.only(top: 50),
        child: Searchbar(
          onTextChanged: (change) {
            WmAPI.of(context).popOverlayEntry(
                Provider.of<DismissibleOverlayEntry>(context, listen: false));
            WmAPI.of(context).pushOverlayEntry(
              DismissibleOverlayEntry(
                  uniqueId: "search",
                  content: SearchOverlay(
                    text: change,
                  ),
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut),
            );
          },
          leading: Icon(Icons.search),
          trailing: Icon(Icons.menu),
          hint: "Search Device, Apps and Web",
          controller: TextEditingController(),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ));
  }
}
