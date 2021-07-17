import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pangolin/settings/pages/about.dart';
import 'package:pangolin/settings/pages/applications.dart';
import 'package:pangolin/settings/pages/connected_devices.dart';
import 'package:pangolin/settings/pages/customization.dart';
import 'package:pangolin/settings/pages/developer_options.dart';
import 'package:pangolin/settings/pages/display.dart';
import 'package:pangolin/settings/pages/locale.dart';
import 'package:pangolin/settings/pages/network.dart';
import 'package:pangolin/settings/pages/notifications.dart';
import 'package:pangolin/settings/pages/sound.dart';
import 'package:pangolin/utils/theme.dart';
import 'package:pangolin/utils/theme_manager.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _SettingsProvider(),
      child: MaterialApp(
        theme: theme(context),
        home: Scaffold(
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
      builder: (context, provider, _) => LayoutBuilder(
        builder: (context, constraints) {
          bool isExpanded = constraints.maxWidth > 768;
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: isExpanded ? 340 : 90,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: _settingsTiles.length,
                    itemBuilder: (context, index) {
                      //check if tile is a header
                      bool isTile = _settingsTiles[index].subtitle != null;
                      bool isSearch = _settingsTiles[index].title == "Search";
                      bool isSelected = provider._pageIndex == index;

                      return !isTile && !isExpanded
                          ? SizedBox(
                              height: 16,
                            )
                          : SizedBox(
                              height: !isTile ? 40 : 60,
                              child: Padding(
                                padding: isTile
                                    ? EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 8)
                                    : EdgeInsets.only(left: 8),
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
                                                BorderRadius.circular(8)),
                                        tileColor: isTile
                                            ? isSelected
                                                ? ThemeManager.of(context)
                                                    .accentColorAlt
                                                : Colors.transparent
                                            : Colors.transparent,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: isTile ? 0.0 : 0,
                                            horizontal: 12),
                                        title: isExpanded
                                            ? Text(
                                                _settingsTiles[index].title,
                                                style: TextStyle(
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              )
                                            : null,
                                        subtitle: isTile
                                            ? isExpanded
                                                ? Text(
                                                    _settingsTiles[index]
                                                        .subtitle!,
                                                    style: TextStyle(
                                                      fontWeight: isSelected
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  )
                                                : null
                                            : null,
                                        leading: !isTile
                                            ? null
                                            : Container(
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
                                                                  context)
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
                        BorderRadius.only(topLeft: Radius.circular(8)),
                    child: Scaffold(
                      backgroundColor: Color(0xff151515),
                      body: _settingsTiles[provider.pageIndex].page ??
                          SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SettingsSearchBar extends StatelessWidget {
  final bool isExpanded;
  const _SettingsSearchBar({Key? key, required this.isExpanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Searchbar(
            controller: TextEditingController(),
            hint: 'Search settings',
            leading: Icon(Icons.search_rounded),
            trailing: Icon(Icons.close_rounded),
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
  const _SettingsTileData(
      {required this.title, this.subtitle, this.icon, this.page});
}

List<_SettingsTileData> _settingsTiles = [
  //Search HEADER
  _SettingsTileData(
    title: "Search",
  ),
  //Connectivity HEADER
  _SettingsTileData(
    title: "Connectivity",
  ),
  //Connectivity TILES
  _SettingsTileData(
    title: "Network & internet",
    subtitle: "Wi-Fi, ethernet, data usage",
    icon: Icons.wifi,
    page: SettingsPageNetwork(),
  ),
  _SettingsTileData(
    title: "Connected devices",
    subtitle: "Bluetooth, printer, USB devices",
    icon: Icons.devices_rounded,
    page: SettingsPageConnectedDevices(),
  ),
  //Personalize HEADER
  _SettingsTileData(
    title: "Personalize",
  ),
  //Personalize TILES
  _SettingsTileData(
    title: "Customization",
    subtitle: "Personalize your experience",
    icon: Icons.color_lens_outlined,
    page: SettingsPageCustomization(),
  ),
  _SettingsTileData(
    title: "Developer options",
    subtitle: "Feature flags, advanced options",
    icon: Icons.developer_mode_rounded,
    page: SettingsPageDeveloperOptions(),
  ),
  //Device & applications HEADER
  _SettingsTileData(
    title: "Device & applications",
  ),
  //Device & applications TILES
  _SettingsTileData(
    title: "Display",
    subtitle: "Resolution, screen timeout, scaling",
    icon: Icons.desktop_windows,
    page: SettingsPageDisplay(),
  ),
  _SettingsTileData(
    title: "Sound",
    subtitle: "Volume, Do Not Disturb, startup sound",
    icon: Icons.volume_up_rounded,
    page: SettingsPageSound(),
  ),
  _SettingsTileData(
    title: "Locale",
    subtitle: "Language, time and date, keyboard layout",
    icon: Icons.translate_rounded,
    page: SettingsPageLocale(),
  ),
  _SettingsTileData(
    title: "Notifications",
    subtitle: "Notification sound, app selection",
    icon: Icons.notifications_none_rounded,
    page: SettingsPageNotifications(),
  ),
  _SettingsTileData(
    title: "Applications",
    subtitle: "Installed apps, default apps",
    icon: Icons.apps_rounded,
    page: SettingsPageApplications(),
  ),
  //System HEADER
  _SettingsTileData(
    title: "System",
  ),
  //System TILES
  _SettingsTileData(
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
