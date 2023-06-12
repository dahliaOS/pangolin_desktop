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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/quick_settings/quick_settings_overlay.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/utils/data/native_names.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class QsLanguagePage extends StatelessWidget {
  // ignore: use_super_parameters
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
            final int? translatedStrings = locales
                .progressData[locales.supportedLocales[index].toLanguageTag()];
            final int? totalTranslationStrings =
                locales.progressData[context.fallbackLocale.toLanguageTag()];
            final double translationPercentage =
                translatedStrings! / totalTranslationStrings! * 100;
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Text(
                // Select every supported locale's country code.
                locales.supportedLocales[index].countryCode!.replaceAllMapped(
                  //  Select each character with regex.
                  RegExp('[A-Z]'),
                  // Convert the regional indicator symbols' values to a string (flag emoji).
                  (match) => String.fromCharCode(
                    // .codeUnitAt(0) converts each character to a rune.
                    // By adding to 127397 we are converting each rune to a regional indicator symbol.
                    // The 127397 comes from the Regional Indicator Symbol 🇦's HTML code, 127462, minus the rune value of A, 65.
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
              trailing: Text("${translationPercentage.toStringAsFixed(0)}%"),
              onTap: () {
                context.locale = context.supportedLocales[index];

                QsController.popRoute(context);
              },
            );
          },
        ),
      ),
    );
  }
}
