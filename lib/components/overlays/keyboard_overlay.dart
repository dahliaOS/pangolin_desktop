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
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/components/shell/shell.dart';

void ShowKeyboard(context) {
  List<String> row1 = [
    "~\n`",
    "!\n1",
    "@\n2",
    "#\n3",
    "\$\n4",
    "%\n5",
    "^\n6",
    "&\n7",
    "*\n8",
    "(\n9",
    ")\n0",
    "_\n-",
    "+\n=",
    "delete"
  ];
  List<String> row2 = [
    "tab",
    "q",
    "w",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "{\n[",
    "}\n]",
    "|\n\\"
  ];
  List<String> row3 = [
    "caps",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    ":\n;",
    "\"\n'",
    "enter"
  ];
  List<String> row4 = [
    "shift",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m",
    "<\n,",
    ">\n.",
    "?\n/",
    "shift"
  ];
  List<String> row5 = [
    "fn",
    "control",
    "alt",
    "meta",
    "[----------------------]",
    "control",
    "alt",
    "up",
    "dn"
  ];
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0),
    transitionDuration: Duration(milliseconds: 120),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 350,
          width: double.maxFinite,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox.expand(
                child: new Center(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(row1.length, (index) {
                          return keyboardKey(row1[index].toString());
                        }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(row2.length, (index) {
                          return keyboardKey(row2[index].toString());
                        }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(row3.length, (index) {
                          return keyboardKey(row3[index].toString());
                        }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(row4.length, (index) {
                          return keyboardKey(row4[index].toString());
                        }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(row5.length, (index) {
                          return keyboardKey(row5[index].toString());
                        }),
                      ),
                    ])),
              )),
          margin: EdgeInsets.only(bottom: 75, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return FadeTransition(
        opacity: anim,
        child: child,
      );
    },
  );
}

Widget keyboardKey(String letter) {
  return Container(
    height: 50,
    child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Center(child: Text(letter.toUpperCase()))),
    margin: EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5, bottom: 2.5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
