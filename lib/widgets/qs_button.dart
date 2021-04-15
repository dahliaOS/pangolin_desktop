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
import 'package:dahlia_backend/dahlia_backend.dart';

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  DatabaseManager.get("qsTileRounding")), //or 15.0
              child: Container(
                color: color ?? Color(_data.accentColor),
                child: Icon(
                  icon ?? Icons.error,
                  color: Colors.white,
                  size: 20,
                ),
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

Widget actionChip(IconData icon, String? label, context) {
  return Padding(
    padding: EdgeInsets.only(right: 8),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          onTap: () {},
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.white.withOpacity(0.25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: label != null ? 8.0 : 0.0),
                    child: Icon(
                      icon,
                      size: 15,
                    ),
                  ),
                  new Text(
                    label ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            ),
          )),
    ),
  );
}
