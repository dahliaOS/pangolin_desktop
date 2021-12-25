import 'package:pangolin/components/overlays/power_overlay.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/wm_api.dart';

class ActionManager {
  static void showPowerMenu(BuildContext context) {
    final shell = Shell.of(context, listen: false);
    shell.dismissEverything();
    shell.showOverlay(PowerOverlay.overlayId);
  }

  static void openSettings(BuildContext context) {
    final shell = Shell.of(context, listen: false);
    shell.dismissEverything();
    WmAPI.of(context).openApp("io.dahlia.settings");
  }
}
