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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class QuickSettingsButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final IconData? icon;
  final Color? color;

  const QuickSettingsButton({this.title, this.onTap, this.icon, this.color});
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            child: CircleAvatar(
              backgroundColor: color ?? Color(_data.accentColor),
              child: Icon(
                icon ?? Icons.error,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          title ?? "error",
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
