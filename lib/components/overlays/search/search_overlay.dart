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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/search/search_tile.dart';
import 'package:pangolin/components/overlays/search/searchbar.dart';
import 'package:pangolin/services/search.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:yatl_flutter/yatl_flutter.dart';

class SearchOverlay extends ShellOverlay {
  static const String overlayId = "search";

  SearchOverlay({super.key}) : super(id: overlayId);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ShellOverlayState<SearchOverlay>
    with StateServiceListener<CustomizationService, SearchOverlay> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final List<DesktopEntry> results = [];

  @override
  Future<void> requestShow(Map<String, Object?> args) async {
    _controller.text = args['searchQuery'] as String? ?? "";
    controller.showing = true;
    await animationController.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    controller.showing = false;
    await animationController.reverse();
  }

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    if (shouldHide) return const SizedBox();

    _focusNode.requestFocus();

    return Positioned(
      top: 64,
      left: horizontalPadding(context, 720),
      right: horizontalPadding(context, 720),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            alignment: FractionalOffset.bottomCenter,
            child: SurfaceLayer(
              outline: true,
              dropShadow: true,
              height: 400,
              shape: Constants.bigShape,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Searchbar(
                      focusNode: _focusNode,
                      controller: _controller,
                      onChanged: (text) async {
                        results.clear();
                        results.addAll(
                          await SearchService.current.search(
                            text,
                            context.locale,
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
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
                    ),
                  ),
                  if (results.isNotEmpty)
                    searchResults()
                  else if (results.isEmpty && _controller.text.isEmpty)
                    searchSuggestions(service)
                  else
                    const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox searchResults() {
    return SizedBox(
      height: 284,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        shrinkWrap: true,
        itemCount: results.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => SearchTile(results[index].id),
      ),
    );
  }

  SizedBox searchSuggestions(CustomizationService service) {
    return SizedBox(
      height: 282,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        shrinkWrap: true,
        itemCount: service.recentSearchResults.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => SearchTile(
          service.recentSearchResults[index],
        ),
      ),
    );
  }
}
