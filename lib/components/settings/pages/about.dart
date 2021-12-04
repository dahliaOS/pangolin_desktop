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
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/theme/theme_manager.dart';

class SettingsPageAbout extends StatelessWidget {
  const SettingsPageAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*SettingsPage(
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
    )*/
        SingleChildScrollView(
            child: Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              color: ThemeManager.of(context).accentColorAlt,
            ),
            Image.asset(
              "assets/images/other/about-mask.png",
              width: double.maxFinite,
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                ),
                Image.asset(
                  "assets/images/logos/dahliaOS-white.png",
                  height: 50,
                ),
                Text(
                  "Version " + totalVersionNumber,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(50),
          child: Column(
            children: [
              const SettingsContentHeader("Kernel"),
              SettingsCard.withExpandable(
                value: false,
                leading: const Icon(Icons.memory),
                title: kernel,
              ),
              const SettingsContentHeader("Architecture"),
              SettingsCard.withExpandable(
                value: false,
                leading: const Icon(Icons.architecture),
                title: architecture,
              ),
              const SettingsContentHeader("Desktop"),
              SettingsCard.withExpandable(
                value: false,
                leading: const Icon(Icons.desktop_mac),
                title: "Pangolin " + pangolinCommit,
              ),
              const SettingsContentHeader("Software Update"),
              SettingsCard.withCustomTrailing(
                title: "dahliaOS is up to date - 21XXXX",
                subtitle: "Last checked: Today at 12:45 AM",
                leading: const Icon(Icons.update),
                trailing: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Check for updates"),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
