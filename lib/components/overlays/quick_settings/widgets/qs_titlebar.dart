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
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QsTitlebar extends StatelessWidget implements PreferredSizeWidget {
  const QsTitlebar({super.key, this.leading, this.title, this.trailing});

  final Widget? leading;
  final String? title;
  final List<Widget>? trailing;

  @override
  Widget build(BuildContext context) {
    final controller = QsController.of(context);
    return SizedBox.fromSize(
      size: preferredSize,
      child: Row(
        children: [
          if (leading == null && controller.canPop())
            const BackButton()
          else if (leading != null)
            leading!,
          if (title != null)
            QuickActionButton(
              title: title,
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.1,
                color: Theme.of(context).foregroundColor,
              ),
            ),
          const Spacer(),
          ...?trailing,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return QuickActionButton(
      leading: const Icon(Icons.arrow_back),
      onPressed: () => QsController.popRoute(context),
      margin: EdgeInsets.zero,
    );
  }
}
