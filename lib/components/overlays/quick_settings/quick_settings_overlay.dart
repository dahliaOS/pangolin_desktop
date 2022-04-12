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

import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_account_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_language_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_network_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_theme_page.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_shortcut_button.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_slider.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_toggle_button.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/other/date_time_manager.dart';
import 'package:pangolin/utils/providers/connection_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/io_provider.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/quick_button.dart';

class QuickSettingsOverlay extends ShellOverlay {
  static const String overlayId = 'quicksettings';

  QuickSettingsOverlay({Key? key}) : super(key: key, id: overlayId);

  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

class _QuickSettingsOverlayState extends State<QuickSettingsOverlay>
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

  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    // _getTime(context);
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );

    if (!controller.showing) return const SizedBox();

    return Positioned(
      bottom: _customizationProvider.isTaskbarRight ||
              _customizationProvider.isTaskbarLeft
          ? 8
          : !_customizationProvider.isTaskbarTop
              ? 48 + 8
              : null,
      top: _customizationProvider.isTaskbarTop ? 48 + 8 : null,
      right: _customizationProvider.isTaskbarRight
          ? 48 + 8
          : _customizationProvider.isTaskbarLeft
              ? null
              : 8,
      left: _customizationProvider.isTaskbarLeft ? 48 + 8 : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, chilld) => FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            alignment: FractionalOffset(
              0.8,
              !_customizationProvider.isTaskbarTop ? 1.0 : 0.0,
            ),
            child: BoxSurface(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.big),
              width: 540,
              height: 474,
              dropShadow: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialApp(
                  routes: {
                    "/": (context) => const QsMain(),
                    "/pages/account": (context) => const QsAccountPage(),
                    "/pages/network": (context) => const QsNetworkPage(),
                    "/pages/theme": (context) => const QsThemePage(),
                    "/pages/language": (context) => const QsLanguagePage(),
                  },
                  theme: Theme.of(context)
                      .copyWith(scaffoldBackgroundColor: Colors.transparent),
                  debugShowCheckedModeBanner: false,
                  locale: context.locale,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QsMain extends StatelessWidget {
  const QsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Action Button Bar
    final List<Widget> _qsActionButton = [
      QuickActionButton(
        leading: const FlutterLogo(
          size: 18,
        ),
        title: username,
        onPressed: () => Navigator.pushNamed(context, "/pages/account"),
        margin: EdgeInsets.zero,
        isCircular: false,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.1,
          color: context.theme.surfaceForegroundColor,
        ),
      ),
      const Spacer(),
      QuickActionButton(
        leading: Icon(IconsX.of(context).settings),
        //title: "Settings",
        onPressed: () => ActionManager.openSettings(context),
      ),
      QuickActionButton(
        leading: Icon(IconsX.of(context).edit),
        //title: "Edit panel",
      ),
      QuickActionButton(
        leading: Icon(IconsX.of(context).sign_out),
        onPressed: () => ActionManager.showAccountMenu(context),
        //title: "Sign out",
      ),
      QuickActionButton(
        leading: Icon(IconsX.of(context).power),
        margin: const EdgeInsets.only(left: 8),
        onPressed: () => ActionManager.showPowerMenu(context),
        //title: "Power",
      ),
    ];
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _qsActionButton,
            ),
            _qsTitle(LSX.quicksettingsOverlay.quickControls),
            Builder(
              builder: (context) {
                final _connectionProvider = ConnectionProvider.of(context);
                final _customizationProvider =
                    CustomizationProvider.of(context);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QsToggleButton(
                          //TODO change title to "Network"
                          title: LSX
                              .quicksettingsOverlay.quickControlsNetworkTitle,
                          icon: _connectionProvider.wifi
                              ? Icons.wifi_rounded
                              : Icons.wifi_off_rounded,
                          //TODO Capitalise
                          subtitle: LSX.quicksettingsOverlay
                              .quickControlsNetworkSubtitleConnected,
                          value: _connectionProvider.wifi,
                          onPressed: () => _connectionProvider.wifi =
                              !_connectionProvider.wifi,
                          onMenuPressed: () {
                            Navigator.pushNamed(context, "/pages/network");
                          },
                        ),
                        QsToggleButton(
                          title: LSX
                              .quicksettingsOverlay.quickControlsBluetoothTitle,
                          subtitle: _connectionProvider.bluetooth
                              ? LSX.global.on
                              : LSX.global.off,
                          icon: _connectionProvider.bluetooth
                              ? Icons.bluetooth_connected_rounded
                              : Icons.bluetooth_disabled_rounded,
                          value: _connectionProvider.bluetooth,
                          onPressed: () => _connectionProvider.bluetooth =
                              !_connectionProvider.bluetooth,
                        ),
                        QsToggleButton(
                          title: LSX.quicksettingsOverlay
                              .quickControlsAirplaneModeTitle,
                          icon: !(!_connectionProvider.wifi &&
                                  !_connectionProvider.bluetooth)
                              ? Icons.airplanemode_off_rounded
                              : Icons.airplanemode_active_rounded,
                          value: !(!_connectionProvider.wifi &&
                                  !_connectionProvider.bluetooth)
                              ? false
                              : true,
                          onPressed: () {
                            if (_connectionProvider.wifi &&
                                _connectionProvider.bluetooth) {
                              _connectionProvider.wifi = false;
                              _connectionProvider.bluetooth = false;
                            } else if (_connectionProvider.wifi &&
                                !_connectionProvider.bluetooth) {
                              _connectionProvider.wifi = false;
                              _connectionProvider.bluetooth = false;
                            } else if (!_connectionProvider.wifi &&
                                _connectionProvider.bluetooth) {
                              _connectionProvider.wifi = false;
                              _connectionProvider.bluetooth = false;
                            } else {
                              _connectionProvider.wifi = true;
                              _connectionProvider.bluetooth = true;
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QsToggleButton(
                          title: LSX
                              .quicksettingsOverlay.quickControlsLanguageTitle,
                          //TODO Fix this
                          subtitle: context.locale.toLanguageTag(),
                          icon: Icons.language_rounded,
                          value: true,
                          onPressed: () {
                            final int index =
                                Locales.supported.indexOf(context.locale);
                            if (index + 1 < Locales.supported.length) {
                              context.setLocale(Locales.supported[index + 1]);
                            } else {
                              context.setLocale(Locales.supported[0]);
                            }
                          },
                          onMenuPressed: () {
                            Navigator.pushNamed(context, "/pages/language");
                          },
                        ),
                        //TODO remove the provider option for this
                        /* 
                      QsToggleButton(
                        title: LSX.qs.autorotate,
                        icon: Icons.screen_lock_rotation_rounded,
                        value: false,
                      ), */
                        QsToggleButton(
                          title:
                              LSX.quicksettingsOverlay.quickControlsThemeTitle,
                          icon: Icons.palette_outlined,
                          value: true,
                          onPressed: () => _customizationProvider.darkMode =
                              !_customizationProvider.darkMode,
                          onMenuPressed: () =>
                              Navigator.pushNamed(context, "/pages/theme"),
                        ),
                        QsToggleButton(
                          title: LSX.quicksettingsOverlay
                              .quickControlsDonotdisturbTitle,
                          icon: Icons.do_not_disturb_off_rounded,
                          onPressed: () {},
                        ),
                        //TODO move night light to the brightness control submenu
                        /* 
                      QsToggleButton(
                        title: "Night light",
                        icon: Icons.brightness_4_rounded,
                        value: false,
                      ), */
                      ],
                    ),
                  ],
                );
              },
            ),
            _qsTitle(LSX.quicksettingsOverlay.shortcutsTitle),
            Row(
              children: [
                QsShortcutButton(
                  title: LSX.quicksettingsOverlay.shortcutsNewEvent,
                  icon: Icons.calendar_today_rounded,
                ),
                QsShortcutButton(
                  title: LSX.quicksettingsOverlay.shortcutsAlphaBuild,
                  icon: Icons.info_outline_rounded,
                ),
                const QsShortcutButton(
                  title: "dahliaos.io",
                  icon: Icons.language_rounded,
                ),
                const QsShortcutButton(),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Builder(
              builder: (context) {
                final _ioProvider = IOProvider.of(context);
                return Column(
                  children: [
                    QsSlider(
                      icon: _ioProvider.isMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      onChanged: (val) {
                        _ioProvider.volume = val;
                      },
                      value: _ioProvider.volume,
                      steps: 20,
                      onIconTap: () =>
                          _ioProvider.isMuted = !_ioProvider.isMuted,
                    ),
                    QsSlider(
                      icon: _ioProvider.isAutoBrightnessEnabled
                          ? Icons.brightness_auto_rounded
                          : Icons.brightness_5_rounded,
                      onChanged: (val) {
                        _ioProvider.brightness = val;
                      },
                      value: _ioProvider.brightness,
                      steps: 10,
                      onIconTap: () => _ioProvider.isAutoBrightnessEnabled =
                          !_ioProvider.isAutoBrightnessEnabled,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: DateTimeManager.getDateNotifier()!,
                  builder: (BuildContext context, String date, child) =>
                      ValueListenableBuilder(
                    valueListenable: DateTimeManager.getTimeNotifier()!,
                    builder: (BuildContext context, String time, child) =>
                        QuickActionButton(
                      isCircular: false,
                      leading: const Icon(Icons.calendar_today),
                      title: "$date - $time",
                      margin: EdgeInsets.zero,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return FutureBuilder(
                      future: Battery().batteryLevel,
                      builder: (context, AsyncSnapshot<int?> data) {
                        final String batteryPercentage =
                            data.data?.toString() ??
                                LSX.quicksettingsOverlay.shortcutsEnergyMode;
                        return QuickActionButton(
                          leading: const Icon(Icons.battery_charging_full),
                          title: batteryPercentage,
                          margin: EdgeInsets.zero,
                          isCircular: false,
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding _qsTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 12.0, 0.0, 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
