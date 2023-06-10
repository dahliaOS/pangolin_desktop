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
import 'dart:developer';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:intl/locale.dart" as intl;
import 'package:logging/logging.dart';
import 'package:pangolin/components/shell/desktop.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/services/search.dart';
import 'package:pangolin/services/tray.dart';
import 'package:pangolin/services/wm.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      log(
        record.message,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
        name: record.loggerName,
        zone: record.zone,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    }
  });

  runApp(
    ServiceBuilderWidget(
      services: [
        const ServiceEntry<LocaleService>.critical(LocaleService.build),
        const ServiceEntry<SearchService>(SearchService.build),
        const ServiceEntry<WindowManagerService>.critical(
          WindowManagerService.build,
        ),
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
        ServiceEntry<PreferencesService>.critical(
          PreferencesService.build,
          PreferencesService.fallback(),
        ),
        ServiceEntry<TrayService>(
          TrayService.build,
          TrayService.fallback(),
        ),
        ServiceEntry<NotificationService>(
          NotificationService.build,
          NotificationService.fallback(),
        ),
        const ServiceEntry<CustomizationService>.critical(
          CustomizationService.build,
        ),
        const ServiceEntry<DateTimeService>.critical(DateTimeService.build),
      ],
      builder: (context, loaded, child) {
        if (!loaded) return const ColoredBox(color: Colors.black);

        return ListenableServiceBuilder<CustomizationService>(
          builder: (context, child) {
            final CustomizationService service = CustomizationService.current;
            return YatlApp(
              core: yatl,
              getLocale: () =>
                  intl.Locale.tryParse(service.locale)?.toFlutterLocale(),
              setLocale: (locale) => service.locale = locale?.toString(),
              child: child!,
            );
          },
          child: child,
        );
      },
      child: const Pangolin(),
    ),
  );
}

class Pangolin extends StatelessWidget {
  const Pangolin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableServiceBuilder<CustomizationService>(
      builder: (context, child) {
        return MaterialApp(
          home: child,
          theme: dahliaLightTheme,
          darkTheme: dahliaDarkTheme,
          themeMode: CustomizationService.current.darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
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
      },
      child: const Desktop(),
    );
  }
}
