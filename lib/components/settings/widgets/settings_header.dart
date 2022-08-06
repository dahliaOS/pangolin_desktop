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

class SettingsHeader extends StatelessWidget {
  final String? heading;

  const SettingsHeader({required this.heading, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
          child: Text(
            heading ?? "NULL",
            style: const TextStyle(
              fontSize: 17,
              letterSpacing: 0.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
