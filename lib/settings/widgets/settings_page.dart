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
import 'package:pangolin/settings/models/settings_element_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  final List<SettingsElementModel> cards;

  const SettingsPage({required this.title, required this.cards, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PreferenceProvider>(context, listen: false);
    return Stack(
      children: [
        SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.only(left: 64, top: 42),
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(64, 96, 64, 24),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 500,
            child: SingleChildScrollView(
              child: Column(
                children: this.cards,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
