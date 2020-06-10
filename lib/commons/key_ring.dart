import 'package:flutter/material.dart';
import '../widgets/toggle.dart';
import '../widgets/system_overlay.dart';

class KeyRing {
  static final GlobalKey<ToggleState> launcherToggleKey =
      GlobalKey<ToggleState>();
  static final GlobalKey<SystemOverlayState> launcherOverlayKey =
      GlobalKey<SystemOverlayState>();
  static final GlobalKey<ToggleState> statusToggleKey =
      GlobalKey<ToggleState>();
  static final GlobalKey<SystemOverlayState> statusOverlayKey =
      GlobalKey<SystemOverlayState>();
}
