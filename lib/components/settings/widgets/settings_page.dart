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

class SettingsPage extends StatelessWidget {
  final String title;
  final List<Widget> cards;

  const SettingsPage({required this.title, required this.cards, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(left: 64, top: 42),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 96, 0, 24),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 500,
            child: ListView(
              padding: const EdgeInsets.only(
                left: 64,
                right: 64,
              ),
              physics: const BouncingScrollPhysics(),
              children: cards,
            ),
          ),
        ),
      ],
    );
  }
}
