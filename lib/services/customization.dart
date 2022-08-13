import 'dart:async';

import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/other/resource.dart';

abstract class CustomizationService
    extends ListenableService<CustomizationService> {
  CustomizationService();

  static CustomizationService get current {
    return ServiceManager.getService<CustomizationService>()!;
  }

  static CustomizationService build() => _CustomizationServiceImpl();

  int get databaseVersion;
  String get locale;
  bool get showWelcomeScreen;
  bool get darkMode;
  bool get enableEffects;
  List<String> get pinnedApps;
  List<ImageResource> get recentWallpapers;
  IconResource get launcherIcon;
  ColorResource get accentColor;
  String get fontFamily;
  ImageResource get wallpaper;
  bool get compactLauncher;
  double get volume;
  bool get muteVolume;
  double get brightness;
  bool get autoBrightness;
  bool get enableWifi;
  bool get enableBluetooth;
  bool get enableAirplaneMode;
  List<String> get recentSearchResults;

  set darkMode(bool? value);
  set locale(String? value);
  set showWelcomeScreen(bool? value);
  set enableEffects(bool? value);
  set pinnedApps(List<String>? value);
  set recentWallpapers(List<ImageResource>? value);
  set launcherIcon(IconResource value);
  set accentColor(ColorResource? value);
  set fontFamily(String? value);
  set wallpaper(ImageResource? value);
  set compactLauncher(bool? value);
  set volume(double? value);
  set muteVolume(bool? value);
  set brightness(double? value);
  set autoBrightness(bool? value);
  set enableWifi(bool? value);
  set enableBluetooth(bool? value);
  set enableAirplaneMode(bool? value);
  set recentSearchResults(List<String>? recentSearchResults);
}

class _CustomizationServiceImpl extends CustomizationService {
  /* ====== Getters ====== */
  @override
  int get databaseVersion => _get(Preference.databaseVersion);

  @override
  String get locale => _get(Preference.locale);

  @override
  bool get showWelcomeScreen => _get(Preference.showWelcomeScreen);

  @override
  bool get darkMode => _get(Preference.darkMode);

  @override
  bool get enableEffects => _get(Preference.enableEffects);

  @override
  List<String> get pinnedApps => _get(Preference.pinnedApps);

  @override
  List<ImageResource> get recentWallpapers =>
      _getAsResourceList<ImageResource>(Preference.recentWallpapers);

  @override
  IconResource get launcherIcon =>
      _getAsResource<IconResource>(Preference.launcherIcon);

  @override
  ColorResource get accentColor =>
      _getAsResource<ColorResource>(Preference.accentColor);

  @override
  String get fontFamily => _get(Preference.fontFamily);

  @override
  ImageResource get wallpaper =>
      _getAsResource<ImageResource>(Preference.wallpaper);

  @override
  bool get compactLauncher => _get(Preference.compactLauncher);

  @override
  double get volume => _get(Preference.volume);

  @override
  bool get muteVolume => _get(Preference.muteVolume);

  @override
  double get brightness => _get(Preference.brightness);

  @override
  bool get autoBrightness => _get(Preference.autoBrightness);

  @override
  bool get enableWifi => _get(Preference.enableWifi);

  @override
  bool get enableBluetooth => _get(Preference.enableBluetooth);

  @override
  bool get enableAirplaneMode => _get(Preference.enableAirplaneMode);

  @override
  List<String> get recentSearchResults => _get(Preference.recentSearchResults);

  /* ====== Setters ====== */
  @override
  set darkMode(bool? value) => _set(Preference.darkMode, value);

  @override
  set locale(String? value) => _set(Preference.locale, value);

  @override
  set showWelcomeScreen(bool? value) =>
      _set(Preference.showWelcomeScreen, value);

  @override
  set enableEffects(bool? value) => _set(Preference.enableEffects, value);

  @override
  set pinnedApps(List<String>? value) => _set(Preference.pinnedApps, value);

  @override
  set recentWallpapers(List<ImageResource>? value) => _set(
        Preference.recentWallpapers,
        value?.map((e) => e.toString()).toList(),
      );

  @override
  set launcherIcon(IconResource? value) =>
      _set(Preference.launcherIcon, value?.toString());

  @override
  set accentColor(ColorResource? value) =>
      _set(Preference.accentColor, value?.toString());

  @override
  set fontFamily(String? value) => _set(Preference.fontFamily, value);

  @override
  set wallpaper(ImageResource? value) =>
      _set(Preference.wallpaper, value?.toString());

  @override
  set compactLauncher(bool? value) => _set(Preference.compactLauncher, value);

  @override
  set volume(double? value) => _set(Preference.volume, value);

  @override
  set muteVolume(bool? value) => _set(Preference.muteVolume, value);

  @override
  set brightness(double? value) => _set(Preference.brightness, value);

  @override
  set autoBrightness(bool? value) => _set(Preference.autoBrightness, value);

  @override
  set enableWifi(bool? value) => _set(Preference.enableWifi, value);

  @override
  set enableBluetooth(bool? value) => _set(Preference.enableBluetooth, value);

  @override
  set enableAirplaneMode(bool? value) =>
      _set(Preference.enableAirplaneMode, value);

  @override
  set recentSearchResults(List<String>? value) =>
      _set(Preference.recentSearchResults, value);

  @override
  Future<void> start() async {
    logger.info("Will wait for preferences service to appear");
    await ServiceManager.waitForService<PreferencesService>();
    logger.info("Preference service is good to go");

    final int? rawDatabaseVersion =
        PreferencesService.current.get<int>(Preference.databaseVersion.key);

    if (rawDatabaseVersion == null || rawDatabaseVersion < 2) {
      PreferencesService.current.clear();
      _set(Preference.databaseVersion, 2);
    }
  }

  @override
  FutureOr<void> stop() {
    // noop
  }

  T _get<T>(Preference<T> pref) {
    return PreferencesService.current.get<T>(pref.key) ?? pref.defaultValue;
  }

  T _getAsResource<T extends Resource>(Preference<String> pref) {
    final String value = _get(pref);
    final Resource? pointer = Resource.tryParse(value);

    if (pointer == null || pointer is! T) {
      return Resource.parse(pref.defaultValue) as T;
    }

    return pointer;
  }

  List<T> _getAsResourceList<T extends Resource>(
    Preference<List<String>> pref,
  ) {
    final List<String> values = _get(pref);
    final List<T> resources = [];

    for (final String pref in values) {
      final Resource? res = Resource.tryParse(pref);

      if (res == null || res is! T) continue;

      resources.add(res);
    }

    return resources;
  }

  void _set<T>(Preference<T> pref, T? value) {
    if (value == null) {
      PreferencesService.current.delete(pref.key);
    } else {
      PreferencesService.current.set<T>(pref.key, value);
    }

    notifyListeners();
  }
}

enum Preference<T> {
  databaseVersion<int>("database_version", 2),
  locale<String>("locale", "en_US"),
  showWelcomeScreen<bool>("show_welcome_screen", true),
  darkMode<bool>("dark_mode", false),
  enableEffects<bool>("enable_effects", true),
  pinnedApps<List<String>>("pinned_apps", []),
  recentWallpapers<List<String>>("recent_wallpapers", []),
  launcherIcon<String>("launcher_icon", "icon:dahlia#launcher_1"),
  accentColor<String>("accent_color", "color:dahlia#orange"),
  fontFamily<String>("font_family", "Roboto"),
  wallpaper<String>("wallpaper", "image:dahlia#images/wallpapers/modern.png"),
  compactLauncher<bool>("compact_launcher", false),
  volume<double>("volume", 0.5),
  muteVolume<bool>("mute_volume", false),
  brightness<double>("brightness", 0.5),
  autoBrightness<bool>("auto_brightness", true),
  enableWifi<bool>("enable_wifi", true),
  enableBluetooth<bool>("enable_bluetooth", true),
  enableAirplaneMode<bool>("enable_airplane_mode", false),
  recentSearchResults<List<String>>("recent_search_results", []);

  final String key;
  final T defaultValue;

  const Preference(this.key, this.defaultValue);
}
