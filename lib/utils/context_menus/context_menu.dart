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
import 'package:pangolin/utils/context_menus/context_menu_item.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class ContextMenu extends StatefulWidget {
  final List<ContextMenuItem> items;

  const ContextMenu({super.key, required this.items});

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  Size size = Size.zero;
  @override
  Widget build(BuildContext context) {
    return BoxSurface(
      shape: Constants.smallShape,
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.items,
          ),
        ),
      ),
    );
  }
}
