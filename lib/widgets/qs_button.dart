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
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuickSettingsButton extends StatefulWidget {
  final String title;
  final void Function() onTap, onTapSecondary;
  final IconData icon, disabledIcon;
  bool enabled;

  QuickSettingsButton({
    required this.title,
    required this.onTap,
    required this.icon,
    required this.disabledIcon,
    required this.enabled,
    required this.onTapSecondary,
  });

  @override
  _QuickSettingsButtonState createState() => _QuickSettingsButtonState();
}

class _QuickSettingsButtonState extends State<QuickSettingsButton> {
  @override
  Widget build(BuildContext context) {
    final _feature = Provider.of<FeatureFlags>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: GestureDetector(
            onSecondaryTap: widget.onTapSecondary,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      DatabaseManager.get("qsTileRounding"))),
              fillColor: widget.enabled
                  ? _feature.useAccentColorBG
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                      : Theme.of(context).colorScheme.secondary
                  : _feature.useAccentColorBG
                      ? Theme.of(context).backgroundColor.withOpacity(0.5)
                      : Theme.of(context).backgroundColor,
              enableFeedback: true,
              elevation: 0.0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              onLongPress: widget.onTapSecondary,
              //borderRadius: BorderRadius.circular(25),
              onPressed: () {
                widget.onTap();
                //widget.enabled = !widget.enabled;
                setState(() {});
              },
              mouseCursor: SystemMouseCursors.click,
              child: Icon(
                widget.enabled ? widget.icon : widget.disabledIcon,
                color: widget.enabled
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1?.color,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: widget.onTapSecondary,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Text(
              widget.title.split(" ")[0].characters.length > 2
                  ? widget.title.replaceAll(" ", "\n")
                  : widget.title.replaceRange(6, 7, "\n"),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

Widget actionChip(IconData icon, String? label, context) {
  return Padding(
    padding: EdgeInsets.only(right: 8),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          onTap: () {},
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: label != null ? 8.0 : 0.0),
                    child: Icon(
                      icon,
                      size: 16,
                    ),
                  ),
                  Text(
                    label ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            ),
          )),
    ),
  );
}
