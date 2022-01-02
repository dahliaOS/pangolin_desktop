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

import 'package:flutter/material.dart';

void showKeyboard(BuildContext context) {
  const List<String> row1 = [
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
  const List<String> row2 = [
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
  const List<String> row3 = [
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
  const List<String> row4 = [
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
  const List<String> row5 = [
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
    transitionDuration: const Duration(milliseconds: 120),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 350,
          width: double.maxFinite,
          margin: const EdgeInsets.only(bottom: 75, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox.expand(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(row1.length, (index) {
                        return keyboardKey(row1[index]);
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(row2.length, (index) {
                        return keyboardKey(row2[index]);
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(row3.length, (index) {
                        return keyboardKey(row3[index]);
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(row4.length, (index) {
                        return keyboardKey(row4[index]);
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        row5.length,
                        (index) {
                          return keyboardKey(row5[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
    margin: const EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5, bottom: 2.5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Center(
        child: Text(
          letter.toUpperCase(),
        ),
      ),
    ),
  );
}
