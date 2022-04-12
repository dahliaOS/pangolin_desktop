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

import 'package:pangolin/components/overlays/launcher/widgets/app_launcher_button.dart';
import 'package:pangolin/components/overlays/search/search_overlay.dart';
import 'package:pangolin/components/overlays/search/widgets/searchbar.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/search_provider.dart';
import 'package:pangolin/utils/wm/wm_api.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/quick_button.dart';

class LauncherOverlay extends ShellOverlay {
  static const String overlayId = 'launcher';

  LauncherOverlay({Key? key}) : super(key: key, id: overlayId);

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
    WmAPI.of(context).minimizeAll();
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    WmAPI.of(context).undoMinimizeAll();
    controller.showing = false;
  }

  final _focusNode = FocusNode();
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

    if (!controller.showing) return const SizedBox();

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
            _shell.dismissOverlay(LauncherOverlay.overlayId);
          }
        },
        onTap: () async {
          await ac.reverse();
          _shell.dismissOverlay(LauncherOverlay.overlayId);
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                  scale: _animation,
                  alignment: _customizationProvider.taskbarPosition != 0
                      ? FractionalOffset.bottomCenter
                      : FractionalOffset.topCenter,
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
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final _shell = Shell.of(context);
    final FocusNode _focusNode = FocusNode();
    _focusNode.requestFocus();

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (_) async {
        final _searchProvider = SearchProvider.of(context, listen: false);
        if (_.character != null) {
          _searchProvider.searchQueryCache = _.character!;
        }
        _shell.dismissOverlay(LauncherOverlay.overlayId);
        await Future.delayed(const Duration(milliseconds: 150));
        _shell.showOverlay(
          SearchOverlay.overlayId,
          args: {"searchQuery": _searchProvider.searchQueryCache},
          dismissEverything: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Searchbar(
          onTextChanged: (change) {
            _shell.dismissOverlay(LauncherOverlay.overlayId);
            _shell.showOverlay(
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

  const LauncherCategories({this.controller, Key? key}) : super(key: key);

  @override
  _LauncherCategoriesState createState() => _LauncherCategoriesState();
}

class _LauncherCategoriesState extends State<LauncherCategories> {
  GlobalKey key = GlobalKey();
  var _selected = 0;
  Size? s;

  @override
  Widget build(BuildContext context) {
    final List<String> launcherCategories = [
      LocaleStrings.launcherOverlay.categoriesAllApplications,
      LocaleStrings.launcherOverlay.categoriesInternet,
      LocaleStrings.launcherOverlay.categoriesMedia,
      LocaleStrings.launcherOverlay.categoriesGaming,
      LocaleStrings.launcherOverlay.categoriesDevelopment,
      LocaleStrings.launcherOverlay.categoriesOffice,
      LocaleStrings.launcherOverlay.categoriesSystem
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.0,
          child: Container(
            margin: const EdgeInsets.only(top: 33 + (1 / 3), bottom: 8),
            child: BoxContainer(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.round),
              // have to give explicit size, as the child ListView can't calculate its Y height
              height: 42,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: launcherCategories.length,
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: CommonData.of(context)
                        .borderRadius(BorderRadiusType.round),
                    color: _selected == index
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    child: InkWell(
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.round),
                      onTap: () {
                        setState(() {
                          _selected = index;
                        });
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
                                  : CommonData.of(context).textColor(),
                            ),
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
  const LauncherGrid({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final _applications = applications;
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
    ];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: pages.length,
          itemBuilder: (context, int pvindex) {
            final List<Application> page = pages[pvindex];
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: pages[pvindex].length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                // Flutter automatically calculates the optimal number of horizontal
                // items with a MaxCrossAxisExtent in the app launcher grid
                maxCrossAxisExtent: 175,
              ),
              itemBuilder: (BuildContext context, int index) {
                final Application application = getApp(page[index].packageName);
                if (!application.canBeOpened) {
                  return IgnorePointer(
                    child: Opacity(
                      opacity: 0.4,
                      child: AppLauncherButton(application),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppLauncherButton(application),
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
  const LauncherActionMenu({Key? key}) : super(key: key);

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
          borderRadius:
              CommonData.of(context).borderRadius(BorderRadiusType.medium),
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
            borderRadius:
                CommonData.of(context).borderRadius(BorderRadiusType.medium),
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
