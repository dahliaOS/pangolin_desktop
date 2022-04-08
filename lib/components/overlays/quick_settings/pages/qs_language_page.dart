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

import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/services/locales/native_names.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/global/quick_button.dart';

class QsLanguagePage extends StatelessWidget {
  const QsLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QsTitlebar(
        title: LSX.quicksettingsOverlay.quickControlsLanguageTitle,
        trailing: const [
          QuickActionButton(
            leading: Icon(
              Icons.help_outline_rounded,
              size: 20,
            ),
            margin: EdgeInsets.zero,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: Locales.supported.length,
          itemBuilder: (context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Flag.fromString(
                Locales.supported[index].languageCode.replaceAll("en", "us"),
                width: 32,
                replacement: const Icon(Icons.language_outlined),
              ),
              title: Text(
                localeNativeNames[Locales.supported[index].languageCode] ??
                    "Language code not found",
              ),
              subtitle: Text(Locales.supported[index].languageCode),
              onTap: () {
                context.setLocale(Locales.supported[index]);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
