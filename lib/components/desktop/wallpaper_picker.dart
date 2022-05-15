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

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class WallpaperPicker extends StatefulWidget {
  const WallpaperPicker({
    Key? key,
  }) : super(key: key);

  @override
  _WallpaperPickerState createState() => _WallpaperPickerState();
}

class _WallpaperPickerState extends State<WallpaperPicker>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _customizationProvider = CustomizationProvider.of(context);
    final _controller = TextEditingController();
    final List<String> _recentWallpapers = List.from(
      _customizationProvider.recentWallpapers.reversed,
    );
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BoxSurface(
        borderRadius: BorderRadius.circular(8),
        margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 100),
        width: MediaQuery.of(context).size.width - 300,
        height: MediaQuery.of(context).size.height - 300,
        child: GestureDetector(
          onTap: () {},
          child: AlertDialog(
            insetPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: TabBar(
              enableFeedback: true,
              physics: const BouncingScrollPhysics(),
              indicatorColor: Theme.of(context).colorScheme.secondary,
              labelColor: Theme.of(context).colorScheme.secondary,
              labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              unselectedLabelColor:
                  Theme.of(context).textTheme.bodyText1?.color,
              unselectedLabelStyle:
                  Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Default Wallpapers",
                ),
                Tab(
                  text: "Wallpapers Repository",
                ),
                Tab(
                  text: "Recent Wallpapers",
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 300,
              height: MediaQuery.of(context).size.height - 100,
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: [
                  //
                  //Default Wallpapers
                  //
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: wallpapers.length,
                    itemBuilder: (BuildContext context, int index) {
                      //_index = index;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _customizationProvider.wallpaper =
                                wallpapers[index];
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  wallpapers[index],
                                  fit: BoxFit.cover,
                                  scale: 1.0,
                                ),
                              ),
                              if (_customizationProvider.wallpaper ==
                                  wallpapers[index])
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    foregroundColor: Colors.white,
                                    child: const Icon(Icons.check),
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  //
                  //TODO Wallpapers Repository
                  //
                  Container(
                    color: Colors.green,
                    child: const Center(child: Text("Coming Soon")),
                  ),
                  //
                  //Recent Wallpapers
                  //
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _recentWallpapers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 16 / 9,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          mouseCursor: SystemMouseCursors.click,
                          onTap: () => _customizationProvider.wallpaper =
                              _recentWallpapers[index],
                          child: CachedNetworkImage(
                            errorWidget: (context, string, _) => Container(
                              color: Theme.of(context).colorScheme.secondary,
                              child: const Center(
                                child: Text(
                                  "Error\nImage does not exist anymore",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            imageUrl: _recentWallpapers[index],
                            cacheKey: _recentWallpapers[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  //
                  //Text Filed for Wallpaper URL
                  //
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        hintText: "Set wallpaper from URL",
                        labelText: "Wallpaper URL",
                      ),
                      controller: _controller,
                      onSubmitted: (text) {
                        if (text.startsWith("http")) {
                          _customizationProvider.wallpaper = text;
                          _customizationProvider.addRecentWallpaper(text);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  //
                  //Bing Wallpaper
                  //
                  FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () async {
                      final bingresponse = await getBingWallpaper();
                      _customizationProvider.wallpaper =
                          'https://bing.com${bingresponse.images.first.url}';
                      _customizationProvider.addRecentWallpaper(
                        'https://bing.com${bingresponse.images.first.url}',
                      );
                      Navigator.pop(context);
                    },
                    label: const Text(
                      "Use Bing Wallpaper",
                    ),
                    icon: const Icon(
                      Icons.image_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  //
                  //Save Button
                  //
                  FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      if (_controller.text.startsWith("http")) {
                        _customizationProvider.wallpaper = _controller.text;
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    label: const Text(
                      "Save",
                      style: TextStyle(),
                    ),
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
