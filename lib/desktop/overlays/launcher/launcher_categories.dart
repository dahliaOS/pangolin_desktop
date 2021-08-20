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
import 'package:pangolin/internal/locales/locale_strings.g.dart';
import 'package:pangolin/utils/common_data.dart';

class LauncherCategories extends StatefulWidget {
  final PageController? controller;

  LauncherCategories({this.controller});

  @override
  _LauncherCategoriesState createState() => _LauncherCategoriesState();
}

class _LauncherCategoriesState extends State<LauncherCategories> {
  GlobalKey key = GlobalKey();
  var _selected = 0;
  Size? s;

  @override
  Widget build(BuildContext context) {
    List<String> launcherCategories = [
      LocaleStrings.launcher.categoriesAll,
      LocaleStrings.launcher.categoriesInternet,
      LocaleStrings.launcher.categoriesMedia,
      LocaleStrings.launcher.categoriesGaming,
      LocaleStrings.launcher.categoriesDevelopment,
      LocaleStrings.launcher.categoriesOffice,
      LocaleStrings.launcher.categoriesSystem
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.0,
          child: Container(
            //width: 652,
            //color: Colors.white,
            // The row of chips 'test test test test' lol
            margin: const EdgeInsets.only(top: 33 + (1 / 3), bottom: 8),
            child: BoxContainer(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.MEDIUM),
              // have to give explicit size, as the child ListView can't calculate its Y height
              height: 42,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: launcherCategories.length,
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: CommonData.of(context)
                        .borderRadius(BorderRadiusType.SMALL),
                    color: _selected == index
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    child: InkWell(
                        borderRadius: CommonData.of(context)
                            .borderRadius(BorderRadiusType.SMALL),
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
                            child: Text(
                              launcherCategories[index],
                              style: TextStyle(
                                  fontWeight: _selected == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: _selected == index
                                      ? CommonData.of(context).textColorAlt()
                                      : CommonData.of(context).textColor()),
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
