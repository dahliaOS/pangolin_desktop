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
import 'package:pangolin/desktop/shell.dart';
import 'package:pangolin/utils/common_data.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:pangolin/widgets/app_laucher_tile.dart';
import 'package:pangolin/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'search_service.dart';

class SearchOverlay extends ShellOverlay {
  static const String overlayId = "search";

  SearchOverlay() : super(id: overlayId);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay>
    with SingleTickerProviderStateMixin, ShellOverlayState {
  final searchService = SearchNotifier();
  late AnimationController ac;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: CommonData.of(context).animationDuration(),
    );
    ac.forward();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    _controller.text = args['searchQuery'] ?? "";
    controller.showing = true;
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );
    final _pref = Provider.of<PreferenceProvider>(context, listen: false);
    _focusNode.requestFocus();

    if (!controller.showing) return SizedBox();

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
            child: BoxSurface(
              dropShadow: true,
              borderRadius:
                  CommonData.of(context).borderRadius(BorderRadiusType.BIG),
              width: 500,
              height: 324,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //  outline: false,
                    height: 48 + 10,
                    child: Searchbar(
                      outline: false,
                      color: Theme.of(context).backgroundColor.withOpacity(0.2),
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.MEDIUM),
                      focusNode: _focusNode,
                      controller: _controller,
                      hint: 'Search Device, Apps and Web',
                      leading: Icon(Icons.search),
                      trailing: Icon(Icons.menu_rounded),
                      onTextChanged: searchService.globalSearch,
                    ),
                  ),

                  /// `Applicotins builder`

                  Material(
                    type: MaterialType.transparency,
                    child: ValueListenableBuilder(
                      builder: (_, List<Application>? apps, Widget? child) {
                        return apps!.isNotEmpty
                            ? Container(
                                height: 240,
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
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: CommonData.of(context)
                                                .textColor()),
                                      ),
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      shrinkWrap: true,
                                      itemCount: apps.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (_, index) =>
                                          AppLauncherTile(
                                        apps[index].packageName!,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: 240,
                                child: ListView(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 16,
                                        left: 24,
                                        right: 24,
                                      ),
                                      child: Text(
                                        'Recent',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: CommonData.of(context)
                                                .textColor()),
                                      ),
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      shrinkWrap: true,
                                      reverse: true,
                                      itemCount:
                                          _pref.recentSearchResults.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (_, index) =>
                                          AppLauncherTile(
                                        _pref.recentSearchResults[index],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                      valueListenable: searchService.termSearchResult,
                    ),
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
