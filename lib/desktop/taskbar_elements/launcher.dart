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
import 'package:pangolin/desktop/taskbar_elements/search.dart';
import 'package:pangolin/desktop/wallpaper.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:pangolin/widgets/app_launcher_button.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class LauncherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            /* WmAPI(context).pushOverlayEntry(DismissibleOverlayEntry(
                content: Positioned(
                  left: 30,
                  right: 30,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.settings");
                        },
                        child: Text("Settings"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          WmAPI(context).openApp("io.dahlia.calculator");
                        },
                        child: Text("Calculator"),
                      ),
                    ],
                  ),
                ),
                uniqueId: 'launcher')); */

            WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "launcher", content: LauncherOverlay()));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: Icon(Icons.apps)),
          ),
        ),
      ),
    );
  }
}

class LauncherOverlay extends StatefulWidget {
  final minWidth = 512;

  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay> {
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
    final _controller = PageController();

    double width = MediaQuery.of(context).size.width;
    // Calculate horizontal padding moultiplier based off of window width
    double horizontalWidgetPaddingMultiplier;
    if (width < widget.minWidth) {
      // should have 0 horizontal padding if width smaller than `widget.minWidth`, so multiplier = 0
      horizontalWidgetPaddingMultiplier = 0;
    } else if (width < 1000) {
      // between `widget.minWidth` and 1000, so set to the result of a function that calculates smooth transition for multiplier
      // check https://www.desmos.com/calculator/lv1liilllb for a graph of this transition
      horizontalWidgetPaddingMultiplier =
          (width - widget.minWidth) / (1000 - widget.minWidth);
    } else {
      horizontalWidgetPaddingMultiplier = 1;
    }

    return Positioned(
      top: 0,
      bottom: 48,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          WmAPI.of(context).popOverlayEntry(
              Provider.of<DismissibleOverlayEntry>(context, listen: false));
          setState(() {});
        },
        child: Stack(
          children: [
            Wallpaper(),
            BoxContainer(
              useBlur: true,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Searchbar(
                        onTextChanged: (change) {
                          WmAPI.of(context).popOverlayEntry(
                              Provider.of<DismissibleOverlayEntry>(context,
                                  listen: false));
                          WmAPI.of(context)
                              .pushOverlayEntry(DismissibleOverlayEntry(
                                  uniqueId: "search",
                                  content: Search(
                                    text: change,
                                  )));
                        },
                        leading: Icon(Icons.search),
                        trailing: Icon(Icons.menu),
                        hint: "Search Device, Apps and Web",
                        controller: TextEditingController(),
                        borderRadius: BorderRadius.circular(
                          8 * horizontalWidgetPaddingMultiplier,
                        ),
                      )),
                  Container(
                    //color: Colors.white,
                    // The row of chips 'test test test test' lol
                    margin: const EdgeInsets.only(top: 33 + (1 / 3), bottom: 8),
                    child: BoxContainer(
                      customBorderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      useSystemOpacity: true,
                      // have to give explicit size, as the child ListView can't calculate its Y height
                      height: 38,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: launcherCategories.length,
                        itemBuilder: (context, index) {
                          return BoxContainer(
                            useBlur: false,
                            useSystemOpacity: _selected == index,
                            customBorderRadius: BorderRadius.circular(8),
                            color: _selected == index
                                ? Colors.white
                                : Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selected = index;
                                  });
                                  _controller.animateToPage(index,
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalWidgetPaddingMultiplier * 200,
                      ),
                      child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _controller,
                          itemCount: pages.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, pvindex) {
                            final page = pages[pvindex];
                            return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: pages[pvindex].length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                // Flutter automatically calculates the optimal number of horizontal
                                // items with a MaxCrossAxisExtent in the app launcher grid
                                maxCrossAxisExtent: 175,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return AppLauncherButton(
                                    page[index].packageName!);
                              },
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: BoxContainer(
                      width: 28 * 3 + 16 * 4,
                      height: 32 + 16,
                      color: Colors.white,
                      useSystemOpacity: true,
                      customBorderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TODO Power overlay
                          InkWell(
                            onTap: () {},
                            mouseCursor: SystemMouseCursors.click,
                            child: Icon(
                              Icons.power_settings_new,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () {},
                            mouseCursor: SystemMouseCursors.click,
                            child: Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () {
                              WmAPI.of(context).popOverlayEntry(
                                  Provider.of<DismissibleOverlayEntry>(context,
                                      listen: false));
                              WmAPI.of(context).openApp("io.dahlia.settings");
                              setState(() {});
                            },
                            mouseCursor: SystemMouseCursors.click,
                            child: Icon(
                              Icons.settings_outlined,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
