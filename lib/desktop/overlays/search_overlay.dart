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
import 'package:pangolin/widgets/app_laucher_tile.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';
import 'search/search_service.dart';

class SearchOverlay extends StatelessWidget {
  final String text;
  SearchOverlay({this.text = ""});

  final searchService = SearchNotifier();

  @override
  Widget build(BuildContext context) {
    final _animation =
        Provider.of<DismissibleOverlayEntry>(context, listen: false).animation;
    final _controller = TextEditingController(text: text != "" ? text : "");
    final _focusNode = FocusNode();
    _focusNode.requestFocus();
    return Positioned(
      top: 64,
      left: horizontalPadding(context, 600),
      right: horizontalPadding(context, 600),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            alignment: FractionalOffset.bottomCenter,
            child: BoxContainer(
              decoration: BoxDecoration(
                  boxShadow: [
                    /* BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 50,
                    ) */
                  ],
                  /* border: Border.all(
                      color: Theme.of(context).backgroundColor, width: 2), */
                  borderRadius: BorderRadius.circular(10)),
              useSystemOpacity: true,
              color: Theme.of(context).backgroundColor,
              width: 500,
              height: 320,
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: Column(
                      children: [
                        BoxContainer(
                          //padding: EdgeInsets.symmetric(horizontal: 16),
                          color: Theme.of(context).backgroundColor,
                          useSystemOpacity: true,
                          height: 48,
                          child: Searchbar(
                            focusNode: _focusNode,
                            controller: _controller,
                            hint: 'Search Device, Apps and Web',
                            leading: Icon(Icons.search),
                            trailing: Icon(Icons.more_vert_rounded),
                            onTextChanged: searchService.globalSearch,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// `Applicotins builder`

                  ValueListenableBuilder(
                    builder: (_, List<Application>? apps, Widget? child) {
                      return apps!.isNotEmpty
                          ? Container(
                              height: 270,
                              child: ListView(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 16,
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Text(
                                      'Results',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    shrinkWrap: true,
                                    itemCount: apps.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (_, index) => AppLauncherTile(
                                      apps[index].packageName!,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox();
                    },
                    valueListenable: searchService.termSearchResult,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
