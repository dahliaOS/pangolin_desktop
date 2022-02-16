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

import 'package:pangolin/utils/providers/customization_provider.dart';

extension PreferenceExtension on CustomizationProvider {
  bool get isTaskbarLeft {
    if (taskbarPosition == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTaskbarRight {
    if (taskbarPosition == 3) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTaskbarTop {
    if (taskbarPosition == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTaskbarBottom {
    if (taskbarPosition == 2) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTaskbarVertical {
    if (taskbarPosition == 1 || taskbarPosition == 3) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTaskbarHorizontal {
    if (taskbarPosition == 2 || taskbarPosition == 0) {
      return true;
    } else {
      return false;
    }
  }
}
