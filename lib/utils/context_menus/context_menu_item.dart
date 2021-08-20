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
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm_new.dart';

class ContextMenuItem extends StatelessWidget {
  ContextMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.shortcut,
  });

  final String title, shortcut;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap != null
              ? () {
                  final _properties =
                      WindowPropertyRegistry.of(context, listen: false);
                  WmAPI.of(context).popWindowEntry(_properties.info.id);
                  onTap?.call();
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Row(
              children: [
                Icon(this.icon),
                SizedBox(
                  width: 16,
                ),
                Text(
                  this.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                //Spacer(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(this.shortcut))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
