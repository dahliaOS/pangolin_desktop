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

// ignore: must_be_immutable
class QsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool? value;
  VoidCallback onTap;
  bool? withSwitch;

  QsAppBar(
      {required this.title,
      this.value = false,
      required this.onTap,
      this.withSwitch = true});

  @override
  _QsAppBarState createState() => _QsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(48);
}

class _QsAppBarState extends State<QsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          toolbarHeight: widget.preferredSize.height,
          foregroundColor: Theme.of(context).textTheme.bodyText1?.color,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          elevation: 0,
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            widget.withSwitch!
                ? Switch(
                    value: widget.value!,
                    onChanged: (val) {
                      widget.onTap();
                      setState(() {});
                    })
                : SizedBox.shrink(),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        Positioned.fill(
          left: 64,
          right: 64,
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              widget.onTap();
              setState(() {});
            },
          ),
        )
      ],
    );
  }
}
