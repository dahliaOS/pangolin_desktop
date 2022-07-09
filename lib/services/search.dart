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

import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';

abstract class SearchService extends Service<SearchService> {
  SearchService() : super("SearchService");

  static SearchService get current {
    return ServiceManager.getService<SearchService>()!;
  }

  static SearchService build() {
    return _SearchServiceImpl();
  }

  FutureOr<List<Application>> search(String term);
}

class _SearchServiceImpl extends SearchService {
  @override
  List<Application> search(String term) {
    return applications
        .where((app) => app.name!.toLowerCase().contains(term.toLowerCase()))
        .toList();
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
