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
import 'package:flutter/material.dart';

import '../../main.dart';

class DahliaNotification {
  static showNotification(
      String title, String subtitle, IconData icon, Function onClick) async {
    OverlayEntry _overlayEntry;
    bool _hover = false;
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              child: Center(
                child: SizedBox(
                  width: 350,
                  child: GestureDetector(
                    onTap: () {
                      onClick;
                      _overlayEntry.remove();
                    },
                    child: MouseRegion(
                      onHover: (event) {
                        _hover = true;
                      },
                      child: Dismissible(
                        key: ValueKey(_overlayEntry),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              icon,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _overlayEntry.remove();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(subtitle),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
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
              bottom: 50,
              right: 5,
            ));
    Pangolin.overlayState.insert(_overlayEntry);

    await Future.delayed(Duration(seconds: 5));

    if (_hover == false) {
      _overlayEntry.remove();
    }
  }
}
