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
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/services/search.dart';
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
import 'package:pangolin/widgets/service_builder.dart';
import 'package:provider/provider.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      final StringBuffer buffer = StringBuffer();
      buffer.writeln('${record.level.name}: ${record.message}');

      if (record.error != null) {
        final List<String> parts = record.error.toString().split("\n");

        parts.map((e) => "\t$e").forEach(buffer.writeln);
      }

      if (record.error != null && record.stackTrace != null) {
        buffer.writeln();
      }

      if (record.stackTrace != null) {
        final List<String> parts = record.stackTrace.toString().split("\n");

        parts.map((e) => "\t$e").forEach(buffer.writeln);
      }

      print(buffer.toString());
    }
  });

  // initialize locale providers
  await initProviders();

  //initialize scheduler for time and date
  //DateTimeManager.initialiseScheduler();

  //load visual engine
  //await loadVisualEngine();
  if (kIsWeb == false) {
    if (Platform.isLinux) {
      indexApplications();
    }
  }

  runApp(
    ServiceBuilderWidget(
      services: [
        const ServiceEntry<SearchService>(SearchService.build),
        ServiceEntry<LangPacksService>(
          LangPacksService.build,
          LangPacksService.fallback(),
        ),
        ServiceEntry<ApplicationService>(
          ApplicationService.build,
          ApplicationService.fallback(),
        ),
        ServiceEntry<IconService>(
          IconService.build,
          IconService.fallback(),
        ),
        ServiceEntry<PreferencesService>(
          PreferencesService.build,
          PreferencesService.fallback(),
        ),
      ],
      onLoaded: () async {
        //initialize scheduler for time and date
        DateTimeManager.initialiseScheduler();

        //load visual engine
        await loadVisualEngine();
      },
      builder: (context, loaded, child) {
        if (!loaded) return const ColoredBox(color: Colors.red);

        return YatlApp(
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
            child: child,
          ),
        );
      },
      child: const Pangolin(),
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
