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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/widgets/resource/image/image.dart';
import 'package:zenit_ui/zenit_ui.dart';

class OverviewOverlay extends ShellOverlay {
  static const String overlayId = "overview";

  OverviewOverlay({super.key}) : super(id: overlayId);

  @override
  _OverviewOverlayState createState() => _OverviewOverlayState();
}

class _OverviewOverlayState extends ShellOverlayState<OverviewOverlay>
    with StateServiceListener<CustomizationService, OverviewOverlay> {
  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) {
    controller.showing = true;
    animationController.value = 1;
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) {
    controller.showing = false;
    animationController.value = 0;
  }

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    if (shouldHide) return const SizedBox();

    final WindowHierarchyController hierarchy = WindowHierarchy.of(context);
    final ImageResource image = service.wallpaper;
    final theme = Theme.of(context);

    return Positioned.fromRect(
      rect: hierarchy.wmBounds,
      child: GestureDetector(
        onTap: () {
          ShellService.current.dismissEverything();
          setState(() {});
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.surfaceColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 152,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: theme.colorScheme.background),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          shape: Constants.smallShape.copyWith(
                            side: BorderSide(
                              color: theme.foregroundColor,
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: ResourceImage(
                              resource: image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FloatingActionButton.extended(
                          highlightElevation: 2,
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: Text(strings.overviewOverlay.newDesktop),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
