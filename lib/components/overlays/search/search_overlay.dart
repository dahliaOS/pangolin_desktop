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

import 'package:pangolin/components/overlays/search/widgets/search_tile.dart';
import 'package:pangolin/components/overlays/search/widgets/searchbar.dart';
import 'package:pangolin/components/shell/shell.dart';
import 'package:pangolin/services/search_service.dart';
import 'package:pangolin/utils/data/common_data.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/search_provider.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class SearchOverlay extends ShellOverlay {
  static const String overlayId = "search";

  SearchOverlay({Key? key}) : super(key: key, id: overlayId);

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
  Widget build(BuildContext context) {
    final Animation<double> _animation = CurvedAnimation(
      parent: ac,
      curve: CommonData.of(context).animationCurve(),
    );
    final _searchProvider = SearchProvider.of(context);
    _focusNode.requestFocus();

    if (!controller.showing) return const SizedBox();

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
                  CommonData.of(context).borderRadius(BorderRadiusType.big),
              width: 500,
              height: 324,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //  outline: false,
                    height: 48 + 10,
                    child: Searchbar(
                      color: Theme.of(context).backgroundColor.withOpacity(0.2),
                      borderRadius: CommonData.of(context)
                          .borderRadius(BorderRadiusType.medium),
                      focusNode: _focusNode,
                      controller: _controller,
                      hint: LSX.searchOverlay.hint,
                      leading: const Icon(Icons.search),
                      trailing: const Icon(Icons.menu_rounded),
                      onTextChanged: searchService.globalSearch,
                    ),
                  ),

                  /// `Applicotins builder`

                  Material(
                    type: MaterialType.transparency,
                    child: ValueListenableBuilder(
                      builder: (_, List<Application>? apps, Widget? child) {
                        return apps!.isNotEmpty
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
                                        LSX.searchOverlay.results,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: CommonData.of(context)
                                              .textColor(),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 4,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: apps.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (_, index) => SearchTile(
                                        apps[index].packageName,
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
                                        LSX.searchOverlay.recent,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: CommonData.of(context)
                                              .textColor(),
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
                                      itemCount: _searchProvider
                                          .recentSearchResults.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (_, index) => SearchTile(
                                        _searchProvider
                                            .recentSearchResults[index],
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
