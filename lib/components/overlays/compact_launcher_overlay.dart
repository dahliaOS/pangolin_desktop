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

import 'package:pangolin/components/overlays/quick_settings/pages/qs_account_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_network_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_theme_page.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pangolin/widgets/box/box_container.dart';
import 'package:pangolin/widgets/quick_button.dart';

class CompactLauncherOverlay extends ShellOverlay {
  static const String overlayId = 'compactlauncher';

  CompactLauncherOverlay({Key? key}) : super(key: key, id: overlayId);

  @override
  _CompactLauncherOverlayState createState() => _CompactLauncherOverlayState();
}

class _CompactLauncherOverlayState extends State<CompactLauncherOverlay>
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
      left: _customizationProvider.isTaskbarRight
          ? 48 + 8
          : _customizationProvider.isTaskbarLeft
              ? null
              : 8,
      right: _customizationProvider.isTaskbarLeft ? 48 + 8 : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, chilld) => FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            alignment: FractionalOffset(
                0.025, !_customizationProvider.isTaskbarTop ? 1.0 : 0.0),
            child: BoxSurface(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.big),
              height: 540,
              width: 474,
              dropShadow: true,
              child: Padding(
                //yeah this used to be 16, just a lil reminder
                padding: const EdgeInsets.all(0.0),
                child: MaterialApp(
                  home: const CompactLauncher(),
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

class CompactLauncher extends StatelessWidget {
  const CompactLauncher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.backgroundColor.op(0.25),
            ),
            child: Column(
              children: [
                const QuickActionButton(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  leading: FlutterLogo(),
                ),
                const Spacer(),
                const QuickActionButton(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: Icon(Icons.edit_rounded),
                ),
                QuickActionButton(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: const Icon(Icons.settings_outlined),
                  onPressed: () => ActionManager.openSettings(context),
                ),
                const QuickActionButton(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: Icon(Icons.exit_to_app_rounded),
                ),
                QuickActionButton(
                  margin: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                  leading: const Icon(Icons.power_settings_new_rounded),
                  onPressed: () => ActionManager.showPowerMenu(context),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 402,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username),
                          const SizedBox(height: 2.0),
                          const Text(
                            "Local Account",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const QuickActionButton(
                      margin: EdgeInsets.all(16.0),
                      isCircular: true,
                      leading: Icon(Icons.open_in_full_rounded),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
