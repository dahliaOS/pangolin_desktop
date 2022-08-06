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

import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/search/widgets/search_tile.dart';
import 'package:pangolin/components/overlays/search/widgets/searchbar.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/services/search.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/providers/locale_provider.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/services.dart';

class SearchOverlay extends ShellOverlay {
  static const String overlayId = "search";

  SearchOverlay({super.key}) : super(id: overlayId);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay>
    with
        SingleTickerProviderStateMixin,
        ShellOverlayState,
        StateServiceListener<CustomizationService, SearchOverlay> {
  late AnimationController ac;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final List<Application> results = [];

  @override
  void initState() {
    super.initState();
    ac = AnimationController(
      vsync: this,
      duration: Constants.animationDuration,
    );
    ac.forward();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Future<void> requestShow(Map<String, Object?> args) async {
    _controller.text = args['searchQuery'] as String? ?? "";
    controller.showing = true;
    await ac.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    await ac.reverse();
    controller.showing = false;
  }

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final Animation<double> animation = CurvedAnimation(
      parent: ac,
      curve: Constants.animationCurve,
    );
    _focusNode.requestFocus();

    if (!controller.showing) return const SizedBox();

    return Positioned(
      top: 64,
      left: horizontalPadding(context, 600),
      right: horizontalPadding(context, 600),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: FractionalOffset.bottomCenter,
            child: BoxSurface(
              dropShadow: true,
              width: 500,
              height: 324,
              shape: Constants.bigShape,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //  outline: false,
                    height: 48 + 10,
                    child: Searchbar(
                      color: Theme.of(context).backgroundColor.withOpacity(0.2),
                      focusNode: _focusNode,
                      controller: _controller,
                      hint: strings.searchOverlay.hint,
                      leading: const Icon(Icons.search),
                      trailing: const Icon(Icons.menu_rounded),
                      onTextChanged: (text) async {
                        results.clear();
                        results.addAll(
                          await SearchService.current.search(text),
                        );
                        setState(() {});
                      },
                    ),
                  ),

                  /// `Applications builder`

                  Material(
                    type: MaterialType.transparency,
                    child: results.isNotEmpty
                        ? SizedBox(
                            height: 240,
                            child: ListView(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    left: 24,
                                    right: 24,
                                  ),
                                  child: Text(
                                    strings.searchOverlay.results,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: results.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (_, index) => SearchTile(
                                    results[index].packageName,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 240,
                            child: ListView(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    left: 24,
                                    right: 24,
                                  ),
                                  child: Text(
                                    strings.searchOverlay.recent,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: service.recentSearchResults.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (_, index) => SearchTile(
                                    service.recentSearchResults[index],
                                  ),
                                ),
                              ],
                            ),
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
