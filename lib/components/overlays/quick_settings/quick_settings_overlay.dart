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
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_account_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_language_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_network_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_theme_page.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_shortcut_button.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_slider.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_toggle_button.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/quick_button.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class QuickSettingsOverlay extends ShellOverlay {
  static const String overlayId = 'quicksettings';

  QuickSettingsOverlay({super.key}) : super(id: overlayId);

  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

class _QuickSettingsOverlayState extends State<QuickSettingsOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late final AnimationController ac = AnimationController(
    vsync: this,
    duration: Constants.animationDuration,
  );

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
    // _getTime(context);
    final Animation<double> animation = CurvedAnimation(
      parent: ac,
      curve: Constants.animationCurve,
    );

    if (!controller.showing) return const SizedBox();

    return Positioned(
      bottom: 56, // Bottom insets + some padding (8)
      right: 8,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, chilld) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: const FractionalOffset(0.8, 1.0),
            child: BoxSurface(
              shape: Constants.bigShape,
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

class QsMain extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  const QsMain({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    // Action Button Bar
    final List<Widget> qsActionButton = [
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
        leading: const Icon(Icons.settings),
        //title: "Settings",
        onPressed: () => ActionManager.openSettings(context),
      ),
      const QuickActionButton(
        leading: Icon(Icons.edit),
        //title: "Edit panel",
      ),
      QuickActionButton(
        leading: const Icon(Icons.logout),
        onPressed: () => ActionManager.showAccountMenu(context),
        //title: "Sign out",
      ),
      QuickActionButton(
        leading: const Icon(Icons.power_settings_new),
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
              children: qsActionButton,
            ),
            _qsTitle(strings.quicksettingsOverlay.quickControls),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QsToggleButton(
                      //TODO change title to "Network"
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsNetworkTitle,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.wifi_off_rounded,
                        active: Icons.wifi_rounded,
                      ),
                      //TODO Capitalise
                      subtitle: ToggleProperty(
                        base: null,
                        active: strings.quicksettingsOverlay
                            .quickControlsNetworkSubtitleConnected,
                      ),
                      enabled:
                          service.enableWifi && !service.enableAirplaneMode,
                      onPressed: (value) => service.enableWifi = value,
                      onMenuPressed: () {
                        Navigator.pushNamed(context, "/pages/network");
                      },
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings
                            .quicksettingsOverlay.quickControlsBluetoothTitle,
                      ),
                      subtitle: ToggleProperty(
                        base: strings.global.off,
                        active: strings.global.on,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.bluetooth_disabled_rounded,
                        active: Icons.bluetooth_connected_rounded,
                      ),
                      enabled: service.enableBluetooth &&
                          !service.enableAirplaneMode,
                      onPressed: (value) => service.enableBluetooth = value,
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay
                            .quickControlsAirplaneModeTitle,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.airplanemode_off_rounded,
                        active: Icons.airplanemode_active_rounded,
                      ),
                      enabled: service.enableAirplaneMode,
                      onPressed: (value) => service.enableAirplaneMode = value,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsLanguageTitle,
                      ),
                      //TODO Fix this
                      subtitle: ToggleProperty.singleState(
                        context.locale.toLanguageTag(),
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.language_rounded,
                      ),
                      enabled: true,
                      onPressed: (_) {
                        final int index =
                            context.supportedLocales.indexOf(context.locale);
                        if (index + 1 < locales.supportedLocales.length) {
                          context.locale = context.supportedLocales[index + 1];
                        } else {
                          context.locale = context.supportedLocales[0];
                        }
                      },
                      onMenuPressed: () {
                        Navigator.pushNamed(context, "/pages/language");
                      },
                    ),
                    //TODO remove the provider option for this
                    /* 
                      QsToggleButton(
                        title: strings.qs.autorotate,
                        icon: Icons.screen_lock_rotation_rounded,
                        value: false,
                      ), */
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsThemeTitle,
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.palette_outlined,
                      ),
                      enabled: true,
                      onPressed: (_) => service.darkMode = !service.darkMode,
                      onMenuPressed: () =>
                          Navigator.pushNamed(context, "/pages/theme"),
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay
                            .quickControlsDonotdisturbTitle,
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.do_not_disturb_off_rounded,
                      ),
                      onPressed: (_) {},
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
            ),
            _qsTitle(strings.quicksettingsOverlay.shortcutsTitle),
            Row(
              children: [
                QsShortcutButton(
                  title: strings.quicksettingsOverlay.shortcutsNewEvent,
                  icon: Icons.calendar_today_rounded,
                ),
                QsShortcutButton(
                  title: strings.quicksettingsOverlay.shortcutsAlphaBuild,
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
            Column(
              children: [
                QsSlider(
                  icon: service.muteVolume
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded,
                  onChanged: (val) {
                    service.volume = val;
                    service.muteVolume = val == 0;
                  },
                  value: !service.muteVolume ? service.volume : 0,
                  steps: 20,
                  onIconTap: () => service.muteVolume = !service.muteVolume,
                ),
                QsSlider(
                  icon: service.autoBrightness
                      ? Icons.brightness_auto_rounded
                      : Icons.brightness_5_rounded,
                  onChanged: (val) => service.brightness = val,
                  value: service.brightness,
                  steps: 10,
                  onIconTap: () =>
                      service.autoBrightness = !service.autoBrightness,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListenableServiceBuilder<DateTimeService>(
                  builder: (BuildContext context, _) {
                    final String date = DateTimeService.current.formattedDate;
                    final String time = DateTimeService.current.formattedTime;

                    return QuickActionButton(
                      isCircular: false,
                      leading: const Icon(Icons.calendar_today),
                      title: "$date - $time",
                      margin: EdgeInsets.zero,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    return FutureBuilder(
                      future: Battery().batteryLevel,
                      builder: (context, AsyncSnapshot<int?> data) {
                        final String batteryPercentage = data.data
                                ?.toString() ??
                            strings.quicksettingsOverlay.shortcutsEnergyMode;
                        return QuickActionButton(
                          leading: const Icon(Icons.battery_charging_full),
                          title: data.data != null
                              ? "$batteryPercentage%"
                              : batteryPercentage,
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
