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
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:intl/locale.dart" as intl;
import 'package:pangolin/components/shell/desktop.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/services/power.dart';
import 'package:pangolin/services/search.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/services/tray.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/other/logging.dart';
import 'package:yatl_flutter/yatl_flutter.dart';
import 'package:zenit_ui/zenit_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();

  runApp(
    ServiceBuilderWidget(
      services: const [
        ServiceEntry<ShellService>.critical(ShellServiceFactory()),
        ServiceEntry<LocaleService>.critical(LocaleServiceFactory()),
        ServiceEntry<SearchService>(SearchServiceFactory()),
        ServiceEntry<WindowManagerService>.critical(
          WindowManagerServiceFactory(),
        ),
        ServiceEntry<LangPacksService>(LangPacksServiceFactory()),
        ServiceEntry<ApplicationService>(ApplicationServiceFactory()),
        ServiceEntry<IconService>(IconServiceFactory()),
        ServiceEntry<PreferencesService>.critical(PreferencesServiceFactory()),
        ServiceEntry<TrayService>(TrayServiceFactory()),
        ServiceEntry<NotificationService>(NotificationServiceFactory()),
        ServiceEntry<PowerService>(PowerServiceFactory()),
        ServiceEntry<CustomizationService>.critical(
          CustomizationServiceFactory(),
        ),
        ServiceEntry<DateTimeService>.critical(DateTimeServiceFactory()),
      ],
      builder: (context, loaded, child) {
        if (!loaded) return const ColoredBox(color: Colors.black);
        if (kIsWeb) BrowserContextMenu.disableContextMenu();

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
          theme: createZenitTheme(
            primaryColor: CustomizationService.current.accentColor.resolve(),
          ),
          darkTheme: createZenitTheme(
            brightness: Brightness.dark,
            primaryColor: CustomizationService.current.accentColor.resolve(),
          ),
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
