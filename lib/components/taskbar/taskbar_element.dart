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
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class TaskbarElement extends StatefulWidget {
  final Widget child;
  final String? overlayID;
  final Size? size;
  final double? iconSize;

  const TaskbarElement({
    super.key,
    required this.child,
    this.overlayID,
    this.size,
    this.iconSize,
  });

  @override
  _TaskbarElementState createState() => _TaskbarElementState();
}

class _TaskbarElementState extends State<TaskbarElement> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.secondary;
    final shell = Shell.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    return SizedBox.fromSize(
      size: widget.size ?? const Size(48, 48),
      child: GestureDetector(
        onTap: () => widget.overlayID != null
            ? shell.toggleOverlay(widget.overlayID!)
            : {},
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (state) => setState(() => _hover = true),
          onExit: (state) => setState(() => _hover = false),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              type: MaterialType.transparency,
              shape: Constants.smallShape,
              clipBehavior: Clip.antiAlias,
              child: ValueListenableBuilder<bool>(
                valueListenable: widget.overlayID != null
                    ? shell.getShowingNotifier(widget.overlayID!)
                    : ValueNotifier(false),
                builder: (context, showing, child) {
                  return IconTheme.merge(
                    data: IconThemeData(
                      color: showing
                          ? accentColor.computeLuminance() < 0.3
                              ? const Color(0xffffffff)
                              : const Color(0xff000000)
                          : darkMode
                              ? const Color(0xffffffff)
                              : const Color(0xff000000),
                      size: widget.iconSize ?? 20,
                    ),
                    child: Material(
                      shape: Constants.smallShape,
                      clipBehavior: Clip.antiAlias,
                      color: _hover
                          ? context.theme.hoverColor
                          : Colors.transparent,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: showing
                              ? accentColor.computeLuminance() < 0.3
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000)
                              : darkMode
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                        ),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          color: showing ? accentColor : Colors.transparent,
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
