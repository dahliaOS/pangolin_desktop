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

import 'package:pangolin/components/settings/widgets/settings_page.dart';
import 'package:pangolin/utils/extensions/extensions.dart';

class SettingsPageLocale extends StatefulWidget {
  const SettingsPageLocale({Key? key}) : super(key: key);

  @override
  _SettingsPageLocaleState createState() => _SettingsPageLocaleState();
}

class _SettingsPageLocaleState extends State<SettingsPageLocale> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: LSX.settings.pagesLocaleTitle,
      cards: const [],
    );
  }
}
