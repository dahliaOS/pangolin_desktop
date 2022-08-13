import 'dart:async';

import 'package:pangolin/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService extends Service<PreferencesService> {
  PreferencesService();

  static PreferencesService get current {
    return ServiceManager.getService<PreferencesService>()!;
  }

  static PreferencesService build() {
    return _SharedPrefPreferencesServiceImpl();
  }

  factory PreferencesService.fallback() = _InMemoryPreferencesServiceImpl;

  T? get<T>(String key, [T? defaultValue]);

  FutureOr<void> set<T>(String key, T value);

  FutureOr<void> delete(String key);
  FutureOr<void> clear();
}

class _SharedPrefPreferencesServiceImpl extends PreferencesService {
  SharedPreferences? _sharedPreferences;

  @override
  Future<void> delete(String key) async {
    await _sharedPreferences?.remove(key);
  }

  @override
  T? get<T>(String key, [T? defaultValue]) {
    // This is an hack used to switch the type T without getting a value
    final List<T> switchVal = <T>[];

    if (switchVal is List<int>) {
      return _sharedPreferences?.getInt(key) as T?;
    }

    if (switchVal is List<double>) {
      return _sharedPreferences?.getDouble(key) as T?;
    }

    if (switchVal is List<bool>) {
      return _sharedPreferences?.getBool(key) as T?;
    }

    if (switchVal is List<String>) {
      return _sharedPreferences?.getString(key) as T?;
    }

    if (switchVal is List<List<String>>) {
      return _sharedPreferences?.getStringList(key) as T?;
    }

    logger.warning(
      "(preference $key) Unsupported type $T for PreferencesService, returning null",
    );

    return null;
  }

  @override
  Future<void> set<T>(String key, T value) async {
    if (value is int) {
      _sharedPreferences?.setInt(key, value);
    }

    if (value is double) {
      _sharedPreferences?.setDouble(key, value);
    }

    if (value is bool) {
      _sharedPreferences?.setBool(key, value);
    }

    if (value is String) {
      _sharedPreferences?.setString(key, value);
    }

    if (value is List<String>) {
      _sharedPreferences?.setStringList(key, value);
    }
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences?.clear();
  }

  @override
  FutureOr<void> start() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  FutureOr<void> stop() async {
    _sharedPreferences = null;
  }
}

class _InMemoryPreferencesServiceImpl extends PreferencesService {
  final Map<String, dynamic> _prefs = {};

  @override
  void delete(String key) {
    _prefs.remove(key);
  }

  @override
  T? get<T>(String key, [T? defaultValue]) {
    return _prefs[key] as T? ?? defaultValue;
  }

  @override
  void set<T>(String key, T value) {
    _prefs[key] = value;
  }

  @override
  void clear() {
    _prefs.clear();
  }

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

class MissingEntryException implements Exception {
  final String key;

  const MissingEntryException(this.key);

  @override
  String toString() {
    return 'The preference $key is not present inside the preferences store';
  }
}
