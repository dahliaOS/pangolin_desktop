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
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

// ignore: must_be_immutable
class QsToggleButton extends StatefulWidget {
  final ToggleProperty<String> title;
  final ToggleProperty<String?>? subtitle;
  final ToggleProperty<IconData> icon;
  final bool enabled;
  final ValueChanged<bool>? onPressed;
  final VoidCallback? onMenuPressed;

  const QsToggleButton({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.enabled = false,
    this.onPressed,
    this.onMenuPressed,
  });

  @override
  _QsToggleButtonState createState() => _QsToggleButtonState();
}

class _QsToggleButtonState extends State<QsToggleButton> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final Color color =
        widget.enabled ? theme.accent : theme.backgroundColor.withOpacity(0.5);
    final String? subtitle = widget.subtitle?.resolve(enabled: widget.enabled);

    return SizedBox(
      height: 60,
      width: 162,
      child: Material(
        color: color,
        shape: Constants.mediumShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            widget.onPressed?.call(!widget.enabled);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
            child: Row(
              children: [
                Icon(
                  widget.icon.resolve(enabled: widget.enabled),
                  size: 20,
                  color: theme.computedForegroundColor(color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.title.resolve(enabled: widget.enabled),
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.computedForegroundColor(color),
                          ),
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 10,
                            color: theme.computedForegroundColor(color),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: widget.enabled
                      ? theme.backgroundColor.op(0.2)
                      : theme.surfaceForegroundColor.op(0.2),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: widget.onMenuPressed,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: theme.computedForegroundColor(color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleProperty<T> {
  final T base;
  final T? active;

  const ToggleProperty({required this.base, this.active});

  const ToggleProperty.singleState(this.base) : active = null;

  // ignore: avoid_positional_boolean_parameters
  T resolve({required bool enabled}) => enabled ? active ?? base : base;
}
