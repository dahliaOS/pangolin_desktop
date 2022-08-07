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
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/api_models/bing_wallpaper_api_model.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';
import 'package:pangolin/widgets/global/resource/image/image.dart';
import 'package:pangolin/widgets/services.dart';

class WallpaperPicker extends StatefulWidget {
  const WallpaperPicker({super.key});

  @override
  _WallpaperPickerState createState() => _WallpaperPickerState();
}

class _WallpaperPickerState extends State<WallpaperPicker>
    with
        TickerProviderStateMixin,
        StateServiceListener<CustomizationService, WallpaperPicker> {
  final TextEditingController _controller = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final List<ImageResource> recentWallpapers =
        service.recentWallpapers.reversed.toList();
    final List<ImageResource> builtinWalls = wallpapers
        .map((e) => ImageResource(type: ImageResourceType.dahlia, value: e))
        .toList();

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BoxSurface(
        shape: Constants.smallShape,
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
                Tab(text: "Default Wallpapers"),
                Tab(text: "Wallpapers Repository"),
                Tab(text: "Recent Wallpapers"),
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
                            service.wallpaper = builtinWalls[index];
                            service.addRecentWallpaper(service.wallpaper);
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ResourceImage(
                                  resource: builtinWalls[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (service.wallpaper == builtinWalls[index])
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
                  const ColoredBox(
                    color: Colors.green,
                    child: Center(child: Text("Coming Soon")),
                  ),
                  //
                  //Recent Wallpapers
                  //
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: recentWallpapers.length,
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
                          onTap: () =>
                              service.wallpaper = recentWallpapers[index],
                          child: ResourceImage(
                            errorBuilder: (context, url, _) => ColoredBox(
                              color: Theme.of(context).colorScheme.secondary,
                              child: const Center(
                                child: Text(
                                  "Error\nImage does not exist anymore",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            resource: recentWallpapers[index],
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
                          service.wallpaper = ImageResource(
                            type: ImageResourceType.network,
                            value: text,
                          );
                          service.addRecentWallpaper(service.wallpaper);
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
                      final BingImageOfTheDay? wallpaper =
                          await getBingWallpaper();

                      if (wallpaper == null) return;

                      service.wallpaper = ImageResource(
                        type: ImageResourceType.network,
                        value: wallpaper.images.first.url.toString(),
                      );
                      service.addRecentWallpaper(service.wallpaper);

                      if (mounted) Navigator.pop(context);
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
                        service.wallpaper = ImageResource(
                          type: ImageResourceType.network,
                          value: _controller.text,
                        );
                        service.addRecentWallpaper(service.wallpaper);
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
