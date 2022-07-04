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

import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/utils/data/native_names.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/widgets/global/quick_button.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class QsLanguagePage extends StatelessWidget {
  const QsLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QsTitlebar(
        title: strings.quicksettingsOverlay.quickControlsLanguageTitle,
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
          itemCount: locales.supportedLocales.length,
          itemBuilder: (context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Text(
                locales.supportedLocales[index]
                    .toString()
                    .substring(3)
                    .replaceAllMapped(
                      RegExp('[A-Z]'),
                      (match) => String.fromCharCode(
                        match.group(0)!.codeUnitAt(0) + 127397,
                      ),
                    ),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              title: Text(
                localeNativeNames[
                        locales.supportedLocales[index].languageCode] ??
                    "Language code not found",
              ),
              subtitle: Text(locales.supportedLocales[index].toLanguageTag()),
              trailing: Text(
                "${locales.progressData[locales.supportedLocales[index].toLanguageTag()]} / ${locales.progressData[context.fallbackLocale.toLanguageTag()]}",
              ),
              onTap: () {
                context.locale =
                    locales.supportedLocales[index].toFlutterLocale();

                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
