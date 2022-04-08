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

import 'package:pangolin/components/settings/widgets/list_tiles.dart';
import 'package:pangolin/components/settings/widgets/settings_card.dart';
import 'package:pangolin/components/settings/widgets/settings_content_header.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class SettingsPageAbout extends StatelessWidget {
  const SettingsPageAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                color: context.theme.accent,
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
                  children: [
                    Container(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/images/logos/dahliaOS-white.png",
                      height: 50,
                    ),
                    Text(
                      //TODO Localize
                      totalVersionNumber,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              children: [
                SettingsContentHeader(
                  LSX.settings.pagesAboutSystemInformation,
                ),
                SettingsCard(
                  children: [
                    ListTile(
                      title: Text(
                        LSX.settings.pagesAboutSystemInformationEnvironment,
                      ),
                      subtitle: Text(kernel),
                      leading: const Icon(Icons.memory),
                    ),
                    ListTile(
                      title: Text(
                        LSX.settings.pagesAboutSystemInformationArchitecture,
                      ),
                      subtitle: Text(architecture),
                      leading: const Icon(Icons.architecture),
                    ),
                    ListTile(
                      title:
                          Text(LSX.settings.pagesAboutSystemInformationDesktop),
                      subtitle: Text("Pangolin $pangolinCommit"),
                      leading: const Icon(Icons.desktop_mac),
                    )
                  ],
                ),
                SettingsContentHeader(LSX.settings.pagesAboutSoftwareUpdate),
                SettingsCard(
                  children: [
                    ListTile(
                      title: Text(
                        LSX.settings
                            .pagesAboutSoftwareUpdateTileTitle("220222"),
                      ),
                      subtitle: Text(
                        LSX.settings.pagesAboutSoftwareUpdateTileSubtitle(
                          "2/22/2022",
                        ),
                      ),
                      leading: const Icon(Icons.update),
                      trailing: ElevatedButton(
                        onPressed: null,
                        child: Padding(
                          padding: ThemeConstants.buttonPadding,
                          child: const Text(
                            "Updates Disabled",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SettingsContentHeader("Legal"),
                SettingsCard(
                  children: [
                    RouterListTile(
                      leading: const Icon(Icons.info_outline_rounded),
                      title: const Text("Licenses"),
                      subtitle: const Text("Show third party licenses"),
                      onTap: () => showLicensePage(
                        context: context,
                        applicationName: "Pangolin Desktop",
                        applicationIcon: Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Image.asset(
                            "assets/images/logos/pangolin.png",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        applicationLegalese: "Apache-2.0 License",
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
