import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class MiscProvider extends ChangeNotifier {
  static MiscProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<MiscProvider>(context, listen: listen);

  MiscProvider() {
    _loadData();
  }

  // Initial Values
  bool enableBlueLightFilter = false;
  bool enableDeveloperOptions = false;
  bool _compactLauncher = false;
  List<String> _minimizedWindowsCache = [];

  String keyboardLayout = 'en_US';

  bool get compactLauncher => _compactLauncher;

  List<String> get minimizedWindowsCache => _minimizedWindowsCache;

  set compactLauncher(bool value) {
    _compactLauncher = value;
    notifyListeners();
    PreferencesService.current.set("compactLauncher", value);
  }

  set minimizedWindowsCache(List<String> value) {
    _minimizedWindowsCache = value;
    notifyListeners();
  }

  //TODO fix data loading
  void _loadData() {
    _compactLauncher =
        PreferencesService.current.get("compactLauncher") ?? _compactLauncher;
  }
}
