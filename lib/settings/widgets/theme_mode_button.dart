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
import 'package:pangolin/settings/models/settings_theme_data_model.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/theme_manager.dart';
import 'package:provider/provider.dart';

class ThemeModeButton extends StatefulWidget {
  final ThemeModeDataModel model;
  const ThemeModeButton({Key? key, required this.model}) : super(key: key);

  @override
  State<ThemeModeButton> createState() => _ThemeModeButtonState();
}

class _ThemeModeButtonState extends State<ThemeModeButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: CommonData.of(context).borderRadius(
        BorderRadiusType.SMALL,
      ),
      child: InkWell(
        borderRadius: CommonData.of(context).borderRadius(
          BorderRadiusType.SMALL,
        ),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          provider.darkMode = widget.model.darkMode;
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: (widget.model.darkMode == provider.darkMode)
                ? ThemeManager.of(context).accentColor
                : Colors.transparent,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              children: [
                Container(
                  width: 4 * 28,
                  height: 3 * 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(widget.model.color.value),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _cardElement(widget.model),
                              SizedBox(height: 8),
                              _cardElement(widget.model),
                              SizedBox(height: 8),
                              _cardElement(widget.model),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        _cardElement(widget.model),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.model.label,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: widget.model.darkMode == provider.darkMode
                            ? ThemeManager.of(context)
                                        .accentColor
                                        .computeLuminance() <
                                    0.4
                                ? Colors.white
                                : Colors.black
                            : null,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _cardElement(ThemeModeDataModel model) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: model.darkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
              width: 2),
          color: model.darkMode ? Color(0xff212121) : Color(0xfff0f0f0),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
