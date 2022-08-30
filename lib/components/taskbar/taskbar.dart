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

import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/services.dart';

class Taskbar extends StatefulWidget {
  final List<Widget> leading;
  final List<Widget> center;
  final List<Widget> trailing;
  final bool centerRelativeToScreen;

  const Taskbar({
    this.leading = const [],
    this.center = const [],
    this.trailing = const [],
    this.centerRelativeToScreen = false,
    super.key,
  });

  @override
  State<Taskbar> createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar>
    with StateServiceListener<CustomizationService, Taskbar> {
  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 48,
      child: SizedBox.expand(
        child: Listener(
          onPointerDown: (event) {
            Shell.of(context, listen: false).dismissEverything();
          },
          behavior: HitTestBehavior.translucent,
          child: BoxContainer(
            opacity: 0.25,
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Row(
                      children: [
                        Row(children: widget.leading),
                        Expanded(
                          child: !widget.centerRelativeToScreen
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.center,
                                )
                              : const SizedBox.shrink(),
                        ),
                        Row(children: widget.trailing),
                      ],
                    ),
                  ),
                  if (widget.centerRelativeToScreen)
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
