import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class OverviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            WmAPI.of(context).pushOverlayEntry(DismissibleOverlayEntry(
                uniqueId: "overview", content: OverviewOverlay()));
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child:
                Center(child: Icon(Icons.fullscreen_exit_outlined, size: 20)),
          ),
        ),
      ),
    );
  }
}

class OverviewOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 48,
      left: 0,
      right: 0,
      child: BoxContainer(
        useBlur: false,
        color: Colors.black.withOpacity(0.5),
        child: Stack(
          children: [
            Builder(builder: (context) {
              final _ac = context.watch<DismissibleOverlayEntry>().animation;
              return AnimatedBuilder(
                  animation: _ac,
                  builder: (context, child) {
                    return Positioned(
                      child: BoxContainer(
                        color: Colors.white.withOpacity(0.7),
                        useBlur: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: BoxContainer(
                                  customBorderRadius: BorderRadius.circular(6),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0,
                                          2.0), // shadow direction: bottom right
                                    )
                                  ]),
                                  child: Image.asset(
                                      "assets/images/other/Desktop.png")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: FloatingActionButton.extended(
                                onPressed: () {},
                                label: Text("New Desktop"),
                                icon: Icon(Icons.add),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white.withOpacity(0.5),
                                elevation: 0.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 175 * _ac.value,
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
