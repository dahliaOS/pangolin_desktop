import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class CustomizationProvider extends ChangeNotifier {
  static CustomizationProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<CustomizationProvider>(context, listen: listen);

  CustomizationProvider() {
    _loadData();
  }

  // Initial Values

  bool _darkMode = false;
  bool _centerTaskbar = true;
  bool _enableBlur = true;
  bool _coloredTitlebars = true;
  bool _transparentColoredTitlebars = false;

  List<String> _pinnedApps = List.from(
    [
      "io.dahlia.files",
      "io.dahlia.settings",
      "io.dahlia.terminal",
      "io.dahlia.calculator",
      "io.dahlia.store",
      "io.dahlia.media",
    ],
  );
  List<String> _recentWallpapers = List.from([]);

  double _taskbarPosition = 2;

  int _launcherIcon = Icons.apps.codePoint;
  int _accentColor = const Color(0xFFFF5722).value;

  String _fontFamily = "Roboto";
  String _wallpaper = "assets/images/wallpapers/modern.png";

  // Getter

  bool get darkMode => _darkMode;
  bool get centerTaskbar => _centerTaskbar;
  bool get enableBlur => _enableBlur;
  bool get coloredTitlebars => _coloredTitlebars;
  bool get transparentColoredTitlebars => _transparentColoredTitlebars;

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
    PreferencesService.running.set("darkMode", value);
  }

  set centerTaskbar(bool value) {
    _centerTaskbar = value;
    notifyListeners();
    PreferencesService.running.set("centerTaskbar", value);
  }

  set enableBlur(bool value) {
    _enableBlur = value;
    notifyListeners();
    PreferencesService.running.set("enableBlur", value);
  }

  set coloredTitlebars(bool value) {
    _coloredTitlebars = value;
    notifyListeners();
    PreferencesService.running.set("coloredTitlebars", value);
  }

  set transparentColoredTitlebars(bool value) {
    _transparentColoredTitlebars = value;
    notifyListeners();
    PreferencesService.running.set("transparentColoredTitlebars", value);
  }

  void togglePinnedApp(String packageName) {
    !_pinnedApps.contains(packageName)
        ? _pinnedApps.add(packageName)
        : _pinnedApps.remove(packageName);
    notifyListeners();
    PreferencesService.running.set("pinnedApps", _pinnedApps);
  }

  void addRecentWallpaper(String ref) {
    if (!_recentWallpapers.contains(ref)) {
      _recentWallpapers.add(ref);
      notifyListeners();
      PreferencesService.running.set("recentWallpapers", _recentWallpapers);
    }
  }

  set taskbarPosition(double value) {
    _taskbarPosition = value;
    notifyListeners();
    PreferencesService.running.set("taskbarPosition", value);
  }

  set launcherIcon(int value) {
    _launcherIcon = value;
    notifyListeners();
    PreferencesService.running.set("launcherIcon", value);
  }

  set accentColor(int value) {
    _accentColor = value;
    notifyListeners();
    PreferencesService.running.set("accentColor", value);
  }

  set fontFamily(String value) {
    _fontFamily = value;
    notifyListeners();
    PreferencesService.running.set("fontFamily", value);
  }

  set wallpaper(String value) {
    _wallpaper = value;
    notifyListeners();
    PreferencesService.running.set("wallpaper", value);
  }

  void _loadData() {
    darkMode = PreferencesService.running.get("darkMode") ?? _darkMode;
    centerTaskbar =
        PreferencesService.running.get("centerTaskbar") ?? _centerTaskbar;
    enableBlur = PreferencesService.running.get("enableBlur") ?? _enableBlur;
    coloredTitlebars =
        PreferencesService.running.get("coloredTitlebars") ?? _coloredTitlebars;
    transparentColoredTitlebars =
        PreferencesService.running.get("transparentColoredTitlebars") ??
            _transparentColoredTitlebars;

    _pinnedApps =
        List.from(PreferencesService.running.get("pinnedApps") ?? _pinnedApps);

    _recentWallpapers = List.from(
      PreferencesService.running.get("recentWallpapers") ?? _recentWallpapers,
    );

    taskbarPosition =
        PreferencesService.running.get("taskbarPosition") ?? _taskbarPosition;

    launcherIcon =
        PreferencesService.running.get("launcherIcon") ?? _launcherIcon;
    accentColor = PreferencesService.running.get("accentColor") ?? _accentColor;

    fontFamily = PreferencesService.running.get("fontFamily") ?? _fontFamily;
    wallpaper = PreferencesService.running.get("wallpaper") ?? _wallpaper;
  }
}
