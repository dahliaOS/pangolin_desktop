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

Widget ConditionWidget(bool condition, Widget child) {
  if (condition == true) {
    return child;
  } else {
    return SizedBox.shrink(); //or any other widget but not null
  }
}

Widget CustomConditionWidget(bool condition, Widget isTrue, Widget isFalse) {
  if (condition == true) {
    return isTrue;
  } else {
    return isFalse; //or any other widget but not null
  }
}
