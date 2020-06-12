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

import 'package:flutter/widgets.dart';

/// This Inherited Widget will allow easy reference to all constants.
/// Constants which are used repeatedly in the code should be declared here and used through this Widget.
/// 
/// Use as: `Constants.of(context).constantStringExample`
/// 
/// Using this reduces memory consumption & is performant with complexity O(1).
class Constants extends InheritedWidget {
  static Constants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Constants);

  const Constants({Widget child, Key key})
      : super(key: key, child: child);
  final String constantStringExample = 'An example';

  @override
  bool updateShouldNotify(Constants old) => false;
}
