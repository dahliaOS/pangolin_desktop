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
import 'package:pangolin/settings/widgets/settings_card.dart';
import 'package:pangolin/settings/widgets/settings_page.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/utils/theme_manager.dart';

class SettingsPageAbout extends StatelessWidget {
  const SettingsPageAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: "About",
      cards: [
        SettingsCard.custom(
          content: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/images/logos/dahliaOS-logo.png",
                      height: 128,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        longName,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: ThemeManager.of(context)
                                  .foregroundColorOnSurface,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        kernel,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: ThemeManager.of(context)
                                  .foregroundColorOnSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
