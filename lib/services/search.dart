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

import 'dart:async';
import 'dart:ui' as ui;

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:xdg_desktop/xdg_desktop.dart';

class SearchServiceFactory extends ServiceFactory<SearchService> {
  const SearchServiceFactory();

  @override
  SearchService build() => _SearchServiceImpl();
}

abstract class SearchService extends Service {
  SearchService();

  static SearchService get current {
    return ServiceManager.getService<SearchService>()!;
  }

  FutureOr<List<DesktopEntry>> search(String term, [ui.Locale? locale]);
}

class _SearchServiceImpl extends SearchService {
  @override
  List<DesktopEntry> search(String term, [ui.Locale? locale]) {
    final List<DesktopEntry> entries =
        ApplicationService.current.listApplications();

    return entries.where((app) {
      final String name =
          _localizeWithLocale(locale, app.getLocalizedName) ?? app.name.main;
      final String comment =
          _localizeWithLocale(locale, app.getLocalizedComment) ??
              app.comment?.main ??
              "";
      final List<String> keywords =
          _localizeWithLocale(locale, app.getLocalizedKeywords) ??
              app.keywords?.main ??
              [];

      return name.caseInsensitiveContains(term) ||
          comment.caseInsensitiveContains(term) ||
          keywords.any((e) => e.caseInsensitiveContains(term));
    }).toList();
  }

  T? _localizeWithLocale<T>(
    ui.Locale? locale,
    T? Function(ui.Locale) callback,
  ) {
    return locale != null ? callback(locale) : null;
  }

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

extension on String {
  bool caseInsensitiveContains(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }
}
