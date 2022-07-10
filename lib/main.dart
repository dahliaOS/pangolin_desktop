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

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:intl/locale.dart" as intl;
import 'package:logging/logging.dart';
import 'package:pangolin/components/shell/desktop.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/services/search.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/services/visual_engine/visual_engine.dart';
import 'package:pangolin/utils/data/dap_index.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/other/date_time_manager.dart';
import 'package:pangolin/utils/providers/clock_provider.dart';
import 'package:pangolin/utils/providers/connection_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/icon_provider.dart';
import 'package:pangolin/utils/providers/io_provider.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';
import 'package:pangolin/utils/providers/search_provider.dart';
import 'package:pangolin/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
        '${record.level.name}: ${record.message}\n${record.error}\n${record.stackTrace}',
      );
    }
  });

  // initialize locale providers
  await initProviders();

  await ServiceManager.registerService(SearchService.build);
  await ServiceManager.registerService(
    ApplicationService.build,
    fallback: ApplicationService.fallback(),
  );
  await ServiceManager.registerService(
    PreferencesService.build,
    fallback: PreferencesService.fallback(),
  );
  //PreferenceProvider();

  //initialize scheduler for time and date
  DateTimeManager.initialiseScheduler();

  //load visual engine
  await loadVisualEngine();
  if (kIsWeb == false) {
    if (Platform.isLinux) {
      indexApplications();
    }
  }

  runApp(
    YatlApp(
      core: yatl,
      getLocale: () => intl.Locale.tryParse(
        PreferencesService.current.get('locale') ?? "",
      )?.toFlutterLocale(),
      setLocale: (locale) =>
          PreferencesService.current.set('locale', locale?.toString()),
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
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        context.localizationsDelegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
