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
import 'package:pangolin/utils/globals.dart';
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
          /* elevation: 0,
        toolbarHeight: 48,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.4),
        centerTitle: true,
        title: Text("Wi-Fi"),
        actions: [
          Switch(value: true, onChanged: (val) {}),
          SizedBox(
            width: 8,
          ),
        ], */
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: accentColors.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                accentColors[index].color != null
                    ? _pref.accentColor = accentColors[index].color!.value
                    //TODO Fix accent color dialog
                    : /* Customization.accentColorDialog(context, _pref) */ Container;
              },
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              leading: AccentColorIcon(
                color: accentColors[index].color,
              ),
              title: Text(accentColors[index].title),
            );
          },
        )
        /* Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Customization.accentColors(_pref, context),
        ),
      ), */
        );
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
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                )
              ]),
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
