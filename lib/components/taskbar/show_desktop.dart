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

import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/wm.dart';
import 'package:pangolin/utils/wm/wm_api.dart';

class ShowDesktopButton extends StatefulWidget {
  const ShowDesktopButton({Key? key}) : super(key: key);

  @override
  State<ShowDesktopButton> createState() => _ShowDesktopButtonState();
}

class _ShowDesktopButtonState extends State<ShowDesktopButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: LSX.desktop.miscShowDesktop,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHover: (hover) {
          setState(() {
            isHovered = hover;
          });
        },
        onTap: () {
          Shell.of(context, listen: false).dismissEverything();
          if (WindowHierarchy.of(context, listen: false)
              .entries
              .any((e) => e.layoutState.minimized == false)) {
            WmAPI.of(context).minimizeAll();
          } else {
            WmAPI.of(context).undoMinimizeAll();
          }
        },
        child: SizedBox(
          width: 8,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 20,
                    width: 2,
                    color: isHovered
                        ? context.theme.textTheme.bodyText1?.color
                        : Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
