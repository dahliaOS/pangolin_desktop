import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/other/benchmark.dart';
import 'package:pangolin/widgets/global/resource/icon/cache.dart';
import 'package:path/path.dart' as p;
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

typedef _IconCache = Map<String, _CachedIconSet>;

abstract class IconService extends ListenableService<IconService> {
  IconService();

  factory IconService.fallback() = _StraightThroughIconServiceImpl;

  static IconService get current {
    return ServiceManager.getService<IconService>()!;
  }

  static IconService build() {
    if (!Platform.isLinux) return _StraightThroughIconServiceImpl();

    return _LinuxIconService();
  }

  String? lookup(String name, {int? size, String? fallback});
  Future<String?> lookupFromDirectory(
    String directory,
    String name, {
    String? fallback,
  });
}

class _LinuxIconService extends IconService {
  static final RegExp extRegexp = RegExp(r'(\.png|\.svg(z)?|\.xpm)^');
  final GSettings settings = GSettings('org.gnome.desktop.interface');

  final List<_IconFolder> iconFolders = [];
  final _IconCache cache = {};
  final List<StreamSubscription<FileSystemEvent>> dirWatchers = [];

  String? systemTheme;
  Timer? settingPollingTimer;

  @override
  String? lookup(String name, {int? size, String? fallback}) {
    if (name.isEmpty && (fallback == null || fallback.isEmpty)) return null;

    // Some icons get requested like <name>.<ext>, in order to solve this we just remove the extension
    final fixedName = name.replaceFirst(extRegexp, '');
    final fixedFallback = fallback?.replaceFirst(extRegexp, '');

    final benchmark = Benchmark()..begin();

    final mainSet = cache[fixedName];
    final fallbackSet = cache[fixedFallback];

    if (mainSet == null) {
      benchmark.end();

      logger.finest(
        'Nothing found for $fixedName, will return fallback $fixedFallback, took ${benchmark.duration.inMilliseconds}ms',
      );
      return fallbackSet?.lookup(size);
    }

    final lookupResult = mainSet.lookup(size);

    if (lookupResult != null) {
      benchmark.end();
      logger.finest(
        'Looked up icon $fixedName, took ${benchmark.duration.inMilliseconds}ms, result $lookupResult',
      );
      return lookupResult;
    }

    benchmark.end();

    logger.finest(
      'Nothing found for $fixedName, took ${benchmark.duration.inMilliseconds}ms',
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

    final dir = Directory(directory);
    final entities = await dir.list().toList();

    final file = entities.firstWhereOrNull((e) {
      if (e is! File) return false;

      final fileName = p.basenameWithoutExtension(e.path);

      if (fileName != name) return false;

      return true;
    }) as File?;

    return file?.path ?? (fallback != null ? lookup(fallback) : null);
  }

  @override
  FutureOr<void> start() async {
    settingPollingTimer =
        Timer.periodic(const Duration(seconds: 1), _pollForSetting);

    await _populateFor(p.join(xdg.dataHome.path, 'icons'));
    for (final dir in xdg.dataDirs) {
      await _populateFor(p.join(dir.path, 'icons'));
    }

    systemTheme = await _getCurrentTheme();

    await _loadThemes(systemTheme);
  }

  Future<void> _populateFor(String path) async {
    final directory = Directory(path);
    final List<FileSystemEntity> entities;

    if (!directory.existsSync()) return;

    try {
      entities = await directory.list(recursive: true).toList();
    } catch (e) {
      logger.warning('Exception while listing icons for $path', e);
      return;
    }

    final foundIconThemes = <IconTheme>[];
    final benchmark = Benchmark()..begin();

    for (final entity in entities) {
      if (entity is! Directory) continue;

      final children = await Directory(entity.path).list().toList();

      var hasThemeFile = false;
      var hasCacheFile = false;
      File? cacheFile;

      for (final child in children) {
        if (child is! File) continue;

        final ext = p.extension(child.path);
        if (ext != '.theme') {
          if (ext == '.cache') {
            hasCacheFile = true;
            cacheFile = child;
          }
          continue;
        }

        hasThemeFile = true;

        final content = await child.readAsString();
        try {
          final entry = IconTheme.fromIni(child.parent.path, content);

          final directoryNames = List<String>.of(entry.directoryNames);
          final directories = List<IconThemeDirectory>.of(entry.directories)
            ..removeWhere((e) {
              final exists = Directory(p.join(entry.path, e.name)).existsSync();

              if (!exists) {
                directoryNames.remove(e.name);
              }

              return !exists;
            });

          foundIconThemes.add(
            entry.copyWith(
              directoryNames: directoryNames,
              directories: directories,
            ),
          );
        } catch (error) {
          logger.warning('Failed to parse icon theme for ${child.path}', error);
        }
      }

      if (!hasThemeFile && hasCacheFile && cacheFile != null) {
        // Chances are this is one of these dumb fuck themes that has a cache but
        // doesn't have an icon theme file (the unfortunate case of the .local hicolor theme).
        // For such "people" we have to use this weird ass mechanism, oh well

        final path = cacheFile.parent.path;
        final cache = await IconCache.create(path);

        if (cache == null) continue;

        final directories = cache.directories.map(_buildDirFromName).toList()
          ..removeWhere((e) => e == null);

        foundIconThemes.add(
          IconTheme(
            path: path,
            name: LocalizedString(p.basenameWithoutExtension(path)),
            comment: const LocalizedString('Generated by IconService'),
            directoryNames: cache.directories,
            directories: directories.cast<IconThemeDirectory>(),
          ),
        );
      }
    }

    benchmark.end();
    logger.finest(
      'Loaded themes for $path, took ${benchmark.duration.inMilliseconds}ms',
    );
    dirWatchers.add(directory.watch(recursive: true).listen(_directoryWatcher));
    iconFolders.add(_IconFolder(path, foundIconThemes));
  }

  IconThemeDirectory? _buildDirFromName(String name) {
    final nameRegex =
        RegExp('(?<sizeA>[0-9]+)x(?<sizeB>[0-9]+)(@(?<scale>[0-9]+))?');
    final match = nameRegex.firstMatch(name);

    if (match == null) return null;

    final sizeA = match.namedGroup('sizeA');
    final sizeB = match.namedGroup('sizeB');

    if (sizeA == null || sizeB == null) return null;
    if (sizeA != sizeB) return null;

    final size = int.tryParse(sizeA);

    if (size == null) return null;

    final scaleStr = match.namedGroup('scale');
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
        await _loadThemes();
        break;
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
    final resolvedName = name ?? systemTheme ?? 'hicolor';

    final benchmark = Benchmark();
    final entities =
        await Directory('/usr/share/pixmaps').list(recursive: true).toList();
    for (final entity in entities) {
      if (entity is! File) continue;

      const key = _CacheKey();
      final iconName = p.basenameWithoutExtension(entity.path);
      cache[iconName] ??= _CachedIconSet({key: entity.path});
    }

    for (final folder in iconFolders.reversed) {
      benchmark.begin();
      final rootTheme =
          folder.themes.firstWhereOrNull((e) => e.name.main == resolvedName);

      if (rootTheme == null) {
        final themeCache = await _loadTheme('hicolor', folder);

        if (themeCache == null) continue;

        cache.addAll(themeCache);
        benchmark.end();
        logger.finest(
          'Loaded theme $resolvedName (default), took ${benchmark.duration.inMilliseconds}ms',
        );
        continue;
      }

      final inheritances = _getInheritances(folder, rootTheme);
      final cleanInheritances = _cleanInheritances(inheritances);

      if (cleanInheritances.isEmpty) cleanInheritances.add('hicolor');

      for (final inheritance in cleanInheritances.reversed) {
        final themeCache = await _loadTheme(inheritance, folder);

        if (themeCache == null) continue;

        cache.addAll(themeCache);
      }

      benchmark.end();
      logger.finest(
        'Loaded theme $resolvedName, took ${benchmark.duration.inMilliseconds}ms,',
      );
    }
  }

  Future<_IconCache?> _loadTheme(
    String name,
    _IconFolder folder,
  ) async {
    final iconTheme = folder.themes.firstWhereOrNull(
      (e) => e.name.main.toLowerCase() == name.toLowerCase(),
    );

    if (iconTheme == null) return null;

    final dirs = List<IconThemeDirectory>.of(iconTheme.directories)
      ..sort((a, b) => b.size.compareTo(a.size));

    final items =
        await Directory(iconTheme.path).list(recursive: true).toList();

    final iconCache = <String, Map<_CacheKey, String>>{};
    for (final item in items) {
      if (item is! File) continue;
      final dir = dirs.firstWhereOrNull((e) => item.path.contains(e.name));

      if (dir == null) continue;

      final name = p.basenameWithoutExtension(item.path);
      iconCache[name] ??= {};

      final key = _CacheKey(
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
    final entries = orig.entries.toList()
      ..sort(
        (a, b) => b.key.nullSafeSize.compareTo(a.key.nullSafeSize),
      );

    return Map.fromEntries(entries);
  }

  List<String> _getInheritances(_IconFolder folder, IconTheme theme) {
    final results = <String>[...?theme.inherits];
    for (final inheritance in theme.inherits ?? []) {
      final inheritedTheme =
          folder.themes.firstWhereOrNull((e) => e.name.main == inheritance);

      if (inheritedTheme == null) continue;

      results.addAll(_getInheritances(folder, inheritedTheme));
    }

    return results;
  }

  List<String> _cleanInheritances(List<String> source) {
    final result = <String>[];

    for (final inheritance in source.reversed) {
      if (result.contains(inheritance)) continue;

      result.add(inheritance);
    }

    return result.reversed.toList();
  }

  Future<String> _getCurrentTheme() async =>
      (await settings.get('icon-theme') as DBusString).value;

  Future<void> _pollForSetting(Timer timer) async {
    final currentTheme = await _getCurrentTheme();

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
    for (final sub in dirWatchers) {
      await sub.cancel();
    }
    dirWatchers.clear();
    await settings.close();
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
  const _CachedIconSet(this.icons);
  final Map<_CacheKey, String> icons;

  String? lookup(int? size) {
    for (final item in icons.entries) {
      final key = item.key;
      final path = item.value;

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
        final minSize = key.minSize ?? key.size!;
        final maxSize = key.maxSize ?? key.size!;
        return size >= minSize && size <= maxSize;
      case IconThemeDirectoryType.threshold:
        final threshold = key.threshold ?? 2;
        return size < key.size! * threshold;
      case IconThemeDirectoryType.fixed:
      default:
        return key.size == size;
    }
  }
}

class _CacheKey {
  const _CacheKey({
    this.size,
    this.minSize,
    this.maxSize,
    this.threshold,
    this.type,
  });
  final int? size;
  final int? minSize;
  final int? maxSize;
  final int? threshold;
  final IconThemeDirectoryType? type;
}

class _IconFolder {
  const _IconFolder(this.path, this.themes);
  final String path;
  final List<IconTheme> themes;
}

extension on _CacheKey {
  int get nullSafeSize => size ?? 0;
}
