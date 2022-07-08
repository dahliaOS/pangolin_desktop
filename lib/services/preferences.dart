import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pangolin/services/service.dart';

abstract class PreferencesService extends Service<PreferencesService> {
  const PreferencesService() : super("preferences");

  static PreferencesService get running {
    return ServiceManager.getService<PreferencesService>();
  }

  static PreferencesService build() {
    return _HivePreferencesServiceImpl();
  }

  T? get<T>(String key, [T? defaultValue]);

  FutureOr<void> set<T>(String key, T value);
  FutureOr<void> addIfNotPresent<T>(String key, T value);

  FutureOr<void> delete(String key);

  @override
  PreferencesService get fallbackService => _InMemoryPreferencesServiceImpl();
}

class _HivePreferencesServiceImpl extends PreferencesService {
  late Box _hivedb;

  @override
  Future<void> addIfNotPresent<T>(String key, T value) {
    if (_hivedb.containsKey(key)) return Future.value();

    return set<T>(key, value);
  }

  @override
  Future<void> delete(String key) {
    return _hivedb.delete(key);
  }

  @override
  T? get<T>(String key, [T? defaultValue]) {
    return _hivedb.get(key, defaultValue: defaultValue) as T?;
  }

  @override
  Future<void> set<T>(String key, T value) {
    return _hivedb.put(key, value);
  }

  @override
  FutureOr<void> start() async {
    await Hive.initFlutter();
    _hivedb = await Hive.openBox('settings');
  }

  @override
  FutureOr<void> stop() async {
    await _hivedb.close();
  }
}

class _InMemoryPreferencesServiceImpl extends PreferencesService {
  final Map<String, dynamic> _prefs = {};

  @override
  void addIfNotPresent<T>(String key, T value) {
    if (_prefs.containsKey(key)) return;

    set<T>(key, value);
  }

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
