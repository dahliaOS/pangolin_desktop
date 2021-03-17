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

class SearchOverlay extends StatelessWidget {
  final String text;
  const SearchOverlay({this.text = ""});
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(text: text != "" ? text : "");
    final _focusNode = FocusNode();
    _focusNode.requestFocus();
    return Builder(builder: (context) {
      return Positioned(
        top: 64,
        left: horizontalPadding(context, 600),
        right: horizontalPadding(context, 600),
        child: BoxContainer(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 50)
              ],
              border: Border.all(
                  color: Theme.of(context).backgroundColor, width: 2),
              borderRadius: BorderRadius.circular(10)),
          useSystemOpacity: true,
          color: Theme.of(context).backgroundColor,
          width: 500,
          height: 320,
          child: Column(
            children: [
              SizedBox(
                height: 52,
                child: Column(
                  children: [
                    BoxContainer(
                        //padding: EdgeInsets.symmetric(horizontal: 16),
                        color: Theme.of(context).backgroundColor,
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
  }
}
