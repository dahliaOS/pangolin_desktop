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

abstract class SettingsElementModel extends StatefulWidget {
  final SettingsElementModelType type;

  const SettingsElementModel({
    required this.type,
    super.key,
  });
}

// Types of SettingsCards
enum SettingsElementModelType {
  toggleSwitch,
  expandable,
  expandableSwitch,
  router,
  customTrailing,
  contentHeader,
  custom
}
