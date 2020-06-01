import 'key_ring.dart';
import 'package:flutter/widgets.dart';
import '../widgets/system_overlay.dart';

/// Hides all overlays except [except] if applicable.
void hideOverlays({GlobalKey<SystemOverlayState> except}) {
  <GlobalKey<SystemOverlayState>>[
    KeyRing.launcherOverlayKey,
    KeyRing.statusOverlayKey,
  ].where((GlobalKey<SystemOverlayState> overlay) => overlay != except).forEach(
      (GlobalKey<SystemOverlayState> overlay) =>
          overlay.currentState.visible = false);
}

/// Sets the given [overlay]'s visibility to [visible].
/// When showing an overlay, this also hides every other overlay.
void setOverlayVisibility({
  @required GlobalKey<SystemOverlayState> overlay,
  @required bool visible,
}) {
  if (visible) {
    hideOverlays(except: overlay);
  }
  overlay.currentState.visible = visible;
}

void toggleCallback(bool toggled) => setOverlayVisibility(
      overlay: KeyRing.launcherOverlayKey,
      visible: toggled,
    );
