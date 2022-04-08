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

class QsSlider extends StatefulWidget {
  const QsSlider({
    Key? key,
    this.icon,
    this.onChanged,
    this.value,
    this.steps,
    this.onIconTap,
  }) : super(key: key);

  final IconData? icon;
  final void Function(double)? onChanged;
  final double? value;
  final int? steps;
  final VoidCallback? onIconTap;

  @override
  _QsSliderState createState() => _QsSliderState();
}

class _QsSliderState extends State<QsSlider> {

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = context.theme.backgroundColor.op(0.5);
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 40,
            child: Material(
              color: backgroundColor,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: widget.onIconTap,
                child: Icon(widget.icon, size: 20),
              ),
            ),
          ),
          Expanded(
            child: Slider(
              onChanged: widget.onChanged,
              value: widget.value ?? 0,
              divisions: widget.steps,
              label: widget.value != null
                  ? '${(widget.value! * 100).toStringAsFixed(0)}%'
                  : null,
            ),
          ),
          SizedBox.square(
            dimension: 40,
            child: Material(
              color: backgroundColor,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                child: const Icon(
                  Icons.chevron_right,
                  size: 22,
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
