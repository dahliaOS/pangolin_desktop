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
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/widgets/app_launcher_button.dart';

class LauncherGrid extends StatelessWidget {
  final PageController? controller;
  LauncherGrid({@required this.controller});

  @override
  Widget build(BuildContext context) {
    final minWidth = 512;
    double width = MediaQuery.of(context).size.width;
    // Calculate horizontal padding moultiplier based off of window width
    double horizontalWidgetPaddingMultiplier;
    if (width < minWidth) {
      // should have 0 horizontal padding if width smaller than `widget.minWidth`, so multiplier = 0
      horizontalWidgetPaddingMultiplier = 0;
    } else if (width < 1000) {
      // between `widget.minWidth` and 1000, so set to the result of a function that calculates smooth transition for multiplier
      // check https://www.desmos.com/calculator/lv1liilllb for a graph of this transition
      horizontalWidgetPaddingMultiplier =
          (width - minWidth) / (1000 - minWidth);
    } else {
      horizontalWidgetPaddingMultiplier = 1;
    }

    final _applications = applications;
    List<Application> _internet = List.empty(growable: true);
    List<Application> _media = List.empty(growable: true);
    List<Application> _gaming = List.empty(growable: true);
    List<Application> _development = List.empty(growable: true);
    List<Application> _office = List.empty(growable: true);
    List<Application> _system = List.empty(growable: true);
    _applications.forEach((element) {
      if (element.category == ApplicationCategory.INTERNET) {
        _internet.add(element);
      }
      if (element.category == ApplicationCategory.MEDIA) {
        _media.add(element);
      }
      if (element.category == ApplicationCategory.GAMING) {
        _gaming.add(element);
      }
      if (element.category == ApplicationCategory.DEVELOPMENT) {
        _development.add(element);
      }
      if (element.category == ApplicationCategory.OFFICE) {
        _office.add(element);
      }
      if (element.category == ApplicationCategory.SYSTEM) {
        _system.add(element);
      }
    });

    List<List> pages = [
      _applications,
      _internet,
      _media,
      _gaming,
      _development,
      _office,
      _system
    ];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalWidgetPaddingMultiplier * 200,
        ),
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            itemCount: pages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, pvindex) {
              final page = pages[pvindex];
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: pages[pvindex].length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // Flutter automatically calculates the optimal number of horizontal
                  // items with a MaxCrossAxisExtent in the app launcher grid
                  maxCrossAxisExtent: 175,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Application application = getApp(page[index].packageName!);
                  if (!application.canBeOpened) {
                    return IgnorePointer(
                      child: Opacity(
                        opacity: 0.4,
                        child: AppLauncherButton(application),
                      ),
                    );
                  }
                  return AppLauncherButton(application);
                },
              );
            }),
      ),
    );
  }
}
