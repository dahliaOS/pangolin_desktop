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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/shell.dart';

typedef ArgsBuilder = Map<String, dynamic> Function();

class TaskbarElement extends StatefulWidget {
  final Widget child;
  final String? overlayID;
  final ArgsBuilder? buildShowArgs;
  final double? width;
  final double? height;
  final bool shrinkWrap;
  final double? iconSize;

  const TaskbarElement({
    super.key,
    required this.child,
    this.overlayID,
    this.buildShowArgs,
    this.width,
    this.height,
    this.shrinkWrap = false,
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
    final darkMode = theme.brightness == Brightness.dark;

    final minSize = Size(
      !widget.shrinkWrap ? 40.0 : 0.0,
      !widget.shrinkWrap ? 40.0 : 0.0,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.width != null ? widget.width! : minSize.width,
        minHeight: widget.height != null ? widget.height! : minSize.height,
        maxWidth: widget.width != null ? widget.width! : double.infinity,
        maxHeight: widget.height != null ? widget.height! : double.infinity,
      ),
      child: GestureDetector(
        onTap: widget.overlayID != null
            ? () => ShellService.current.toggleOverlay(
                  widget.overlayID!,
                  args: widget.buildShowArgs?.call() ?? const {},
                )
            : null,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (state) => setState(() => _hover = true),
          onExit: (state) => setState(() => _hover = false),
          child: Material(
            type: MaterialType.transparency,
            shape: Constants.smallShape,
            clipBehavior: Clip.antiAlias,
            child: ValueListenableBuilder<bool>(
              valueListenable: widget.overlayID != null
                  ? ShellService.current.getShowingNotifier(widget.overlayID!)
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
                    color:
                        _hover ? context.theme.hoverColor : Colors.transparent,
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
    );
  }
}
