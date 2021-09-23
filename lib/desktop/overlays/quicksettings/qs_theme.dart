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
import 'package:pangolin/settings/data/presets.dart';
import 'package:pangolin/widgets/qs_appbar.dart';
import 'package:provider/provider.dart';

class QsTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: QsAppBar(
          title: "Dark Mode",
          value: _pref.darkMode,
          onTap: () {
            _pref.darkMode = !_pref.darkMode;
          },
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: SettingsPresets.accentColorPresets.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                _pref.accentColor =
                    SettingsPresets.accentColorPresets[index].color.value;
              },
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              leading: AccentColorIcon(
                color: SettingsPresets.accentColorPresets[index].color,
              ),
              title: Text(SettingsPresets.accentColorPresets[index].label),
            );
          },
        ));
  }
}

class AccentColorIcon extends StatelessWidget {
  final Color? color;

  const AccentColorIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: true);
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CircleAvatar(
              backgroundColor: color ?? Theme.of(context).colorScheme.secondary,
              child: Icon(
                  color != null
                      ? _data.accentColor == color?.value
                          ? Icons.blur_circular
                          : null
                      : Icons.add,
                  color: DatabaseManager.get("darkMode")
                      ? Colors.black
                      : Colors.white)),
        ),
      ),
    );
  }
}
