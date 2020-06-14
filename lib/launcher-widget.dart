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


class LauncherWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
         
        child: Stack(
          fit: StackFit.expand,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: BoxConstraints.expand(width: 100),
                  margin: EdgeInsets.only(left: 11, top: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(233, 177, 177, 177),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            constraints: BoxConstraints.expand(height: 100),
                            margin: EdgeInsets.only(left: 20, top: 20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(233, 177, 177, 177),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            constraints: BoxConstraints.expand(height: 75),
                            margin: EdgeInsets.only(left: 33, top: 20),
                            child: Image.asset(
                              "lib/images/wallpaper.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 44, top: 3),
                            child: Text(
                              "Wallpaper",
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 34, 34),
                                fontSize: 12,
                                fontFamily: "Roboto",
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 20, right: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(233, 177, 177, 177),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, right: 32),
                                  child: Image.asset(
                                    "lib/images/wallpaper.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3, right: 42),
                                  child: Text(
                                    "Wallpaper",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 34, 34, 34),
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 20, right: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(233, 177, 177, 177),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, right: 22),
                                  child: Image.asset(
                                    "lib/images/wallpaper.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3, right: 32),
                                  child: Text(
                                    "Wallpaper",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 34, 34, 34),
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        constraints: BoxConstraints.expand(height: 75),
                        margin: EdgeInsets.only(left: 24, top: 20),
                        child: Image.asset(
                          "lib/images/wallpaper.png",
                          fit: BoxFit.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35, top: 3),
                        child: Text(
                          "Wallpaper",
                          style: TextStyle(
                            color: Color.fromARGB(255, 34, 34, 34),
                            fontSize: 12,
                            fontFamily: "Roboto",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: BoxConstraints.expand(width: 100),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(233, 177, 177, 177),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: BoxConstraints.expand(width: 75),
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "lib/images/wallpaper.png",
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    "Wallpaper",
                    style: TextStyle(
                      color: Color.fromARGB(255, 34, 34, 34),
                      fontSize: 12,
                      fontFamily: "Roboto",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
