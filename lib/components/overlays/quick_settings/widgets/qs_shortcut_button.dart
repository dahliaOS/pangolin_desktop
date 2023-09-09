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

import 'package:zenit_ui/zenit_ui.dart';

class QsShortcutButton extends StatelessWidget {
  const QsShortcutButton({
    super.key,
    this.onPressed,
    this.title,
    this.icon,
  });
  final VoidCallback? onPressed;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Material(
        color: Theme.of(context).surfaceColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              children: [
                Icon(
                  icon ?? Icons.add,
                  size: 16,
                ),
                if (title != null)
                  const SizedBox(width: 8)
                else
                  const SizedBox.shrink(),
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(fontSize: 12),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
