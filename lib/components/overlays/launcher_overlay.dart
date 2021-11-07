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
import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/overlays/search_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/locales/locale_strings.g.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/services/wm_api.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/widgets/app_launcher/app_launcher_button.dart';
import 'package:pangolin/widgets/searchbar/searchbar.dart';

class LauncherOverlay extends ShellOverlay {
  static const String overlayId = 'launcher';

  LauncherOverlay() : super(id: overlayId);

  @override
  _LauncherOverlayState createState() => _LauncherOverlayState();
}

class _LauncherOverlayState extends State<LauncherOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: CommonData.of(context).animationDuration(),
    );
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  final _focusNode = FocusNode(canRequestFocus: true);
  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    final _shell = Shell.of(context);
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );
    final _controller = PageController();

    _focusNode.requestFocus();

    if (!controller.showing) return SizedBox();

    return Positioned(
      top: !_customizationProvider.isTaskbarTop ? 0 : 48,
      bottom: _customizationProvider.isTaskbarTop
          ? 0
          : _customizationProvider.isTaskbarLeft ||
                  _customizationProvider.isTaskbarRight
              ? 0
              : 48,
      left: _customizationProvider.isTaskbarLeft ? 48 : 0,
      right: _customizationProvider.isTaskbarRight ? 48 : 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0.5) {
            ac.value = ac.value - details.delta.dy / 1200;
          } else if (details.delta.dy < -1 && ac.value < 1) {
            ac.value = ac.value - details.delta.dy / 800;
          }
        },
        onVerticalDragEnd: (details) async {
          if (ac.value > 0.6) {
            ac.animateBack(1.0);
          } else {
            await ac.reverse();
            _shell.dismissOverlay(LauncherOverlay.overlayId);
          }
        },
        onTap: () async {
          await ac.reverse();
          _shell.dismissOverlay(LauncherOverlay.overlayId);
        },
        child: Stack(
          children: [
            //Positioned.fill(top: 0, child: Wallpaper()),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                  scale: _animation,
                  alignment: _customizationProvider.taskbarPosition != 0
                      ? FractionalOffset.bottomCenter
                      : FractionalOffset.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Search(),
                      LauncherCategories(controller: _controller),
                      LauncherGrid(controller: _controller),
                      LauncherPowerMenu(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);

    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Searchbar(
        onTextChanged: (change) {
          _shell.dismissOverlay(LauncherOverlay.overlayId);
          _shell.showOverlay(
            SearchOverlay.overlayId,
            args: {"searchQuery": change},
            dismissEverything: false,
          );
        },
        leading: Icon(Icons.search),
        trailing: Icon(Icons.menu),
        hint: "Search Device, Apps and Web",
        controller: TextEditingController(),
      ),
    );
  }
}

// Categories

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
              outline: false,
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.ROUND),
              // have to give explicit size, as the child ListView can't calculate its Y height
              height: 42,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: launcherCategories.length,
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: CommonData.of(context)
                        .borderRadius(BorderRadiusType.ROUND),
                    color: _selected == index
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.ROUND),
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
                                    ? context.theme.colorScheme.secondary
                                                .computeLuminance() <
                                            0.4
                                        ? !context.theme.darkMode
                                            ? CommonData.of(context)
                                                .textColorAlt()
                                            : CommonData.of(context).textColor()
                                        : CommonData.of(context).textColor()
                                    : CommonData.of(context).textColor()),
                          ),
                        ),
                      ),
                    ),
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

// Grid

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
                  final Application application =
                      getApp(page[index].packageName!);
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

// Power Menu

class LauncherPowerMenu extends StatefulWidget {
  @override
  _LauncherPowerMenuState createState() => _LauncherPowerMenuState();
}

class _LauncherPowerMenuState extends State<LauncherPowerMenu> {
  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        width: 28 * 3 + 16 * 4,
        height: 32 + 16,
        child: BoxContainer(
          borderRadius:
              CommonData.of(context).borderRadius(BorderRadiusType.MEDIUM),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.MEDIUM),
                      onTap: () async {
                        _shell.dismissOverlay(LauncherOverlay.overlayId);
                        await Future.delayed(const Duration(milliseconds: 150));
                        _shell.showOverlay(PowerOverlay.overlayId,
                            dismissEverything: false);
                        setState(() {});
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.power_settings_new,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.MEDIUM),
                      onTap: () {},
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 32 + 16,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.MEDIUM),
                      onTap: () {
                        _shell.dismissEverything();
                        WmAPI.of(context).openApp("io.dahlia.settings");
                        setState(() {});
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.settings_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
