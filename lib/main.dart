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
import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pangolin/components/shell/desktop.dart';
import 'package:pangolin/services/locales/generated_asset_loader.g.dart';
import 'package:pangolin/services/visual_engine/visual_engine.dart';
import 'package:pangolin/utils/data/dap_index.dart';
import 'package:pangolin/utils/data/database_manager.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/other/date_time_manager.dart';
import 'package:pangolin/utils/providers/clock_provider.dart';
import 'package:pangolin/utils/providers/connection_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/icon_provider.dart';
import 'package:pangolin/utils/providers/io_provider.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:pangolin/utils/providers/search_provider.dart';
import 'package:pangolin/utils/theme/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize the database
  await DatabaseManager.initialseDatabase();
  //PreferenceProvider();

  //initialize scheduler for time and date
  DateTimeManager.initialiseScheduler();

  //initialize the localization engine
  await EasyLocalization.ensureInitialized();

  //load visual engine
  await loadVisualEngine();
  if (kIsWeb == false) {
    if (Platform.isLinux) {
      indexApplications();
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: Locales.supported,
      fallbackLocale: const Locale("en", "US"),
      useFallbackTranslations: false,
      assetLoader: GeneratedAssetLoader(),
      path: "assets/locales",
      startLocale: const Locale("en", "US"),
      saveLocale: false,
      child: MultiProvider(
        providers: [
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
          ChangeNotifierProvider<ConnectionProvider>.value(
            value: ConnectionProvider(),
          ),
          ChangeNotifierProvider<SearchProvider>.value(
            value: SearchProvider(),
          ),
        ],
        child: const Pangolin(),
      ),
    ),
  );
}

class Pangolin extends StatelessWidget {
  const Pangolin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Desktop(),
      theme: theme(context),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
