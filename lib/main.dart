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
import 'package:pangolin/desktop/desktop.dart';
import 'package:pangolin/internal/locales/generated_asset_loader.g.dart';
import 'package:pangolin/internal/locales/locales.g.dart';
import 'package:pangolin/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/internal/visualEngine/visualEngine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseManager.initialseDatabase();
  PreferenceProvider();
  DateTimeManager.initialiseScheduler();
  DateTimeManager.setDateFormat("yMMMMd");
  if (double.tryParse(DatabaseManager.get("wallpaper")) != null) {
    DatabaseManager.set(
        "wallpaper", "assets/images/wallpapers/Three_Bubbles.png");
  }

  await EasyLocalization.ensureInitialized();
  await loadVisualEngine();
  runApp(
    EasyLocalization(
      supportedLocales: Locales.supported,
      fallbackLocale: Locale("en", "US"),
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
      home: Desktop(),
      theme: theme(context),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
