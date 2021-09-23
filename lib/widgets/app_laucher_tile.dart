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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';

class AppLauncherTile extends StatefulWidget {
  final String packageName;
  const AppLauncherTile(this.packageName);

  @override
  _AppLauncherTileState createState() => _AppLauncherTileState();
}

class _AppLauncherTileState extends State<AppLauncherTile> {
  @override
  Widget build(BuildContext context) {
    final Application application = getApp(widget.packageName);
    final _pref = Provider.of<PreferenceProvider>(context);
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 2),
        autofocus: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(application.name ?? ""),
        leading: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/icons/${application.iconName}.png",
              height: 34,
            ),
          ],
        ),
        trailing: Text("App"),
        subtitle: Text(application.description ?? ""),
        onTap: () {
          _pref.addRecentSearchResult(application.packageName!);
          Shell.of(context, listen: false).dismissEverything();
          WmAPI.of(context).openApp(widget.packageName);
        },
      ),
    );
  }
}
