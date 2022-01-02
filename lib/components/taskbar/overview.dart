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
import 'package:pangolin/components/overlays/overview_overlay.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class OverviewButton extends StatelessWidget {
  const OverviewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TaskbarElement(
      overlayID: OverviewOverlay.overlayId,
      child: Icon(Icons.fullscreen_exit_outlined),
    );
  }
}
