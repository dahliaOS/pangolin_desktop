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

class IOProvider extends ChangeNotifier {
  static IOProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<IOProvider>(context, listen: listen);

  IOProvider() {
    _loadData();
  }

  // Initial Values

  double _volume = 0.5;
  double _brightness = 0.75;
  bool _isMuted = false;
  bool _isAutoBrightnessEnabled = true;

  // Getters

  double get volume => _volume;
  double get brightness => _brightness;
  bool get isMuted => _isMuted;
  bool get isAutoBrightnessEnabled => _isAutoBrightnessEnabled;

  // Setters / Methods

  set volume(double value) {
    _volume = value;
    DatabaseManager.set("volume", value);
    if (value > 0) DatabaseManager.set("alt_volume", value);
    notifyListeners();
  }

  set brightness(double value) {
    _brightness = value;
    DatabaseManager.set("brightness", value);
    if (value > 0) DatabaseManager.set("alt_brightness", value);
    notifyListeners();
  }

  set isMuted(bool value) {
    _isMuted = value;
    value == true ? volume = 0 : volume = DatabaseManager.get("alt_volume");
    notifyListeners();
  }

  set isAutoBrightnessEnabled(bool value) {
    _isAutoBrightnessEnabled = value;
    DatabaseManager.set("auto_brightness", value);
    notifyListeners();
  }

  // Data Loading

  void _loadData() {
    _volume = DatabaseManager.get("volume") ?? _volume;
    _brightness = DatabaseManager.get("brightness") ?? _volume;
    DatabaseManager.newEntry("alt_volume", volume);
    DatabaseManager.newEntry("alt_brightness", brightness);
  }
}
