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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/common_data.dart';

class OverviewOverlay extends ShellOverlay {
  static const String overlayId = "overview";

  OverviewOverlay() : super(id: overlayId);

  @override
  _OverviewOverlayState createState() => _OverviewOverlayState();
}

class _OverviewOverlayState extends State<OverviewOverlay>
    with ShellOverlayState {
  @override
  FutureOr<void> requestShow(Map<String, dynamic> args) {
    controller.showing = true;
  }

  @override
  FutureOr<void> requestDismiss(Map<String, dynamic> args) {
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    final _hierarchy = WindowHierarchy.of(context);

    if (!controller.showing) return SizedBox();

    return Positioned.fromRect(
      rect: _hierarchy.wmBounds,
      child: GestureDetector(
        onTap: () {
          Shell.of(context, listen: false).dismissEverything();
          setState(() {});
        },
        child: BoxContainer(
          useBlur: false,
          color: Colors.black.withOpacity(0.5),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 152,
                child: BoxContainer(
                  color: Theme.of(context).backgroundColor,
                  useSystemOpacity: true,
                  useBlur: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: BoxContainer(
                          customBorderRadius: CommonData.of(context)
                              .borderRadius(BorderRadiusType.SMALL),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                  2.0,
                                  2.0,
                                ), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Image.asset("assets/images/other/Desktop.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FloatingActionButton.extended(
                          highlightElevation: 2,
                          onPressed: () {},
                          hoverColor: Theme.of(context).backgroundColor,
                          label: Text("New Desktop"),
                          icon: Icon(Icons.add),
                          hoverElevation: 1,
                          foregroundColor:
                              Theme.of(context).textTheme.bodyText1?.color,
                          backgroundColor: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.5),
                          elevation: 0.0,
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
