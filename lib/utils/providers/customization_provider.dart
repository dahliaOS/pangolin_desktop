import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class CustomizationProvider extends ChangeNotifier {
  static CustomizationProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<CustomizationProvider>(context, listen: listen);

  CustomizationProvider() {
    _loadData();
  }

  // Initial Values

  bool _darkMode = true;
  bool _centerTaskbar = true;
  bool _enableBlur = true;

  List<String> _pinnedApps = List.from([
    "io.dahlia.calculator",
    "io.dahlia.terminal",
    "io.dahlia.settings",
    "io.dahlia.files"
  ], growable: true);
  List<String> _recentWallpapers = List.from([], growable: true);

  double _taskbarPosition = 2;

  int _launcherIcon = Icons.apps.codePoint;
  int _accentColor = Colors.deepOrangeAccent.value;

  String _fontFamily = "Inter";
  String _wallpaper = "assets/images/wallpapers/Three_Bubbles.png";

  // Getter

  bool get darkMode => _darkMode;
  bool get centerTaskbar => _centerTaskbar;
  bool get enableBlur => _enableBlur;

  List<String> get pinnedApps => _pinnedApps;
  List<String> get recentWallpapers => _recentWallpapers;

  double get taskbarPosition => _taskbarPosition;

  int get launcherIcon => _launcherIcon;
  int get accentColor => _accentColor;

  String get fontFamily => _fontFamily;
  String get wallpaper => _wallpaper;

  // Setters / Methods
  set darkMode(bool value) {
    _darkMode = value;
    notifyListeners();
    DatabaseManager.set("darkMode", value);
  }

  set centerTaskbar(bool value) {
    _centerTaskbar = value;
    notifyListeners();
    DatabaseManager.set("centerTaskbar", value);
  }

  set enableBlur(bool value) {
    _enableBlur = value;
    notifyListeners();
    DatabaseManager.set("enableBlur", value);
  }

  void togglePinnedApp(String packageName) {
    !_pinnedApps.contains(packageName)
        ? _pinnedApps.add(packageName)
        : _pinnedApps.remove(packageName);
    notifyListeners();
    DatabaseManager.set("pinnedApps", _pinnedApps);
  }

  void addRecentWallpaper(String ref) {
    if (!_recentWallpapers.contains(ref)) {
      _recentWallpapers.add(ref);
      notifyListeners();
      DatabaseManager.set("recentWallpapers", _recentWallpapers);
    }
  }

  set taskbarPosition(double value) {
    _taskbarPosition = value;
    notifyListeners();
    DatabaseManager.set("taskbarPosition", value);
  }

  set launcherIcon(int value) {
    _launcherIcon = value;
    notifyListeners();
    DatabaseManager.set("launcherIcon", value);
  }

  set accentColor(int value) {
    _accentColor = value;
    notifyListeners();
    DatabaseManager.set("accentColor", value);
  }

  set fontFamily(String value) {
    _fontFamily = value;
    notifyListeners();
    DatabaseManager.set("fontFamily", value);
  }

  set wallpaper(String value) {
    _wallpaper = value;
    notifyListeners();
    DatabaseManager.set("wallpaper", value);
  }

  void _loadData() {
    darkMode = DatabaseManager.get("darkMode") ?? _darkMode;
    centerTaskbar = DatabaseManager.get("centerTaskbar") ?? _centerTaskbar;
    enableBlur = DatabaseManager.get("enableBlur") ?? _enableBlur;

    _pinnedApps = List.from(DatabaseManager.get("pinnedApps") ?? _pinnedApps);
    _recentWallpapers =
        List.from(DatabaseManager.get("recentWallpapers") ?? _recentWallpapers);

    taskbarPosition =
        DatabaseManager.get("taskbarPosition") ?? _taskbarPosition;

    launcherIcon = DatabaseManager.get("launcherIcon") ?? _launcherIcon;
    accentColor = DatabaseManager.get("accentColor") ?? _accentColor;

    fontFamily = DatabaseManager.get("fontFamily") ?? _fontFamily;
    wallpaper = DatabaseManager.get("wallpaper") ?? _wallpaper;
  }
}
