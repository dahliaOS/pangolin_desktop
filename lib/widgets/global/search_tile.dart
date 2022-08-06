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

import 'package:flutter/material.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/widgets/services.dart';

class SearchTile extends StatefulWidget {
  final String packageName;

  const SearchTile(this.packageName, {super.key});

  @override
  _SearchTileState createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile>
    with StateServiceListener<CustomizationService, SearchTile> {
  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final Application application = getApp(widget.packageName);

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
        autofocus: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(application.name),
        leading: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            getAppIcon(
              iconPath: application.iconName,
              usesRuntime: application.systemExecutable,
              height: 34,
            ),
          ],
        ),
        trailing: const Text("App"),
        subtitle: Text(application.description ?? ""),
        onTap: () {
          service.recentSearchResults = service.recentSearchResults = [
            ...service.recentSearchResults,
            application.packageName
          ];
          if (application.systemExecutable == true) {
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
