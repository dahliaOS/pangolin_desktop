/*
Copyright 2019 The dahliaOS Authors

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

//credits: @HrX03 for API https://github.com/HrX03/Flux

import 'package:flutter/material.dart';
import 'package:xdg_directories/xdg_directories.dart';

class FolderProvider {
  List<MapEntry<String, IconData>> directories = [];

  FolderProvider() {
    final dirNames = getUserDirectoryNames();
    dirNames.forEach((element) {
      directories.add(
        MapEntry(
          getUserDirectory(element).path,
          icons[element],
        ),
      );
    });

    List<String> backDir = directories[0].key.split("/")..removeLast();
    directories.insert(
      0,
      MapEntry(
        backDir.join("/"),
        icons["HOME"],
      ),
    );
    //directories.sort((a, b) => a.key.compareTo(b.key));
  }
}

const Map<String, IconData> icons = {
  "HOME": Icons.home_filled,
  "DESKTOP": Icons.desktop_windows,
  "DOCUMENTS": Icons.note_outlined,
  "PICTURES": Icons.photo_library_outlined,
  "DOWNLOAD": Icons.file_download,
  "VIDEOS": Icons.videocam_outlined,
  "MUSIC": Icons.music_note_outlined,
  "PUBLICSHARE": Icons.public_outlined,
  "TEMPLATES": Icons.file_copy_outlined,
};
