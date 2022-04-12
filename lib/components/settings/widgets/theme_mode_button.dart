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

import 'package:pangolin/components/settings/models/settings_theme_data_model.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';

class ThemeModeButton extends StatefulWidget {
  final ThemeModeDataModel model;
  const ThemeModeButton({Key? key, required this.model}) : super(key: key);

  @override
  State<ThemeModeButton> createState() => _ThemeModeButtonState();
}

class _ThemeModeButtonState extends State<ThemeModeButton> {
  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    return ClipRRect(
      borderRadius: CommonData.of(context).borderRadius(
        BorderRadiusType.small,
      ),
      child: InkWell(
        borderRadius: CommonData.of(context).borderRadius(
          BorderRadiusType.small,
        ),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          _customizationProvider.darkMode = widget.model.darkMode;
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: (widget.model.darkMode == _customizationProvider.darkMode)
                ? context.theme.accent
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
                        _cardElement(widget.model),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _cardElement(widget.model),
                              const SizedBox(height: 8),
                              _cardElement(widget.model),
                              const SizedBox(height: 8),
                              _cardElement(widget.model),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.model.label,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: widget.model.darkMode ==
                                _customizationProvider.darkMode
                            ? context.theme.foregroundColor
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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: model.darkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            width: 2,
          ),
          color: model.darkMode
              ? const Color(0xff212121)
              : const Color(0xfff0f0f0),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
