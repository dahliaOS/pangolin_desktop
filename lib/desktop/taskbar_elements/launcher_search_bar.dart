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

import 'package:flutter/material.dart';
import 'package:pangolin/desktop/taskbar_elements/search.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class LauncherSearchBar extends StatelessWidget {
  const LauncherSearchBar({
    Key? key,
    required this.horizontalWidgetPaddingMultiplier,
  }) : super(key: key);

  final double horizontalWidgetPaddingMultiplier;

  @override
  Widget build(BuildContext context) {
    return Searchbar(
      onTextChanged: (change) {
        WmAPI.of(context).popOverlayEntry(
            Provider.of<DismissibleOverlayEntry>(context, listen: false));
        WmAPI.of(context).pushOverlayEntry(
            DismissibleOverlayEntry(uniqueId: "search", content: Search()));
      },
      leading: Icon(Icons.search),
      trailing: Icon(Icons.menu),
      hint: "Search Device, Apps and Web",
      controller: TextEditingController(),
      borderRadius: BorderRadius.circular(
        8 * horizontalWidgetPaddingMultiplier,
      ),
    );
  }
}
