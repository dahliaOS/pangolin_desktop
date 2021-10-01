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
import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/globals.dart';
import 'package:provider/provider.dart';

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
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    final _controller = TextEditingController();
    final _recentWallpapers =
        List.from(_data.recentWallpapers.reversed, growable: true);
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BoxSurface(
        borderRadius: BorderRadius.circular(8),
        margin: EdgeInsets.symmetric(horizontal: 300, vertical: 100),
        width: MediaQuery.of(context).size.width - 300,
        height: MediaQuery.of(context).size.height - 300,
        child: GestureDetector(
          onTap: () {},
          child: AlertDialog(
            insetPadding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: TabBar(
              enableFeedback: true,
              physics: BouncingScrollPhysics(),
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
              tabs: [
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
                physics: BouncingScrollPhysics(),
                controller: tabController,
                children: [
                  //
                  //Default Wallpapers
                  //
                  GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 16 / 9),
                    itemCount: wallpapers.length,
                    itemBuilder: (BuildContext context, int index) {
                      //_index = index;
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _data.wallpaper = wallpapers[index];
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    wallpapers[index].toString(),
                                    fit: BoxFit.cover,
                                    scale: 1.0,
                                  ),
                                ),
                                (_data.wallpaper == wallpapers[index])
                                    ? Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          foregroundColor: Colors.white,
                                          child: Icon(Icons.check),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ));
                    },
                  ),
                  //
                  //TODO Wallpapers Repository
                  //
                  Container(
                    color: Colors.green,
                    child: Center(child: Text("Coming Soon")),
                  ),
                  //
                  //Recent Wallpapers
                  //
                  GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _recentWallpapers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 16 / 9),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            mouseCursor: SystemMouseCursors.click,
                            onTap: () =>
                                _data.wallpaper = _recentWallpapers[index],
                            child: CachedNetworkImage(
                              errorWidget: (context, string, _) => Container(
                                color: Theme.of(context).colorScheme.secondary,
                                child: Center(
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
                      })
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
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        hintText: "Set wallpaper from URL",
                        labelText: "Wallpaper URL",
                      ),
                      maxLines: 1,
                      controller: _controller,
                      onSubmitted: (text) {
                        if (text.startsWith("http")) {
                          _data.wallpaper = text;
                          _data.addRecentWallpaper(text);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(
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
                      _data.wallpaper = 'https://bing.com' + bingresponse.images[0].url;
                      _data.addRecentWallpaper('https://bing.com' + bingresponse.images[0].url);
                      Navigator.pop(context);
                    },
                    label: Text(
                      "Use Bing Wallpaper",
                      style: TextStyle(
                        color: _data.darkMode
                            ? Color(0xff0a0a0a)
                            : Color(0xffffffff),
                      ),
                    ),
                    icon: Icon(
                      Icons.image_outlined,
                      color: _data.darkMode
                          ? Color(0xff0a0a0a)
                          : Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
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
                        _data.wallpaper = _controller.text;
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      "Save",
                      style: TextStyle(
                        color: _data.darkMode
                            ? Color(0xff0a0a0a)
                            : Color(0xffffffff),
                      ),
                    ),
                    icon: Icon(
                      Icons.save_outlined,
                      color: _data.darkMode
                          ? Color(0xff0a0a0a)
                          : Color(0xffffffff),
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
