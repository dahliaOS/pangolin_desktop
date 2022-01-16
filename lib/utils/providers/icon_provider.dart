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

import 'package:pangolin/utils/data/database_manager.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class IconProvider extends ChangeNotifier {
  static IconProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<IconProvider>(context, listen: listen);
  IconProvider() {
    _loadData();
  }

  // Initial Data

  String _iconPack = "material";

  // Getter

  String get iconPack => _iconPack;

  // Setter

  set iconPack(String value) {
    _iconPack = value.toLowerCase();
    notifyListeners();
    DatabaseManager.set("iconPack", value.toLowerCase());
  }

  // Data Loading

  void _loadData() {
    final List<String> _list = ["material", "fluent", "unicons"];
    if (!_list.contains(iconPack)) {
      iconPack = "material";
    }
    _iconPack = DatabaseManager.get("iconPack") ?? _iconPack;
  }
}
