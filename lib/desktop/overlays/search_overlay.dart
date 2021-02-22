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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:utopia_wm/wm.dart';
import 'package:provider/provider.dart';

class SearchOverlay extends StatelessWidget {
  final String text;
  const SearchOverlay({this.text = ""});
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(text: text);
    final _focusNode = FocusNode();
    _focusNode.requestFocus();
    return Builder(builder: (context) {
      final _ac = context.watch<DismissibleOverlayEntry>().animation;
      return AnimatedBuilder(
          animation: _ac,
          builder: (context, child) {
            return Positioned(
              top: 64,
              left: sidePadding(context, 600),
              right: sidePadding(context, 600),
              child: BoxContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                useSystemOpacity: true,
                color: Theme.of(context).scaffoldBackgroundColor,
                customBorderRadius: BorderRadius.circular(10),
                width: 500,
                height: 320 * _ac.value,
                //margin: EdgeInsets.only(bottom: wmKey.currentState!.insets.bottom + 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: Column(
                        children: [
                          BoxContainer(
                              //padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              useSystemOpacity: true,
                              height: 52,
                              child: Searchbar(
                                focusNode: _focusNode,
                                controller: _controller,
                                hint: '"Search Device, Apps and Web',
                                leading: Icon(Icons.search),
                                trailing: Icon(Icons.more_vert_rounded),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
