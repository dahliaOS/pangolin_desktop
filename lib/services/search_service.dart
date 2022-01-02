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

import 'package:flutter/widgets.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';

class SearchNotifier {
  final termSearchResult = ValueNotifier<List<Application>>(<Application>[]);

  Future<void> globalSearch(String searchInputTerm) async {
    final _searchInputResult = <Application>[];
    // await Future.delayed(Duration(milliseconds: 250));
    if (searchInputTerm.isNotEmpty) {
      for (final Application app in applications) {
        if (app.name!.toLowerCase().contains(searchInputTerm.toLowerCase())) {
          _searchInputResult.add(app);
          termSearchResult.value = _searchInputResult;
        }
      }
    } else {
      termSearchResult.value = [];
    }
  }
}
