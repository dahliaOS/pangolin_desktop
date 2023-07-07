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
import 'package:flutter/material.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/resource/auto_image.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

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
    final DesktopEntry application =
        ApplicationService.current.getApp(widget.packageName)!;

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
        autofocus: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(application.getLocalizedName(context.locale)),
        leading: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            AutoVisualResource(
              resource: application.icon!.main,
              size: 30,
            ),
          ],
        ),
        trailing: Text(strings.searchOverlay.app),
        subtitle: application.comment != null
            ? Text(application.getLocalizedComment(context.locale)!)
            : null,
        onTap: () async {
          service.recentSearchResults = [
            ...service.recentSearchResults,
            application.id
          ];
          await ApplicationService.current.startApp(application.id);
          ShellService.current.dismissEverything();
        },
      ),
    );
  }
}
