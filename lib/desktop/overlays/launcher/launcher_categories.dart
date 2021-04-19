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
import 'package:flutter/rendering.dart';

class LauncherCategories extends StatefulWidget {
  final PageController? controller;

  LauncherCategories({this.controller});

  @override
  _LauncherCategoriesState createState() => _LauncherCategoriesState();
}

class _LauncherCategoriesState extends State<LauncherCategories> {
  GlobalKey key = GlobalKey();
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    List<String> launcherCategories = [
      "All Applications",
      "Internet",
      "Media",
      "Gaming",
      "Development",
      "Office",
      "System"
    ];
    return Container(
      //color: Colors.white,
      // The row of chips 'test test test test' lol
      margin: const EdgeInsets.only(top: 33 + (1 / 3), bottom: 8),
      child: BoxContainer(
        customBorderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
        useSystemOpacity: true,
        // have to give explicit size, as the child ListView can't calculate its Y height
        height: 38,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: launcherCategories.length,
          itemBuilder: (context, index) {
            return BoxContainer(
              useSystemOpacity: _selected == index,
              //customBorderRadius: BorderRadius.circular(8),
              color: _selected == index
                  ? Theme.of(context).backgroundColor
                  : Colors.transparent,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _selected = index;
                    });
                    widget.controller?.animateToPage(index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  mouseCursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 18),
                    child: Center(
                      child: Text(launcherCategories[index]),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}
