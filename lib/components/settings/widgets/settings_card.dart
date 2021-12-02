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
  final Widget? content, trailing, leading;
  final String? title, subtitle;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;

  ///Default value for either the switch or the expansion state
  final bool value;

  // Switchable
  const SettingsCard.withSwitch({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onToggle,
    required this.value,
  })  : content = null,
        onTap = null,
        trailing = null,
        super(type: SettingsElementModelType.toggleSwitch, key: key);
  // Exandable with switch
  const SettingsCard.withExpandableSwitch({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    this.content,
    this.onToggle,
    this.value = false,
  })  : onTap = null,
        trailing = null,
        super(type: SettingsElementModelType.expandableSwitch, key: key);

  // Expandabled
  const SettingsCard.withExpandable({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    this.content,
    this.value = false,
  })  : onTap = null,
        onToggle = null,
        trailing = null,
        super(type: SettingsElementModelType.expandable, key: key);

  // Router
  const SettingsCard.withRouter({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
  })  : content = null,
        value = false,
        onTap = null,
        onToggle = null,
        trailing = null,
        super(type: SettingsElementModelType.router, key: key);

  // Custom trailing
  const SettingsCard.withCustomTrailing({
    Key? key,
    this.leading,
    this.subtitle,
    required this.title,
    required this.trailing,
  })  : content = null,
        value = false,
        onTap = null,
        onToggle = null,
        super(type: SettingsElementModelType.customTrailing, key: key);

  const SettingsCard.custom({Key? key, this.content})
      : leading = null,
        onTap = null,
        onToggle = null,
        subtitle = null,
        title = null,
        trailing = null,
        value = false,
        super(type: SettingsElementModelType.custom, key: key);

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  late bool _value;
  //Build SettingsCard widget
  @override
  Widget build(BuildContext context) {
    _value = widget.value;
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
        child: (widget.type == SettingsElementModelType.custom)
            // Custom Content
            ? widget.content ?? const SizedBox.shrink()
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
                                  SettingsElementModelType.expandableSwitch ||
                              widget.type ==
                                  SettingsElementModelType.expandable ||
                              widget.type ==
                                  SettingsElementModelType.toggleSwitch) {
                            _value = !_value;
                          }
                          if (widget.type == SettingsElementModelType.router) {
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
                      offstage: widget.type ==
                                  SettingsElementModelType.toggleSwitch ||
                              widget.type ==
                                  SettingsElementModelType.customTrailing
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
    return const SnackBar(
      content: Text(
        "Router has not been implemented yet",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get _fallbackContent {
    return const Padding(
      padding: EdgeInsets.all(48.0),
      child: FlutterLogo(
        size: 48,
      ),
    );
  }

  // Define trailing based on type
  Widget get trailing {
    // Expandable with switch
    if (widget.type == SettingsElementModelType.expandableSwitch) {
      return Switch(
        onChanged: (val) {
          setState(() {
            _value = !_value;
          });
        },
        value: _value,
      );
    }

    // Switch
    if (widget.type == SettingsElementModelType.toggleSwitch) {
      return Switch(
        onChanged: (val) {
          setState(() {
            _value = !_value;
          });
        },
        value: _value,
      );
    }

    // Expandable
    if (widget.type == SettingsElementModelType.expandable) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Transform.rotate(
          angle: !_value ? math.pi / 2 : -math.pi / 2,
          child: const Icon(
            Icons.chevron_right_rounded,
            size: 24,
          ),
        ),
      );
    }

    // Router
    if (widget.type == SettingsElementModelType.router) {
      return const Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: Icon(
          Icons.chevron_right_rounded,
          size: 24,
        ),
      );
    }

    // Custom trailing
    if (widget.type == SettingsElementModelType.customTrailing) {
      return widget.trailing!;
    }

    // none
    return const SizedBox.shrink();
  }
}

extension on ThemeData {
  bool get darkMode {
    if (brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }
}
