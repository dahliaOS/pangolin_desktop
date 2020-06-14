/*
Copyright 2019 The dahliaOS Authors

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
