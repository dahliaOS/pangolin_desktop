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

import 'package:pangolin/utils/extensions/extensions.dart';

// ignore: must_be_immutable
class QsToggleButton extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final bool value;
  final VoidCallback? onPressed;
  final VoidCallback? onMenuPressed;

  const QsToggleButton({
    Key? key,
    this.title,
    this.subtitle,
    this.icon,
    this.value = false,
    this.onPressed,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  _QsToggleButtonState createState() => _QsToggleButtonState();
}

class _QsToggleButtonState extends State<QsToggleButton> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final _color = widget.value == true
        ? theme.accent
        : theme.backgroundColor.withOpacity(0.5);

    return SizedBox(
      height: 60,
      width: 162,
      child: Material(
        color: _color,
        borderRadius: context.commonData.borderRadiusMedium,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            widget.onPressed?.call();
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
            child: Row(
              children: [
                Icon(
                  widget.icon ?? Icons.wifi,
                  size: 20,
                  color: theme.computedForegroundColor(_color),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title != "Do not disturb"
                            ? widget.title?.replaceAll(" ", "\n") ?? "Wifi"
                            : "Do not \ndisturb",
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.computedForegroundColor(_color),
                        ),
                      ),
                    ),
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!,
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.computedForegroundColor(_color),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
                const Spacer(),
                VerticalDivider(
                  color: widget.value == true
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
                        color: theme.computedForegroundColor(_color),
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
