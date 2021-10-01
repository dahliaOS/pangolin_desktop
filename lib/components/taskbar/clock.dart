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

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:provider/provider.dart';
import 'package:pangolin/utils/extensions/preference_extension.dart';

class DateClockWidget extends StatefulWidget {
  @override
  State<DateClockWidget> createState() => _DateClockWidgetState();
}

class _DateClockWidgetState extends State<DateClockWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final _pref = Provider.of<PreferenceProvider>(context);
    return ValueListenableBuilder(
      valueListenable: DateTimeManager.getDateNotifier()!,
      builder: (BuildContext context, String date, Widget? child) =>
          ValueListenableBuilder(
        valueListenable: DateTimeManager.getTimeNotifier()!,
        builder: (BuildContext context, String time, Widget? child) => SizedBox(
          width: _pref.isTaskbarHorizontal ? time.characters.length * 12 : 40,
          height: _pref.isTaskbarHorizontal ? 48 : time.characters.length * 9,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.SMALL),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onHover: (hover) {
                    setState(() {
                      _hover = hover;
                    });
                  },
                  hoverColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Center(
                      child: _pref.isTaskbarHorizontal
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  time,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: _hover ? 13 : 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Offstage(
                                  offstage: !_hover,
                                  child: Text(
                                    date,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  time.replaceAll(":", "\n"),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                _pref.isTaskbarHorizontal
                                    ? Text(
                                        date,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
