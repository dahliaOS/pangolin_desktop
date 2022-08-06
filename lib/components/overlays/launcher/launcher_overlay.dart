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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/launcher/app_launcher.dart';
import 'package:pangolin/components/overlays/search/search_overlay.dart';
import 'package:pangolin/components/overlays/search/widgets/searchbar.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/application.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/utils/wm/wm_api.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/quick_button.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class LauncherOverlay extends ShellOverlay {
  static const String overlayId = 'launcher';

  LauncherOverlay({super.key}) : super(id: overlayId);

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
      duration: Constants.animationDuration,
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
    WmAPI.of(context).minimizeAll();
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    if (mounted) WmAPI.of(context).undoMinimizeAll();
    controller.showing = false;
  }

  final FocusNode _focusNode = FocusNode();
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final ShellState shell = Shell.of(context);
    final Animation<double> animation = CurvedAnimation(
      parent: ac,
      curve: Constants.animationCurve,
    );

    _focusNode.requestFocus();

    if (!controller.showing) return const SizedBox();

    return Positioned(
      top: 0,
      bottom: 48,
      left: 0,
      right: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
            shell.dismissOverlay(LauncherOverlay.overlayId);
          }
        },
        onTap: () async {
          await ac.reverse();
          shell.dismissOverlay(LauncherOverlay.overlayId);
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  alignment: FractionalOffset.bottomCenter,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 56,
                        right: 56,
                        child: QuickActionButton(
                          leading: const Icon(Icons.close_fullscreen_rounded),
                          onPressed: () {
                            ActionManager.switchLauncher(context);
                          },
                        ),
                      ),
                      Column(
                        children: [
                          const Search(),
                          LauncherCategories(controller: _controller),
                          LauncherGrid(controller: _controller),
                          const LauncherActionMenu(),
                        ],
                      ),
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

class Search extends StatefulWidget {
  const Search({
    super.key,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final ShellState shell = Shell.of(context);

    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKey: (event) async {
        if (event.character == null ||
            !RegExp("[a-zA-Z]").hasMatch(event.character!)) return;

        shell.dismissOverlay(LauncherOverlay.overlayId);
        await Future.delayed(const Duration(milliseconds: 150));
        shell.showOverlay(
          SearchOverlay.overlayId,
          args: {"searchQuery": event.character},
          dismissEverything: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Searchbar(
          onTextChanged: (change) {
            shell.dismissOverlay(LauncherOverlay.overlayId);
            shell.showOverlay(
              SearchOverlay.overlayId,
              args: {"searchQuery": change},
              dismissEverything: false,
            );
          },
          leading: const Icon(Icons.search),
          trailing: const Icon(Icons.menu),
          hint: "Search Device, Apps and Web",
          controller: TextEditingController(),
        ),
      ),
    );
  }
}

// Categories

class LauncherCategories extends StatefulWidget {
  final PageController? controller;

  const LauncherCategories({this.controller, super.key});

  @override
  _LauncherCategoriesState createState() => _LauncherCategoriesState();
}

class _LauncherCategoriesState extends State<LauncherCategories> {
  GlobalKey key = GlobalKey();
  var _selected = 0;
  Size? s;
  static List<String> get launcherCategories => <String>[
        strings.launcherOverlay.categoriesAllApplications,
        strings.launcherOverlay.categoriesInternet,
        strings.launcherOverlay.categoriesMedia,
        strings.launcherOverlay.categoriesGaming,
        strings.launcherOverlay.categoriesDevelopment,
        strings.launcherOverlay.categoriesOffice,
        strings.launcherOverlay.categoriesSystem
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 33 + (1 / 3), bottom: 8),
      child: IntrinsicWidth(
        child: BoxContainer(
          shape: Constants.circularShape,
          // have to give explicit size, as the child ListView can't calculate its Y height
          height: 42,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: launcherCategories.mapIndexed((index, item) {
              return Material(
                shape: Constants.circularShape,
                clipBehavior: Clip.antiAlias,
                color: _selected == index
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() => _selected = index);
                    widget.controller?.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  mouseCursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 18,
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontWeight: _selected == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// Grid

class LauncherGrid extends StatelessWidget {
  final PageController? controller;
  const LauncherGrid({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    /* final List<Application> _applications = applications;
    final List<Application> _internet = [];
    final List<Application> _media = [];
    final List<Application> _gaming = [];
    final List<Application> _development = [];
    final List<Application> _office = [];
    final List<Application> _system = [];
    for (final Application element in _applications) {
      switch (element.category) {
        case ApplicationCategory.internet:
          _internet.add(element);
          break;
        case ApplicationCategory.media:
          _media.add(element);
          break;
        case ApplicationCategory.gaming:
          _gaming.add(element);
          break;
        case ApplicationCategory.development:
          _development.add(element);
          break;
        case ApplicationCategory.office:
          _office.add(element);
          break;
        case ApplicationCategory.system:
          _system.add(element);
          break;
        default:
          break;
      }
    }

    final List<List<Application>> pages = [
      _applications,
      _internet,
      _media,
      _gaming,
      _development,
      _office,
      _system
    ]; */

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: AnimatedBuilder(
          animation: ApplicationService.current,
          builder: (context, child) {
            return PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              itemCount: 1,
              itemBuilder: (context, int pvindex) {
                final List<DesktopEntry> applications =
                    ApplicationService.current.listApplications();

                applications.sort(
                  (a, b) => a
                      .getLocalizedName(context.locale)
                      .toLowerCase()
                      .compareTo(
                        b.getLocalizedName(context.locale).toLowerCase(),
                      ),
                );

                //final List<Application> page = pages[pvindex];
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: applications.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    // Flutter automatically calculates the optimal number of horizontal
                    // items with a MaxCrossAxisExtent in the app launcher grid
                    maxCrossAxisExtent: 175,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppLauncherButton(
                        application: applications[index],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Power Menu

class LauncherActionMenu extends StatefulWidget {
  const LauncherActionMenu({super.key});

  @override
  _LauncherActionMenuState createState() => _LauncherActionMenuState();
}

class _LauncherActionMenuState extends State<LauncherActionMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        width: 28 * 3 + 16 * 4,
        height: 32 + 16,
        child: BoxContainer(
          shape: Constants.mediumShape,
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _launcherActionWidget(
                  "Power Menu",
                  Icons.power_settings_new_rounded,
                  context,
                  () => ActionManager.showPowerMenu(context),
                ),
                _launcherActionWidget(
                  "Account Menu",
                  Icons.person,
                  context,
                  () => ActionManager.showAccountMenu(context),
                ),
                _launcherActionWidget(
                  "Settings",
                  Icons.settings_outlined,
                  context,
                  //close launcher as well
                  () => ActionManager.openSettings(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _launcherActionWidget(
    String title,
    IconData icon,
    BuildContext context,
    VoidCallback? onPressed,
  ) {
    return Expanded(
      child: SizedBox(
        height: 32 + 16,
        child: Tooltip(
          message: title,
          verticalOffset: -64,
          child: InkWell(
            customBorder: Constants.mediumShape,
            onTap: onPressed,
            mouseCursor: SystemMouseCursors.click,
            child: Icon(
              icon,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
