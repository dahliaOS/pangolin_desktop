import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class ClockProvider extends ChangeNotifier {
  static ClockProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<ClockProvider>(context, listen: listen);

  ClockProvider() {
    _loadData();
  }

  // Initial Values
  bool _enable24hFormat = true;
  bool _enableSeconds = true;
  bool _enableAutoTime = true;

  // Getters

  bool get enable24hFormat => _enable24hFormat;
  bool get enableSeconds => _enableSeconds;
  bool get enableAutoTime => _enableAutoTime;

  // Setters
  set enable24hFormat(bool value) {
    _enable24hFormat = value;
    notifyListeners();
    PreferencesService.running.set("clock_24hFormat", value);
  }

  set enableSeconds(bool value) {
    _enableSeconds = value;
    notifyListeners();
    PreferencesService.running.set("clock_seconds", value);
  }

  set enableAutoTime(bool value) {
    _enableAutoTime = value;
    notifyListeners();
    PreferencesService.running.set("clock_autoTime", value);
  }

  void _loadData() {
    enable24hFormat =
        PreferencesService.running.get("clock_24hFormat") ?? _enable24hFormat;
    enableSeconds =
        PreferencesService.running.get("clock_seconds") ?? _enableSeconds;
    enableAutoTime =
        PreferencesService.running.get("clock_autoTime") ?? _enableAutoTime;
  }
}
