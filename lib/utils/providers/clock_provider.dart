import 'package:pangolin/utils/data/database_manager.dart';
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
    DatabaseManager.set("clock_24hFormat", value);
  }

  set enableSeconds(bool value) {
    _enableSeconds = value;
    notifyListeners();
    DatabaseManager.set("clock_seconds", value);
  }

  set enableAutoTime(bool value) {
    _enableAutoTime = value;
    notifyListeners();
    DatabaseManager.set("clock_autoTime", value);
  }

  void _loadData() {
    enable24hFormat =
        DatabaseManager.get("clock_24hFormat") ?? _enable24hFormat;
    enableSeconds = DatabaseManager.get("clock_seconds") ?? _enableSeconds;
    enableAutoTime = DatabaseManager.get("clock_autoTime") ?? _enableAutoTime;
  }
}
