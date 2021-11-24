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
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/widgets/box/box_container.dart';

class Searchbar extends StatelessWidget {
  final Widget? leading, trailing;
  final String? hint;
  final String text;
  final Color? color;
  final bool outline;
  final TextEditingController? controller;
  final BorderRadius? borderRadius;
  final FocusNode? focusNode;
  final void Function(String)? onTextChanged;
  const Searchbar(
      {required this.leading,
      required this.trailing,
      required this.hint,
      required this.controller,
      this.outline = false,
      this.borderRadius,
      this.focusNode,
      this.text = "",
      this.color,
      this.onTextChanged});
  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      outline: outline,
      borderRadius: borderRadius ??
          CommonData.of(context).borderRadius(BorderRadiusType.MEDIUM),
      width: 800,
      height: 48,
      child: Material(
        type: MaterialType.transparency,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 48,
              width: 56,
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: this.leading ??
                    SizedBox(
                      height: 48,
                      width: 48,
                    ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: onTextChanged,
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 48,
              width: 56,
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: this.trailing ??
                    SizedBox(
                      height: 48,
                      width: 48,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
