/*
Copyright 2019 The dahliaOS Authors

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

class BrightnessSwitcherDialog extends StatelessWidget {
  const BrightnessSwitcherDialog({Key key, this.onSelectedTheme})
      : super(key: key);

  final ValueChanged<Brightness> onSelectedTheme;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select Theme'),
      children: <Widget>[
        RadioListTile<Brightness>(
          value: Brightness.light,
          groupValue: Theme.of(context).brightness,
          onChanged: (Brightness value) {
            onSelectedTheme(Brightness.light);
          },
          title: const Text('Light'),
        ),
        RadioListTile<Brightness>(
          value: Brightness.dark,
          groupValue: Theme.of(context).brightness,
          onChanged: (Brightness value) {
            onSelectedTheme(Brightness.dark);
          },
          title: const Text('Spooky  👻'),
        ),
      ],
    );
  }
}
