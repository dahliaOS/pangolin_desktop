import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/shell.dart';

class WelcomeOverlay extends ShellOverlay {
  WelcomeOverlay({super.key}) : super(id: "welcome");

  @override
  ShellOverlayState<WelcomeOverlay> createState() => _WelcomeOverlayState();
}

class _WelcomeOverlayState extends ShellOverlayState<WelcomeOverlay> {
  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) {
    animationController.value = 1;
    controller.showing = true;
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) async {
    await animationController.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (shouldHide) return const SizedBox();

    return FadeTransition(
      opacity: animation,
      child: const Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black38,
            ),
          ),
          Center(child: _WelcomeScreen()),
        ],
      ),
    );
  }
}

class _WelcomeScreen extends StatefulWidget {
  const _WelcomeScreen();

  @override
  State<_WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<_WelcomeScreen>
    with StateServiceListener<CustomizationService, _WelcomeScreen> {
  bool showAtStartup = true;

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final bool darkMode = service.darkMode;

    return SizedBox(
      width: 640,
      height: 480,
      child: Material(
        color: darkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: Constants.mediumShape,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                darkMode
                    ? 'assets/images/other/developer-dark.png'
                    : 'assets/images/other/developer-white.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                height: 256,
                width: 256,
              ),
            ),
            Positioned(
              top: 40,
              left: 40,
              child: Image.asset(
                darkMode
                    ? 'assets/images/logos/dahliaOS-white.png'
                    : 'assets/images/logos/dahliaOS-modern.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                height: 32,
              ),
            ),
            const Positioned(
              top: 132,
              left: 40,
              width: 368,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w100,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Text(
                    "\nFor now, dahliaOS is pre-release software. Some features are incomplete, applications may not work as expected, and the experience may not be stable on certain devices. \n\nWe are always looking to improve our software, so feel free to share feedback with us on any of our social media. Have fun!",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: showAtStartup,
                    onChanged: (val) {
                      setState(() {
                        showAtStartup = !showAtStartup;
                      });
                    },
                  ),
                  const Text("Show at every startup"),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: ElevatedButton(
                onPressed: () {
                  service.showWelcomeScreen = showAtStartup;

                  ShellService.current.dismissOverlay("welcome");
                },
                child: Padding(
                  padding: ThemeConstants.buttonPadding,
                  child: const Text("LET'S GO!"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
