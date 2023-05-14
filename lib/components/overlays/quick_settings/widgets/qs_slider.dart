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
import 'package:pangolin/widgets/global/quick_button.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QsSlider extends StatelessWidget {
  const QsSlider({
    super.key,
    this.icon,
    required this.onChanged,
    this.value,
    this.steps,
    this.onIconTap,
  });

  final IconData? icon;
  final void Function(double) onChanged;
  final double? value;
  final int? steps;
  final VoidCallback? onIconTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuickActionButton(
          leading: Icon(
            icon,
            size: 22,
          ),
          margin: EdgeInsets.zero,
          onPressed: onIconTap,
        ),
        Expanded(
          child: ZenitSlider(
            onChanged: onChanged,
            value: value ?? 0,
            divisions: steps,
            label: value != null ? '${(value! * 100).toStringAsFixed(0)}%' : null,
          ),
        ),
        const QuickActionButton(
          leading: Icon(
            Icons.chevron_right,
            size: 22,
          ),
          margin: EdgeInsets.zero,
        ),
      ],
    );
  }
}
