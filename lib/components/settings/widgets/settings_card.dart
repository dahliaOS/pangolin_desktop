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
import 'dart:math' as math;
import 'package:pangolin/components/settings/models/settings_element_model.dart';

class SettingsCard extends SettingsElementModel {
  Widget? content, trailing, leading;
  String? title, subtitle;
  ValueChanged<bool>? onToggle;
  VoidCallback? onTap;

  ///Default value for either the switch or the expansion state
  late bool value;

  // Switchable
  SettingsCard.withSwitch({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onToggle,
    required this.value,
  }) : super(type: SettingsElementModelType.SWITCH, key: key) {
    this.content = null;
  }

  // Exandable with switch
  SettingsCard.withExpandableSwitch({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    this.content,
    this.onToggle,
    this.value = false,
  }) : super(type: SettingsElementModelType.EXPANDABLESWITCH, key: key);

  // Expandabled
  SettingsCard.withExpandable({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    this.content,
    this.value = false,
  }) : super(type: SettingsElementModelType.EXPANDABLE, key: key);

  // Router
  SettingsCard.withRouter({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
  }) : super(type: SettingsElementModelType.ROUTER, key: key) {
    this.content = null;
    this.value = false;
  }

  // Custom trailing
  SettingsCard.withCustomTrailing({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    required this.trailing,
  }) : super(type: SettingsElementModelType.CUSTOMTRAILING, key: key) {
    this.content = null;
    this.value = false;
  }

  SettingsCard.custom({Key? key, this.content})
      : super(type: SettingsElementModelType.CUSTOM, key: key);

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  //Build SettingsCard widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      // Slighly increase size on hover
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: Theme.of(context).cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
              color: Theme.of(context).darkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
              width: 2),
        ),
        child: (widget.type == SettingsElementModelType.CUSTOM)
            // Custom Content
            ? widget.content ?? SizedBox.shrink()
            // Default Content
            : Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: widget.subtitle != null ? 6.0 : 8.0,
                    ),
                    leading: widget.leading ?? _fallbackLeading,
                    title: Text(widget.title ?? "ERR: No title"),
                    subtitle:
                        widget.subtitle != null ? Text(widget.subtitle!) : null,
                    trailing: trailing,
                    onTap: () {
                      setState(
                        () {
                          if (widget.type ==
                                  SettingsElementModelType.EXPANDABLESWITCH ||
                              widget.type ==
                                  SettingsElementModelType.EXPANDABLE ||
                              widget.type == SettingsElementModelType.SWITCH) {
                            widget.value = !widget.value;
                          }
                          if (widget.type == SettingsElementModelType.ROUTER) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_fallbackSnackBar);
                          }
                          widget.onToggle?.call(widget.value);
                          widget.onTap?.call();
                        },
                      );
                    },
                  ),
                  // Expandable content
                  Offstage(
                      offstage:
                          widget.type == SettingsElementModelType.SWITCH ||
                                  widget.type ==
                                      SettingsElementModelType.CUSTOMTRAILING
                              ? true
                              : !widget.value,
                      child: widget.content ?? _fallbackContent)
                ],
              ),
      ),
    );
  }

  Widget? get _fallbackLeading {
    return null;
  }

  SnackBar get _fallbackSnackBar {
    return SnackBar(
      content: Text(
        "Router has not been implemented yet",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get _fallbackContent {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: FlutterLogo(
        size: 48,
      ),
    );
  }

  // Define trailing based on type
  Widget get trailing {
    // Expandable with switch
    if (widget.type == SettingsElementModelType.EXPANDABLESWITCH) {
      return Switch(
        onChanged: (val) {
          setState(() {
            widget.value = !widget.value;
          });
        },
        value: widget.value,
      );
    }

    // Switch
    if (widget.type == SettingsElementModelType.SWITCH) {
      return Switch(
        onChanged: (val) {
          setState(() {
            widget.value = !widget.value;
          });
        },
        value: widget.value,
      );
    }

    // Expandable
    if (widget.type == SettingsElementModelType.EXPANDABLE) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Transform.rotate(
          angle: !widget.value ? math.pi / 2 : -math.pi / 2,
          child: Icon(
            Icons.chevron_right_rounded,
            size: 24,
          ),
        ),
      );
    }

    // Router
    if (widget.type == SettingsElementModelType.ROUTER) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(
          Icons.chevron_right_rounded,
          size: 24,
        ),
      );
    }

    // Custom trailing
    if (widget.type == SettingsElementModelType.CUSTOMTRAILING) {
      return widget.trailing!;
    }

    // none
    return SizedBox.shrink();
  }
}

extension on ThemeData {
  bool get darkMode {
    if (brightness == Brightness.dark) {
      return true;
    } else
      return false;
  }
}
