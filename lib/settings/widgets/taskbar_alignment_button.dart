import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/settings/models/settings_taskbar_data_model.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/theme_manager.dart';
import 'package:provider/provider.dart';

class TaskbarAlignmentButton extends StatelessWidget {
  final TaskbarAlignmentModelData model;
  const TaskbarAlignmentButton({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceProvider>(context);
    bool isCentred = provider.centerTaskbar;
    bool _isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
          provider.centerTaskbar = model.centred;
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: isCentred == model.centred
                ? ThemeManager.of(context).accentColor
                : Colors.transparent,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              children: [
                Container(
                  width: 8 * 64,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: borderStyle(_isDarkMode),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            _taskbarElement(context),
                            SizedBox(width: 8),
                            _taskbarElement(context),
                            SizedBox(width: 8),
                            _taskbarElement(context),
                          ]..addAll(model.centred
                              ? []
                              : [
                                  SizedBox(width: 16),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: model.centred
                              ? [
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                  SizedBox(width: 8),
                                  _taskbarElement(context, shaded: true),
                                ]
                              : [],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _taskbarElement(context, multiplier: 1.75),
                            SizedBox(width: 8),
                            _taskbarElement(context, multiplier: 1.75),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  model.label,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: isCentred == model.centred
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

  Border borderStyle(bool _isDarkMode) {
    return Border.all(
        color: _isDarkMode
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.2),
        width: 2);
  }

  Container _taskbarElement(BuildContext context,
      {double multiplier = 1, bool shaded = false}) {
    bool _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final hslBgc =
        HSLColor.fromColor(Theme.of(context).scaffoldBackgroundColor);
    return Container(
      child: Container(
        width: 20 * multiplier,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
              color: !_isDarkMode
                  ? Colors.black.withOpacity(0.2)
                  : Colors.white.withOpacity(0.2),
              width: 2),
          color: shaded
              ? hslBgc
                  .withLightness(hslBgc.lightness > 0.5
                      ? hslBgc.lightness - 0.2
                      : hslBgc.lightness + 0.2)
                  .toColor()
              : hslBgc.toColor(),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
