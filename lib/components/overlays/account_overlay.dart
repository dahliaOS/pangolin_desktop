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

import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class AccountOverlay extends ShellOverlay {
  static const String overlayId = "account";

  AccountOverlay({Key? key}) : super(key: key, id: overlayId);

  @override
  _AccountOverlayState createState() => _AccountOverlayState();
}

class _AccountOverlayState extends State<AccountOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: CommonData.of(context).animationDuration(),
    );
    ac.forward();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) async {
    controller.showing = true;
    await ac.forward();
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.showing) return const SizedBox();

    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );

    return Stack(
      children: [
        //Wallpaper(),
        GestureDetector(
          onTap: () {
            controller.requestDismiss({});
          },
        ),
        Positioned(
          left: horizontalPadding(context, 330),
          right: horizontalPadding(context, 330),
          top: verticalPadding(context, 500),
          bottom: verticalPadding(context, 500),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                alignment: FractionalOffset.center,
                child: Material(
                  color: Colors.transparent,
                  child: BoxSurface(
                    dropShadow: true,
                    borderRadius: CommonData.of(context)
                        .borderRadius(BorderRadiusType.big),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Account Menu",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text("Choose what to do as user"),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 224,
                          color: context.theme.backgroundColor.op(0.35),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _accountMenuButton(
                                  "Sign out",
                                  Icons.logout_rounded,
                                  context,
                                  onPressed: () => ActionManager.logout(),
                                ),
                                _accountMenuButton(
                                  "Lock",
                                  Icons.lock_outline,
                                  context,
                                  onPressed: () => ActionManager.lock(),
                                ),
                                _accountMenuButton(
                                  "Account Settings",
                                  Icons.settings_outlined,
                                  context,
                                  onPressed: () =>
                                      ActionManager.openSettings(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _accountMenuButton(
    String title,
    IconData icon,
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: 280,
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: context.commonData.borderRadiusSmall,
          color: context.theme.accent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: context.theme.foregroundColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: context.theme.textTheme.button?.copyWith(
                      fontSize: 16,
                      color: context.theme.foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
