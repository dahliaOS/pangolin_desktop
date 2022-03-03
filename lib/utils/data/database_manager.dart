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

import 'package:hive_flutter/hive_flutter.dart';

class DatabaseManager {
  const DatabaseManager();

  static late Box _hivedb;
  static Future<void> initialseDatabase() async {
    //final _dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    //Hive.init(_dir.path);
    _hivedb = await Hive.openBox('settings');

    //Default entries
    newEntry("windowBorderRadius", 12.0);
    newEntry("initialStart", true);

    //Fix old database entries
    if (DatabaseManager.get("wallpaper") != null &&
        double.tryParse(DatabaseManager.get("wallpaper")) != null) {
      DatabaseManager.set("wallpaper", "assets/images/wallpapers/modern.png");
    }
  }

  //get
  ///Get the Value of a Key
  static T get<T>(String key) => _hivedb.get(key) as T;

  //set
  ///Set the Value of a Key
  static Future<void> set(String key, dynamic value) => _hivedb.put(key, value);

  //new entry
  ///Checks if the Database already contains the entry and creates a new one if it doesn't
  static void newEntry(String key, dynamic value) {
    if (!_hivedb.containsKey(key)) {
      set(key, value);
    }
  }

  //get DatabaseEntry
  ///returns the Hive Box
  static Box? get getHiveBox => _hivedb;
}
