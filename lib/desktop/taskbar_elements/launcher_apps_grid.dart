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
import 'package:pangolin/widgets/app_launcher_button.dart';

class LauncherAppsGrid extends StatelessWidget {
  final Map<String, Application> applications;

  const LauncherAppsGrid({
    Key? key,
    required this.applications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: applications.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // Flutter automatically calculates the optimal number of horizontal
        // items with a MaxCrossAxisExtent in the app launcher grid
        maxCrossAxisExtent: 175,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemBuilder: (BuildContext context, int index) {
        var keys = applications.keys.toList();
        return AppLauncherButton(keys[index]);
      },
    );
  }
}
