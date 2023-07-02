import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/tray_overlay.dart';
import 'package:pangolin/components/taskbar/taskbar_element.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/services/tray.dart';

class TrayMenuButton extends StatelessWidget
    with StatelessServiceListener<TrayService> {
  const TrayMenuButton({super.key});

  @override
  Widget buildChild(BuildContext context, TrayService service) {
    return TaskbarElement(
      overlayID: TrayMenuOverlay.overlayId,
      shrinkWrap: true,
      height: 40.0,
      child: ValueListenableBuilder<bool>(
        valueListenable:
            ShellService.current.getShowingNotifier(TrayMenuOverlay.overlayId),
        builder: (context, showing, _) {
          return Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: service.items.isNotEmpty ? 12.0 : 8.0,
            ),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: showing ? 0.5 : 0,
                  duration: Constants.animationDuration,
                  curve: Constants.animationCurve,
                  child: const Icon(Icons.expand_less),
                ),
                if (service.items.isNotEmpty) const SizedBox(width: 4),
                if (service.items.isNotEmpty)
                  Text(service.items.length.toString()),
              ],
            ),
          );
        },
      ),
      buildShowArgs: () {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return {};

        final offset = box.localToGlobal(box.size.topCenter(Offset.zero));
        return {"origin": offset};
      },
    );
  }
}
