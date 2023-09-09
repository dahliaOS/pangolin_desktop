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
import 'package:zenit_ui/zenit_ui.dart';

class QsToggleButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color color = enabled ? theme.primaryColor : theme.surfaceColor;
    final String? subtitle = this.subtitle?.resolve(enabled: enabled);

    return SizedBox(
      height: 56,
      width: 160,
      child: Material(
        color: color,
        shape: Constants.mediumShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onPressed?.call(!enabled),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
            child: Row(
              children: [
                Icon(
                  icon.resolve(enabled: enabled),
                  size: 20,
                  color: theme.computedForegroundColor(color),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title.resolve(enabled: enabled),
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.computedForegroundColor(color),
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.computedForegroundColor(color),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (onMenuPressed.isNotNull)
                  Material(
                    color: theme.accentForegroundColor.op(0.2),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onMenuPressed,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: theme.computedForegroundColor(color),
                        ),
                      ),
                    ),
                  ),
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
