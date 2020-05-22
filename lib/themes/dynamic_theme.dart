import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

typedef ThemeDataWithBrightnessBuilder = ThemeData Function(
    Brightness brightness);

class DynamicTheme extends StatefulWidget {
  const DynamicTheme({
    Key key,
    this.data,
    this.themedWidgetBuilder,
    this.defaultBrightness = Brightness.light,
    this.loadBrightnessOnStart = true,
  }) : super(key: key);

  /// Builder that gets called when the brightness or theme changes
  final ThemedWidgetBuilder themedWidgetBuilder;

  /// Callback that returns the latest brightness
  final ThemeDataWithBrightnessBuilder data;

  /// The default brightness on start
  ///
  /// Defaults to `Brightness.light`
  final Brightness defaultBrightness;

  /// Whether or not to load the brightness on start
  ///
  /// Defaults to `true`
  final bool loadBrightnessOnStart;

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.findAncestorStateOfType<State<DynamicTheme>>();
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  ThemeData _themeData;

  Brightness _brightness;

  bool _shouldLoadBrightness;

  static const String _sharedPreferencesKey = 'isDark';

  /// Get the current `ThemeData`
  ThemeData get themeData => _themeData;

  /// Get the current `Brightness`
  Brightness get brightness => _brightness;

  @override
  void initState() {
    super.initState();
    _initVariables();
    _loadBrightness();
  }

  /// Loads the brightness depending on the `loadBrightnessOnStart` value
  Future<void> _loadBrightness() async {
    if (!_shouldLoadBrightness) {
      return;
    }
    final bool isDark = await _getBrightnessBool();
    _brightness = isDark ? Brightness.dark : Brightness.light;
    _themeData = widget.data(_brightness);
    if (mounted) {
      setState(() {});
    }
  }

  /// Initializes the variables
  void _initVariables() {
    _brightness = widget.defaultBrightness;
    _themeData = widget.data(_brightness);
    _shouldLoadBrightness = widget.loadBrightnessOnStart;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = widget.data(_brightness);
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _themeData = widget.data(_brightness);
  }

  /// Sets the new brightness
  /// Rebuilds the tree
  Future<void> setBrightness(Brightness brightness) async {
    // Update state with new values
    setState(() {
      _themeData = widget.data(brightness);
      _brightness = brightness;
    });
    // Save the brightness
    await _saveBrightness(brightness);
  }

  /// Toggles the brightness from dark to light
  Future<void> toggleBrightness() async {
    // If brightness is dark, set it to light
    // If it's not dark, set it to dark
    if (_brightness == Brightness.dark)
      await setBrightness(Brightness.light);
    else
      await setBrightness(Brightness.dark);
  }

  /// Changes the theme using the provided `ThemeData`
  void setThemeData(ThemeData data) {
    setState(() {
      _themeData = data;
    });
  }

  /// Saves the provided brightness in `SharedPreferences`
  Future<void> _saveBrightness(Brightness brightness) async {
    //! Shouldn't save the brightness if you don't want to load it
    if (!_shouldLoadBrightness) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Saves whether or not the provided brightness is dark
    await prefs.setBool(
        _sharedPreferencesKey, brightness == Brightness.dark ? true : false);
  }

  /// Returns a boolean that gives you the latest brightness
  Future<bool> _getBrightnessBool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Gets the bool stored in prefs
    // Or returns whether or not the `defaultBrightness` is dark
    return prefs.getBool(_sharedPreferencesKey) ??
        widget.defaultBrightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}
