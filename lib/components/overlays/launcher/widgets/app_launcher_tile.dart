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

import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:provider/provider.dart';

class AppLauncherTile extends StatefulWidget {
  final Application application;

  const AppLauncherTile(
    this.application, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppLauncherTile> createState() => _AppLauncherTileState();
}

class _AppLauncherTileState extends State<AppLauncherTile> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() => _hover = true),
      onExit: (details) => setState(() => _hover = false),
      child: GestureDetector(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          dense: true,
          leading: Image.asset(
            "assets/icons/${widget.application.iconName}.png",
            height: 32,
          ),
          title: Text(widget.application.name ?? "Unknown"),
          subtitle: Text(
            widget.application.description ?? "Unknown",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Offstage(
              offstage: !_hover,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer(builder: (context,
                      CustomizationProvider customizationProvider, _) {
                    return QuickActionButton(
                      size: 32,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.zero,
                      leading: const Icon(Icons.push_pin_rounded),
                      onPressed: () {
                        customizationProvider
                            .togglePinnedApp(widget.application.packageName);
                      },
                    );
                  }),
                  const QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.settings_outlined),
                  ),
                  const QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.more_vert_rounded),
                  ),
                ],
              )),
          onTap: () {
            widget.application.launch(context);
          },
        ),
      ),
    );
  }
}
