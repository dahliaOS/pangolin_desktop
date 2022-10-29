import 'dart:async';
import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:dsettings/dsettings.dart';
import 'package:pangolin/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService
    extends ListenableService<PreferencesService> {
  PreferencesService();

  factory PreferencesService.fallback() = _SharedPrefPreferencesServiceImpl;

  static PreferencesService get current {
    return ServiceManager.getService<PreferencesService>()!;
  }

  static PreferencesService build() {
    if (Platform.isLinux) return _DSettingsPreferencesServiceImpl();

    return _SharedPrefPreferencesServiceImpl();
  }

  T? get<T>(String key, [T? defaultValue]);

  FutureOr<void> set<T>(String key, T value);

  FutureOr<void> delete(String key);
  FutureOr<void> clear();

  void setScheme(DSettingsTableScheme scheme) {}
}

class _DSettingsPreferencesServiceImpl extends PreferencesService {
  final Map<String, Object> _preferences = {};
  final DBusClient client = DBusClient.session();
  late final DSettings dsettings;
  late DSettingsTable table;

  final List<_DSettingsPendingWrite> _pendingWrites = [];
  final List<_DSettingsPendingDelete> _pendingDeletes = [];

  StreamSubscription<dynamic>? _writeSub;
  StreamSubscription<dynamic>? _deleteSub;
  StreamSubscription<dynamic>? _clearSub;

  Timer? _pendingWritesTimer;
  Timer? _pendingDeletesTimer;

  @override
  FutureOr<void> clear() {
    _preferences.clear();
    return table.clear();
  }

  @override
  void delete(String key) {
    _preferences.remove(key);

    _pendingDeletes.add(_DSettingsPendingDelete(setting: key));
    _pendingDeletesTimer = _rebuildTimer(_pendingDeletesTimer, _flushDeletes);
  }

  @override
  T? get<T>(String key, [T? defaultValue]) {
    final hack = <T>[];

    if (hack is List<List<String>>) {
      return (_preferences[key] as List?)?.cast<String>() as T? ?? defaultValue;
    }

    return _preferences[key] as T? ?? defaultValue;
  }

  @override
  void set<T>(String key, T value) {
    _preferences[key] = value as Object;

    _pendingWrites.add(
      _DSettingsPendingWrite(
        setting: key,
        value: value,
      ),
    );
    _pendingWritesTimer = _rebuildTimer(_pendingWritesTimer, _flushWrites);
  }

  @override
  Future<void> setScheme(DSettingsTableScheme scheme) =>
      table.setScheme(scheme);

  @override
  FutureOr<void> start() async {
    await client.requestName('io.dahlia.Pangolin');
    dsettings = DSettings(client: client);
    table = await _getOrCreateTable();

    final values = await table.readAll();

    values.forEach((key, value) {
      _preferences[key] = value.value as Object;
    });

    table
      ..addSettingsWrittenListener(_onSettingsWritten)
      ..addSettingsDeletedListener(_onSettingsDeleted)
      ..addSettingsClearedListener(_onSettingsCleared);
  }

  Future<DSettingsTable> _getOrCreateTable() async {
    final table = await dsettings.getTable('pangolin');

    if (table == null) {
      await dsettings.createTable('pangolin', owner: 'io.dahlia.Pangolin');
      return _getOrCreateTable();
    }

    return table;
  }

  void _onSettingsWritten(Map<String, DSettingsEntry<dynamic>> data) {
    data.forEach((key, value) {
      _preferences[key] = value.value as Object;
    });

    notifyListeners();
  }

  void _onSettingsDeleted(List<String> data) {
    data.forEach(_preferences.remove);
    notifyListeners();
  }

  void _onSettingsCleared() {
    _preferences.clear();
    notifyListeners();
  }

  @override
  Future<void> stop() async {
    await dsettings.client.close();
    await _writeSub?.cancel();
    await _deleteSub?.cancel();
    await _clearSub?.cancel();
  }

  Timer _rebuildTimer(Timer? timer, void Function() callback) {
    timer?.cancel();
    return Timer(const Duration(milliseconds: 100), callback);
  }

  void _flushWrites() {
    _flush<_DSettingsPendingWrite, Map<String, Object>>(
      _pendingWrites,
      table.writeBatch,
      (ops) => Map.fromIterables(
        ops.map((e) => e.setting),
        ops.map((e) => e.value),
      ),
    );

    _pendingWritesTimer?.cancel();
    _pendingWritesTimer = null;
  }

  void _flushDeletes() {
    _flush<_DSettingsPendingDelete, List<String>>(
      _pendingDeletes,
      table.deleteBatch,
      (ops) => ops.map((e) => e.setting).toList(),
    );

    _pendingDeletesTimer?.cancel();
    _pendingDeletesTimer = null;
  }

  Future<void> _flush<T extends _DSettingsPendingOperation<dynamic>, O>(
    List<T> operations,
    Future<void> Function(O param) callBatch,
    O Function(List<T> ops) transformer,
  ) {
    final confirmedOperations = List<T>.from(operations);
    operations.clear();

    return callBatch(transformer(confirmedOperations));
  }
}

abstract class _DSettingsPendingOperation<T> {
  const _DSettingsPendingOperation({
    required this.setting,
    required this.value,
    required this.type,
  });
  final String setting;
  final T value;
  final _DSettingsPendingOperationType type;
}

class _DSettingsPendingWrite extends _DSettingsPendingOperation<Object> {
  const _DSettingsPendingWrite({
    required super.setting,
    required super.value,
  }) : super(type: _DSettingsPendingOperationType.write);
}

class _DSettingsPendingDelete extends _DSettingsPendingOperation<Object?> {
  const _DSettingsPendingDelete({
    required super.setting,
  }) : super(
          value: null,
          type: _DSettingsPendingOperationType.delete,
        );
}

enum _DSettingsPendingOperationType {
  write,
  delete,
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
    final switchVal = <T>[];

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
      '(preference $key) Unsupported type $T for PreferencesService, returning null',
    );

    return null;
  }

  @override
  Future<void> set<T>(String key, T value) async {
    if (value is int) {
      await _sharedPreferences?.setInt(key, value);
    }

    if (value is double) {
      await _sharedPreferences?.setDouble(key, value);
    }

    if (value is bool) {
      await _sharedPreferences?.setBool(key, value);
    }

    if (value is String) {
      await _sharedPreferences?.setString(key, value);
    }

    if (value is List<String>) {
      await _sharedPreferences?.setStringList(key, value);
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

// Gonna keep for when i implement sequential fallbacks
// ignore: unused_element
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
  const MissingEntryException(this.key);
  final String key;

  @override
  String toString() {
    return 'The preference $key is not present inside the preferences store';
  }
}
