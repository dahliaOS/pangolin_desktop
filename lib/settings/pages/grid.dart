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
import 'package:pangolin/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/hover.dart';
import 'package:provider/provider.dart';

class SettingsHome extends StatefulWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Theme.of(context).cardColor,
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              direction: Axis.horizontal,
              children: [
                Container(
                  child: Hero(
                    tag: "search",
                    child: Material(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(25)),
                      //elevation: 5.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/search");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 45.0,
                          margin: EdgeInsets.only(left: 10, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: AbsorbPointer(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 15,
                                    ),
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.blue,
                                    ),
                                    hintText: 'Search settings...',
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: null,
                                  controller: provider.controller,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  Settings.items.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: 300,
                    height: 85,
                    child: Hover(
                      color: Color(_data.accentColor).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ListTile(
                              dense: true,
                              title: Text(Settings.items[index].title,
                                  style: Theme.of(context).textTheme.bodyText1),
                              subtitle: Text(Settings.items[index].subtitle),
                              leading: Icon(
                                Settings.items[index].icon,
                                size: 35,
                                color: Color(_data.accentColor),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.pageIndex = index;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
