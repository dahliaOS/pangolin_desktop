import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:logging/logging.dart';
import 'package:pangolin/utils/other/benchmark.dart';
import 'package:pangolin/widgets/resource/icon/cache.dart';
import 'package:path/path.dart' as p;
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

typedef _IconCache = Map<String, _CachedIconSet>;
typedef _ComputationResult<T> = (int, T);

typedef _CacheKey = ({
  int? size,
  int? minSize,
  int? maxSize,
  int? threshold,
  IconThemeDirectoryType? type,
});

typedef _IconFolder = ({String path, List<IconTheme> themes});

class IconServiceFactory extends ServiceFactory<IconService> {
  const IconServiceFactory();

  @override
  IconService build() {
    if (!Platform.isLinux) return _StraightThroughIconServiceImpl();

    return _LinuxIconService();
  }

  @override
  IconService? fallback() => _StraightThroughIconServiceImpl();
}

abstract class IconService extends ListenableService {
  IconService();

  static IconService get current {
    return ServiceManager.getService<IconService>()!;
  }

  String? lookup(String name, {int? size, String? fallback});
  Future<String?> lookupFromDirectory(
    String directory,
    String name, {
    String? fallback,
  });
}

class _LinuxIconService extends IconService {
  static final RegExp extRegexp = RegExp(r"(\.png|\.svg(z)?|\.xpm)^");
  final GSettings settings = GSettings("org.gnome.desktop.interface");

  final List<_IconFolder> iconFolders = [];
  final _IconCache cache = {};
  final List<StreamSubscription<FileSystemEvent>> dirWatchers = [];

  String? systemTheme;
  Timer? settingPollingTimer;

  @override
  String? lookup(String name, {int? size, String? fallback}) {
    if (name.isEmpty && (fallback == null || fallback.isEmpty)) return null;

    // Some icons get requested like <name>.<ext>, in order to solve this we just remove the extension
    final String fixedName = name.replaceFirst(extRegexp, "");
    final String? fixedFallback = fallback?.replaceFirst(extRegexp, "");

    final Benchmark benchmark = Benchmark();
    benchmark.begin();

    final _CachedIconSet? mainSet = cache[fixedName];
    final _CachedIconSet? fallbackSet = cache[fixedFallback];

    if (mainSet == null) {
      benchmark.end();

      logger.finest(
        "Nothing found for $fixedName, will return fallback $fixedFallback, took ${benchmark.duration.inMilliseconds}ms",
      );
      return fallbackSet?.lookup(size);
    }

    final String? lookupResult = mainSet.lookup(size);

    if (lookupResult != null) {
      benchmark.end();
      logger.finest(
        "Looked up icon $fixedName, took ${benchmark.duration.inMilliseconds}ms, result $lookupResult",
      );
      return lookupResult;
    }

    benchmark.end();

    logger.finest(
      "Nothing found for $fixedName, took ${benchmark.duration.inMilliseconds}ms",
    );
    return null;
  }

  @override
  Future<String?> lookupFromDirectory(
    String directory,
    String name, {
    String? fallback,
  }) async {
    if (FileSystemEntity.typeSync(directory) !=
        FileSystemEntityType.directory) {
      return null;
    }

    final Directory dir = Directory(directory);
    final List<FileSystemEntity> entities = await dir.list().toList();

    final File? file = entities.firstWhereOrNull((e) {
      if (e is! File) return false;

      final String fileName = p.basenameWithoutExtension(e.path);

      if (fileName != name) return false;

      return true;
    }) as File?;

    return file?.path ?? (fallback != null ? lookup(fallback) : null);
  }

  @override
  FutureOr<void> start() async {
    settingPollingTimer =
        Timer.periodic(const Duration(seconds: 1), _pollForSetting);

    systemTheme = await _getCurrentTheme();

    final Benchmark b = Benchmark()..begin();
    final _OrdererCompleterGroup<_IconFolder> group =
        _OrdererCompleterGroup(xdg.dataDirs.length + 1);

    int i = 0;
    group.run(
      callback: () => _populateFor(p.join(xdg.dataHome.path, "icons")),
      index: i,
      useIsolate: true,
    );

    for (final Directory dir in xdg.dataDirs) {
      group.run(
        callback: () => _populateFor(p.join(dir.path, "icons")),
        index: ++i,
        useIsolate: true,
      );
    }
    final List<_IconFolder> results = await group.waitForCompletion();
    b.end();
    logger.finest(
      "Parsing every icon folder took ${b.duration.inMilliseconds}ms",
    );

    for (final folder in results) {
      dirWatchers.add(
        Directory(folder.path).watch(recursive: true).listen(_directoryWatcher),
      );
      iconFolders.add(folder);
    }

    await _loadThemes(systemTheme);
  }

  static Future<_IconFolder?> _populateFor(String path) async {
    final logger = Logger("_LinuxIconService");
    final Directory directory = Directory(path);
    final List<FileSystemEntity> entities;

    if (!directory.existsSync()) return null;

    try {
      entities = await directory.list(recursive: true).toList();
    } catch (e) {
      logger.warning("Exception while listing icons for $path", e);
      return null;
    }
    entities.removeWhere((e) => e is! Directory);

    final List<IconTheme> foundIconThemes = [];
    final Benchmark benchmark = Benchmark();

    benchmark.begin();
    final _OrdererCompleterGroup<IconTheme> group =
        _OrdererCompleterGroup(entities.length);

    int i = 0;
    for (final FileSystemEntity entity in entities) {
      group.run(
        callback: () => _loadDirectory(entity.path, logger),
        index: i++,
      );
    }

    final results = await group.waitForCompletion();
    foundIconThemes.addAll(results);

    benchmark.end();
    logger.finest(
      "Loaded themes for $path, took ${benchmark.duration.inMilliseconds}ms",
    );

    return (path: path, themes: foundIconThemes);
  }

  static Future<IconTheme?> _loadDirectory(String path, Logger logger) async {
    final List<FileSystemEntity> children =
        await Directory(path).list().toList();
    children.removeWhere((e) => e is! File);

    bool hasThemeFile = false;
    bool hasCacheFile = false;
    File? cacheFile;

    for (final File child in children.cast<File>()) {
      final String ext = p.extension(child.path);
      if (ext != ".theme") {
        if (ext == ".cache") {
          hasCacheFile = true;
          cacheFile = child;
        }
        continue;
      }

      hasThemeFile = true;

      final String content = await child.readAsString();
      try {
        final IconTheme entry = IconTheme.fromIni(child.parent.path, content);

        final List<String> directoryNames = List.of(entry.directoryNames);
        final List<IconThemeDirectory> directories = List.of(entry.directories);

        directories.removeWhere((e) {
          final bool exists =
              Directory(p.join(entry.path, e.name)).existsSync();

          if (!exists) {
            directoryNames.remove(e.name);
          }

          return !exists;
        });

        return entry.copyWith(
          directoryNames: directoryNames,
          directories: directories,
        );
      } catch (error) {
        logger.warning("Failed to parse icon theme for ${child.path}", error);
      }
    }

    if (!hasThemeFile && hasCacheFile && cacheFile != null) {
      // Chances are this is one of these dumb fuck themes that has a cache but
      // doesn't have an icon theme file (the unfortunate case of the .local hicolor theme).
      // For such "people" we have to use this weird ass mechanism, oh well

      final String path = cacheFile.parent.path;
      final IconCache? cache = await IconCache.create(path);

      if (cache == null) return null;

      final List<IconThemeDirectory?> directories =
          cache.directories.map(_buildDirFromName).toList();
      directories.removeWhere((e) => e == null);

      return IconTheme(
        path: path,
        name: LocalizedString(p.basenameWithoutExtension(path)),
        comment: const LocalizedString("Generated by IconService"),
        directoryNames: cache.directories,
        directories: directories.cast<IconThemeDirectory>(),
      );
    }

    return null;
  }

  static IconThemeDirectory? _buildDirFromName(String name) {
    final RegExp nameRegex =
        RegExp("(?<sizeA>[0-9]+)x(?<sizeB>[0-9]+)(@(?<scale>[0-9]+))?");
    final RegExpMatch? match = nameRegex.firstMatch(name);

    if (match == null) return null;

    final String? sizeA = match.namedGroup("sizeA");
    final String? sizeB = match.namedGroup("sizeB");

    if (sizeA == null || sizeB == null) return null;
    if (sizeA != sizeB) return null;

    final int? size = int.tryParse(sizeA);

    if (size == null) return null;

    final String? scaleStr = match.namedGroup("scale");
    int? scale;

    if (scaleStr != null) {
      scale = int.tryParse(scaleStr);
    }

    return IconThemeDirectory(name: name, size: size, scale: scale);
  }

  Future<void> _directoryWatcher(FileSystemEvent event) async {
    switch (event.type) {
      case FileSystemEvent.create:
      case FileSystemEvent.delete:
      case FileSystemEvent.move:
        _loadThemes();
    }
  }

  // Here we load the specified theme from the available theme folders and every children
  // it possibly has (basically we build the inheritance tree and then we flatten it,
  // removing duplicate entries and setting the proper priority).
  // Before anything tho, we load the icons from pixmaps as they have the lowest priority.
  // Icon loading works by reverse priority, lowest get written before. As we traverse the hierarchy
  // tree from bottom to top, we override low priority entries with the ones that sit on top.
  Future<void> _loadThemes([String? name]) async {
    cache.clear();
    final String resolvedName = name ?? systemTheme ?? "hicolor";

    final Benchmark benchmark = Benchmark();
    final List<FileSystemEntity> entities =
        await Directory("/usr/share/pixmaps").list(recursive: true).toList();
    for (final FileSystemEntity entity in entities) {
      if (entity is! File) continue;

      const _CacheKey key = (
        maxSize: null,
        minSize: null,
        size: null,
        threshold: null,
        type: null,
      );
      final String iconName = p.basenameWithoutExtension(entity.path);
      cache[iconName] ??= _CachedIconSet({key: entity.path});
    }

    for (final _IconFolder folder in iconFolders.reversed) {
      benchmark.begin();
      final IconTheme? rootTheme =
          folder.themes.firstWhereOrNull((e) => e.name.main == resolvedName);

      if (rootTheme == null) {
        final _IconCache? themeCache = await _loadTheme("hicolor", folder);

        if (themeCache == null) continue;

        cache.addAll(themeCache);
        benchmark.end();
        logger.finest(
          "Loaded theme $resolvedName (default), took ${benchmark.duration.inMilliseconds}ms",
        );
        continue;
      }

      final List<String> inheritances = _getInheritances(folder, rootTheme);
      final List<String> cleanInheritances = _cleanInheritances(inheritances);

      if (cleanInheritances.isEmpty) cleanInheritances.add("hicolor");

      for (final String inheritance in cleanInheritances.reversed) {
        final _IconCache? themeCache = await _loadTheme(inheritance, folder);

        if (themeCache == null) continue;

        cache.addAll(themeCache);
      }

      benchmark.end();
      logger.finest(
        "Loaded theme $resolvedName, took ${benchmark.duration.inMilliseconds}ms,",
      );
    }
  }

  Future<_IconCache?> _loadTheme(
    String name,
    _IconFolder folder,
  ) async {
    final IconTheme? iconTheme = folder.themes.firstWhereOrNull(
      (e) => e.name.main.toLowerCase() == name.toLowerCase(),
    );

    if (iconTheme == null) return null;

    final List<IconThemeDirectory> dirs = List.of(iconTheme.directories);
    dirs.sort((a, b) => b.size.compareTo(a.size));

    final List<FileSystemEntity> items =
        await Directory(iconTheme.path).list(recursive: true).toList();

    final Map<String, Map<_CacheKey, String>> iconCache = {};
    for (final FileSystemEntity item in items) {
      if (item is! File) continue;
      final IconThemeDirectory? dir =
          dirs.firstWhereOrNull((e) => item.path.contains(e.name));

      if (dir == null) continue;

      final String name = p.basenameWithoutExtension(item.path);
      iconCache[name] ??= {};

      final _CacheKey key = (
        size: dir.size,
        minSize: dir.minSize,
        maxSize: dir.maxSize,
        threshold: dir.threshold,
        type: dir.type,
      );
      iconCache[name]![key] = item.path;
    }

    return _IconCache.fromIterables(
      iconCache.keys,
      iconCache.values.map((e) => _CachedIconSet(_sortCache(e))),
    );
  }

  Map<_CacheKey, String> _sortCache(Map<_CacheKey, String> orig) {
    final List<MapEntry<_CacheKey, String>> entries = orig.entries.toList();
    entries.sort(
      (a, b) => b.key.nullSafeSize.compareTo(a.key.nullSafeSize),
    );

    return Map.fromEntries(entries);
  }

  List<String> _getInheritances(_IconFolder folder, IconTheme theme) {
    final List<String> results = [];

    results.addAll(theme.inherits ?? []);
    for (final String inheritance in theme.inherits ?? []) {
      final IconTheme? inheritedTheme =
          folder.themes.firstWhereOrNull((e) => e.name.main == inheritance);

      if (inheritedTheme == null) continue;

      results.addAll(_getInheritances(folder, inheritedTheme));
    }

    return results;
  }

  List<String> _cleanInheritances(List<String> source) {
    final List<String> result = [];

    for (final String inheritance in source.reversed) {
      if (result.contains(inheritance)) continue;

      result.add(inheritance);
    }

    return result.reversed.toList();
  }

  Future<String> _getCurrentTheme() async =>
      (await settings.get("icon-theme") as DBusString).value;

  Future<void> _pollForSetting(Timer timer) async {
    final String currentTheme = await _getCurrentTheme();

    if (systemTheme != currentTheme) {
      systemTheme = currentTheme;
      await _loadThemes(systemTheme);
      notifyListeners();
    }
  }

  @override
  FutureOr<void> stop() async {
    cache.clear();
    iconFolders.clear();
    settingPollingTimer?.cancel();
    for (final StreamSubscription<FileSystemEvent> sub in dirWatchers) {
      await sub.cancel();
    }
    dirWatchers.clear();
    //await settings.close();
  }
}

class _StraightThroughIconServiceImpl extends IconService {
  @override
  String? lookup(String name, {int? size, String? fallback}) => name;

  @override
  Future<String?> lookupFromDirectory(
    String directory,
    String name, {
    String? fallback,
  }) async =>
      name;

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

class _CachedIconSet {
  final Map<_CacheKey, String> icons;

  const _CachedIconSet(this.icons);

  String? lookup(int? size) {
    for (final MapEntry<_CacheKey, String> item in icons.entries) {
      final _CacheKey key = item.key;
      final String path = item.value;

      if (size != null && !_sizeMatches(size, key)) continue;

      return path;
    }

    return icons.values.first;
  }

  bool _sizeMatches(int size, _CacheKey key) {
    // This is the case for pixmaps as they match any size because we don't have anything else
    if (key.size == null) return true;

    switch (key.type) {
      case IconThemeDirectoryType.scalable:
        final int minSize = key.minSize ?? key.size!;
        final int maxSize = key.maxSize ?? key.size!;
        return size >= minSize && size <= maxSize;
      case IconThemeDirectoryType.threshold:
        final int threshold = key.threshold ?? 2;
        return size < key.size! * threshold;
      case IconThemeDirectoryType.fixed:
      default:
        return key.size == size;
    }
  }
}

class _OrdererCompleterGroup<T> {
  final CompleterGroup<int, _ComputationResult<T?>> _group;

  _OrdererCompleterGroup(int length)
      : _group = CompleterGroup(List.generate(length, (i) => i));

  Future<void> run({
    required int index,
    required Future<T?> Function() callback,
    bool useIsolate = false,
  }) async {
    final result =
        await (useIsolate ? Isolate.run(() => callback()) : callback());
    _group.complete(index, (index, result));
  }

  Future<List<T>> waitForCompletion() async {
    final List<_ComputationResult<T?>> results =
        await _group.waitForCompletion();
    results.removeWhere((e) => e.$2 == null);
    results.sort((a, b) => a.$1.compareTo(b.$1));

    return results.map((e) => e.$2!).toList().cast<T>();
  }
}

extension on _CacheKey {
  int get nullSafeSize => size ?? 0;
}
