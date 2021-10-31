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

class QsToggleButton extends StatefulWidget {
  QsToggleButton({
    Key? key,
    this.title,
    this.subtitle,
    this.icon,
    this.value,
    this.onPressed,
  }) : super(
          key: key,
        ) {
    value = value ?? false;
  }

  final String? title, subtitle;
  final IconData? icon;
  bool? value;
  final VoidCallback? onPressed;

  @override
  _QsToggleButtonState createState() => _QsToggleButtonState();
}

class _QsToggleButtonState extends State<QsToggleButton> {
  @override
  Widget build(BuildContext context) {
    final _color = widget.value == true
        ? context.theme.primaryColor
        : context.theme.backgroundColor.withOpacity(0.5);
    return SizedBox(
      height: 60,
      width: 124,
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
                  color: _color.computeLuminance() > 0.4
                      ? ColorsX.black
                      : ColorsX.white,
                ),
                SizedBox(width: 16),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _color.computeLuminance() > 0.4
                              ? ColorsX.black
                              : ColorsX.white,
                        ),
                      ),
                    ),
                    (widget.subtitle != null)
                        ? Text(
                            widget.subtitle!,
                            style: TextStyle(
                              fontSize: 12,
                              color: _color.computeLuminance() > 0.4
                                  ? ColorsX.black
                                  : ColorsX.white,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
