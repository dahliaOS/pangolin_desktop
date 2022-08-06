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
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/services.dart';

class AccentColorButton extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  final BuiltinColor color;

  const AccentColorButton({
    super.key,
    required this.color,
  });

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final bool selected = service.accentColor == color.resource;

    return Tooltip(
      message: color.label,
      child: InkWell(
        customBorder: Constants.smallShape,
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          service.accentColor = color.resource;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: selected ? 64 : 48,
                  width: selected ? 64 : 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color.value,
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
