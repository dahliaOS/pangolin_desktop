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

import 'dart:io';

import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/search_provider.dart';

class SearchTile extends StatefulWidget {
  final String packageName;
  const SearchTile(this.packageName, {Key? key}) : super(key: key);

  @override
  _SearchTileState createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    final Application application = getApp(widget.packageName);
    final _searchProvider = SearchProvider.of(context);
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
        autofocus: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(application.name ?? ""),
        leading: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            getAppIcon(application.systemExecutable, application.iconName, 34),
          ],
        ),
        trailing: const Text("App"),
        subtitle: Text(application.description ?? ""),
        onTap: () {
          _searchProvider.addRecentSearchResult(application.packageName);
          if (application.systemExecutable == true) {
            print(application.runtimeFlags.toString());
            Process.run(
              'io.dahliaos.web_runtime.dap',
              application.runtimeFlags,
            );
          }
          application.launch(context);
        },
      ),
    );
  }
}
