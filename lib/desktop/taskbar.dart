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
import 'package:provider/provider.dart';

class Taskbar extends StatelessWidget {
  final List<Widget>? leading, trailing;
  Taskbar({@required this.leading, @required this.trailing});

  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 48,
      child: BoxContainer(
          height: 48,
          color: _data.darkMode
              ? Colors.black.withOpacity(_data.themeOpacity)
              : Colors.white.withOpacity(_data.themeOpacity),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: leading ?? [SizedBox.shrink()],
              ),
              Row(
                children: trailing ?? [SizedBox.shrink()],
              )
            ],
          )

          /*Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<WindowHierarchyState>(context, listen: false)
                      .pushWindowEntry(WindowEntry.withDefaultToolbar(
                          content: Example(), packageName: "test"));
                },
                child: Icon(Icons.brightness_5_outlined),
              ),
            )
          ],
        ),*/
          ),
    );
  }
}
