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

import 'package:Pangolin/utils/themes/customization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatelessWidget {
  final List<Widget> children;
  const SettingsTile({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationNotifier>(
      builder: (context, notifier, child) => SizedBox(
        width: 1.7976931348623157e+308,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.children,
            ),
          ),
        ),
      ),
    );
  }
}
