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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/shell/desktop.dart';
import 'package:pangolin/services/locales/generated_asset_loader.g.dart';
import 'package:pangolin/services/locales/locales.g.dart';
import 'package:pangolin/components/settings/data/presets.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/clock_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/icon_provider.dart';
import 'package:pangolin/utils/providers/io_provider.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:pangolin/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/services/visual_engine/visual_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize the database
  await DatabaseManager.initialseDatabase();
  PreferenceProvider();

  //initialize scheduler for time and date
  DateTimeManager.initialiseScheduler();

  //Fix old database entries
  if (double.tryParse(DatabaseManager.get("wallpaper")) != null) {
    DatabaseManager.set("wallpaper", "assets/images/wallpapers/modern.png");
  }

  //initialize the localization engine
  await EasyLocalization.ensureInitialized();

  //load customization presets
  SettingsPresets.loadPresets();

  //load visual engine
  await loadVisualEngine();

  runApp(
    EasyLocalization(
      supportedLocales: Locales.supported,
      fallbackLocale: const Locale("en", "US"),
      useFallbackTranslations: true,
      assetLoader: GeneratedAssetLoader(),
      path: "assets/locales",
      startLocale: Locale("en", "US"),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PreferenceProvider>.value(
            value: PreferenceProvider(),
          ),
          ChangeNotifierProvider<FeatureFlags>.value(
            value: FeatureFlags(),
          ),
          ChangeNotifierProvider<IconProvider>.value(
            value: IconProvider(),
          ),
          ChangeNotifierProvider<IOProvider>.value(
            value: IOProvider(),
          ),
          ChangeNotifierProvider<CustomizationProvider>.value(
            value: CustomizationProvider(),
          ),
          ChangeNotifierProvider<MiscProvider>.value(
            value: MiscProvider(),
          ),
          ChangeNotifierProvider<ClockProvider>.value(
            value: ClockProvider(),
          ),
        ],
        child: Pangolin(),
      ),
    ),
  );
}

class Pangolin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Desktop(),
      theme: theme(context),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
