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

import 'package:pangolin/services/preferences.dart';
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
    PreferencesService.running.set("volume", value);
    if (value > 0) PreferencesService.running.set("alt_volume", value);
    notifyListeners();
  }

  set brightness(double value) {
    _brightness = value;
    PreferencesService.running.set("brightness", value);
    if (value > 0) PreferencesService.running.set("alt_brightness", value);
    notifyListeners();
  }

  set isMuted(bool value) {
    _isMuted = value;
    if (value) {
      volume = 0;
    } else {
      volume = PreferencesService.running.get("alt_volume") ?? 0;
    }
    notifyListeners();
  }

  set isAutoBrightnessEnabled(bool value) {
    _isAutoBrightnessEnabled = value;
    PreferencesService.running.set("auto_brightness", value);
    notifyListeners();
  }

  // Data Loading

  void _loadData() {
    _volume = PreferencesService.running.get("volume") ?? _volume;
    _brightness = PreferencesService.running.get("brightness") ?? _volume;
    PreferencesService.running.addIfNotPresent("alt_volume", volume);
    PreferencesService.running.addIfNotPresent("alt_brightness", brightness);
  }
}
