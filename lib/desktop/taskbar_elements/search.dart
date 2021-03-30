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
import 'package:flutter/rendering.dart';
import 'package:pangolin/desktop/overlays/search_overlay.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          borderRadius: BorderRadius.circular(4),
          color: Provider.of<WindowHierarchyState>(context)
                  .overlayIsActive("search")
              ? Theme.of(context).cardColor.withOpacity(0.5)
              : Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                  uniqueId: "search",
                  content: SearchOverlay(),
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut));
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Center(child: Icon(Icons.search, size: 20)),
            ),
          ),
        ),
      ),
    );
  }
}