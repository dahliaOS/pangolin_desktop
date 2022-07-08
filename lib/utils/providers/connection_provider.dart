import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class ConnectionProvider extends ChangeNotifier {
  static ConnectionProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<ConnectionProvider>(context, listen: listen);

  ConnectionProvider() {
    loadData();
  }

  // Initial Values

  bool _wifi = true;
  bool _bluetooth = true;
  bool _mobile = true;
  bool _ethernet = true;

  // Getters
  bool get wifi => _wifi;
  bool get bluetooth => _bluetooth;
  bool get mobile => _mobile;
  bool get ethernet => _ethernet;

  // Setters

  set wifi(bool value) {
    _wifi = value;
    notifyListeners();
    PreferencesService.running.set("wifi", value);
  }

  set bluetooth(bool value) {
    _bluetooth = value;
    notifyListeners();
    PreferencesService.running.set("bluetooth", value);
  }

  set mobile(bool value) {
    _mobile = value;
    notifyListeners();
    PreferencesService.running.set("mobile", value);
  }

  set ethernet(bool value) {
    _ethernet = value;
    notifyListeners();
    PreferencesService.running.set("ethernet", value);
  }

  void loadData() {
    wifi = PreferencesService.running.get("wifi") ?? _wifi;
    bluetooth = PreferencesService.running.get("bluetooth") ?? _bluetooth;
    mobile = PreferencesService.running.get("mobile") ?? _mobile;
    ethernet = PreferencesService.running.get("ethernet") ?? _ethernet;
  }
}
