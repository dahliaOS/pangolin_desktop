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

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/search/widgets/searchbar.dart';
import 'package:pangolin/components/settings/pages/about.dart';
import 'package:pangolin/components/settings/pages/applications.dart';
import 'package:pangolin/components/settings/pages/connections/connected_devices.dart';
import 'package:pangolin/components/settings/pages/customization/customization.dart';
import 'package:pangolin/components/settings/pages/developer_options.dart';
import 'package:pangolin/components/settings/pages/display.dart';
import 'package:pangolin/components/settings/pages/locale.dart';
import 'package:pangolin/components/settings/pages/network/network.dart';
import 'package:pangolin/components/settings/pages/notifications.dart';
import 'package:pangolin/components/settings/pages/sound.dart';
import 'package:pangolin/utils/theme/theme.dart';
import 'package:pangolin/utils/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => _SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: theme(context),
        home: const Scaffold(
          backgroundColor: Colors.transparent,
          body: _SettingsHome(),
        ),
      ),
    );
  }
}

class _SettingsHome extends StatefulWidget {
  const _SettingsHome({
    Key? key,
  }) : super(key: key);

  @override
  State<_SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<_SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<_SettingsProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isExpanded = constraints.maxWidth > 1024;

            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: isExpanded ? 340 : 90,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _settingsTiles.length,
                      itemBuilder: (context, index) {
                        //check if tile is a header
                        final bool isTile =
                            _settingsTiles[index].subtitle != null;
                        final bool isSearch =
                            _settingsTiles[index].title == "Search";
                        final bool isSelected = provider._pageIndex == index;

                        return !isTile && !isExpanded
                            ? const SizedBox(
                                height: 16,
                              )
                            : SizedBox(
                                height: !isTile ? 40 : 60,
                                child: Padding(
                                  padding: isTile
                                      ? const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                          horizontal: 8,
                                        )
                                      : const EdgeInsets.only(left: 8),
                                  child: isSearch
                                      ? _SettingsSearchBar(
                                          isExpanded: isExpanded,
                                        )
                                      : ListTile(
                                          dense: true,
                                          onTap: !isTile
                                              ? null
                                              : () {
                                                  setState(() {
                                                    provider.pageIndex = index;
                                                  });
                                                },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          tileColor: isTile
                                              ? isSelected
                                                  ? ThemeManager.of(context)
                                                      .accentColorAlt
                                                  : Colors.transparent
                                              : Colors.transparent,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: isTile ? 0.0 : 0,
                                            horizontal: 12,
                                          ),
                                          title: isExpanded
                                              ? Text(
                                                  _settingsTiles[index].title,
                                                  style: TextStyle(
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: isSelected
                                                        ? ThemeManager.of(
                                                                  context,
                                                                )
                                                                    .accentColorAlt
                                                                    .computeLuminance() <
                                                                0.4
                                                            ? Colors.white
                                                            : Colors.black
                                                        : null,
                                                  ),
                                                )
                                              : const Text(""),
                                          subtitle: isTile
                                              ? isExpanded
                                                  ? Text(
                                                      _settingsTiles[index]
                                                          .subtitle!,
                                                      style: TextStyle(
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                        color: isSelected
                                                            ? ThemeManager.of(
                                                                      context,
                                                                    )
                                                                        .accentColorAlt
                                                                        .computeLuminance() <
                                                                    0.4
                                                                ? Colors.white
                                                                : Colors.black
                                                            : null,
                                                      ),
                                                    )
                                                  : const Text("")
                                              : null,
                                          leading: !isTile
                                              ? null
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    left: isExpanded ? 0 : 4,
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ThemeManager.of(context)
                                                            .accentColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    _settingsTiles[index].icon,
                                                    color: ThemeManager.of(
                                                              context,
                                                            )
                                                                .accentColor
                                                                .computeLuminance() <
                                                            0.4
                                                        ? Colors.white
                                                        : Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                        ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    transitionBuilder:
                        (child, primaryAnimation, secondaryAnimation) {
                      return FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        fillColor: Colors.transparent,
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      key: ValueKey(provider.pageIndex),
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(8)),
                      child: Scaffold(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        body: _settingsTiles[provider.pageIndex].page ??
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SettingsSearchBar extends StatelessWidget {
  final bool isExpanded;

  const _SettingsSearchBar({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Searchbar(
            controller: TextEditingController(),
            hint: 'Search settings',
            leading: const Icon(Icons.search_rounded),
            trailing: const Icon(Icons.close_rounded),
          )
        : Container(
            height: 16,
            width: 16,
            color: Colors.red,
          );
  }
}

class _SettingsTileData {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? page;

  const _SettingsTileData({
    required this.title,
    this.subtitle,
    this.icon,
    this.page,
  });
}

List<_SettingsTileData> _settingsTiles = [
  //Search HEADER
  const _SettingsTileData(
    title: "Search",
  ),
  //Connectivity HEADER
  const _SettingsTileData(
    title: "Connectivity",
  ),
  //Connectivity TILES
  const _SettingsTileData(
    title: "Network & internet",
    subtitle: "Wi-Fi, ethernet, data usage",
    icon: Icons.wifi,
    page: SettingsPageNetwork(),
  ),
  const _SettingsTileData(
    title: "Connected devices",
    subtitle: "Bluetooth, printer, USB devices",
    icon: Icons.devices_rounded,
    page: SettingsPageConnectedDevices(),
  ),
  //Personalize HEADER
  const _SettingsTileData(
    title: "Personalize",
  ),
  //Personalize TILES
  const _SettingsTileData(
    title: "Customization",
    subtitle: "Personalize your experience",
    icon: Icons.color_lens_outlined,
    page: SettingsPageCustomization(),
  ),

  //Device & applications HEADER
  const _SettingsTileData(
    title: "Device & applications",
  ),
  //Device & applications TILES
  const _SettingsTileData(
    title: "Display",
    subtitle: "Resolution, screen timeout, scaling",
    icon: Icons.desktop_windows,
    page: SettingsPageDisplay(),
  ),
  const _SettingsTileData(
    title: "Sound",
    subtitle: "Volume, Do Not Disturb, startup sound",
    icon: Icons.volume_up_rounded,
    page: SettingsPageSound(),
  ),
  const _SettingsTileData(
    title: "Locale",
    subtitle: "Language, time and date, keyboard layout",
    icon: Icons.translate_rounded,
    page: SettingsPageLocale(),
  ),
  const _SettingsTileData(
    title: "Notifications",
    subtitle: "Notification sound, app selection",
    icon: Icons.notifications_none_rounded,
    page: SettingsPageNotifications(),
  ),
  const _SettingsTileData(
    title: "Applications",
    subtitle: "Installed apps, default apps",
    icon: Icons.apps_rounded,
    page: SettingsPageApplications(),
  ),
  //System HEADER
  const _SettingsTileData(
    title: "System",
  ),
  const _SettingsTileData(
    title: "Developer options",
    subtitle: "Feature flags, advanced options",
    icon: Icons.developer_mode_rounded,
    page: SettingsPageDeveloperOptions(),
  ),
  //System TILES
  const _SettingsTileData(
    title: "About device",
    subtitle: "System version, device information",
    icon: Icons.laptop_mac_rounded,
    page: SettingsPageAbout(),
  ),
];

class _SettingsProvider extends ChangeNotifier {
  int? _pageIndex = 2;
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;
  int get pageIndex => _pageIndex!;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
