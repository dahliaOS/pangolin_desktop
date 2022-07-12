import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/other/log.dart';
import 'package:pangolin/widgets/global/icon/cache.dart';
import 'package:path/path.dart' as p;
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

abstract class IconService extends Service<IconService> with ChangeNotifier {
  IconService();

  static IconService get current {
    return ServiceManager.getService<IconService>()!;
  }

  static IconService build() {
    if (!Platform.isLinux) return _StraightThroughIconServiceImpl();

    return _LinuxIconService();
  }

  factory IconService.fallback() = _StraightThroughIconServiceImpl;

  Future<String?> lookup(String name, [int? size]);
}

class _LinuxIconService extends IconService with LoggerProvider {
  final GSettings settings = GSettings("org.gnome.desktop.interface");

  final List<_IconFolder> iconFolders = [];
  final List<_LoadedIconBundle> loadedBundles = [];
  final List<File> pixmaps = [];
  final Map<String, _CachedIcon> cache = {};

  String? systemTheme;
  Timer? settingPollingTimer;

  @override
  Future<String?> lookup(String name, [int? size]) async {
    if (name.isEmpty) return null;

    final DateTime now = DateTime.now();
    final String key = "$name@$size";

    if (cache.containsKey(key)) {
      final _CachedIcon icon = cache[key]!;

      // We check if the cache is recent enough, else we need to lookup again
      if (now.difference(icon.date) < const Duration(seconds: 5)) {
        return icon.path;
      }
    }

    for (final _LoadedIconBundle bundle in loadedBundles) {
      String? lookup;

      for (final _LoadedIconTheme theme in bundle.themes) {
        lookup = await _themeLookup(name, theme, size);

        if (lookup != null) break;
      }

      if (lookup != null) {
        return cache
            .putIfAbsent(key, () => _CachedIcon(lookup!, DateTime.now()))
            .path;
      }
    }

    final File? file = pixmaps.firstWhereOrNull(
      (e) => p.basenameWithoutExtension(e.path) == name,
    );
    if (file != null) {
      return cache
          .putIfAbsent(
            key,
            () => _CachedIcon(file.absolute.path, DateTime.now()),
          )
          .path;
    }

    return null;
  }

  @override
  Future<void> start() async {
    settingPollingTimer =
        Timer.periodic(const Duration(milliseconds: 500), _pollForSetting);

    await _populateFor(p.join(xdg.dataHome.path, "icons"));
    for (final Directory dir in xdg.dataDirs) {
      await _populateFor(p.join(dir.path, "icons"));
    }
    await _populateFor("/usr/share/icons");

    final List<FileSystemEntity> entities =
        await Directory("/usr/share/pixmaps").list(recursive: true).toList();

    for (final FileSystemEntity entity in entities) {
      if (entity is! File) continue;

      pixmaps.add(entity);
    }

    systemTheme = await _getCurrentTheme();

    await _loadThemes(systemTheme!);
  }

  @override
  FutureOr<void> stop() {
    settingPollingTimer?.cancel();
  }

  Future<String?> _themeLookup(
    String name,
    _LoadedIconTheme theme, [
    int? size,
  ]) async {
    List<IconThemeDirectory>? directories;
    final List<String>? cacheDirectories = theme.cache?.lookup(name);

    if (cacheDirectories != null) {
      directories = [];

      for (final String dir in cacheDirectories) {
        final IconThemeDirectory? iconDir =
            theme.theme.directories.firstWhereOrNull(
          (e) => e.name == dir,
        );

        if (iconDir != null) directories.add(iconDir);
      }
    }

    if (directories == null || directories.isEmpty) {
      directories = theme.theme.directories;
    }

    for (final IconThemeDirectory dir in directories) {
      if (size != null && !_sizeMatches(size, dir)) continue;

      final Directory fsDir = Directory(p.join(theme.theme.path, dir.name));

      final List<FileSystemEntity> files;

      try {
        files = await fsDir.list().toList();
      } catch (e) {
        continue;
      }

      final File? file = files.firstWhereOrNull((e) {
        if (e is! File) return false;

        return p.basenameWithoutExtension(e.path) == name;
      }) as File?;

      if (file != null) {
        return file.absolute.path;
      }
    }

    return null;
  }

  bool _sizeMatches(int size, IconThemeDirectory dir) {
    switch (dir.type) {
      case IconThemeDirectoryType.scalable:
        final int minSize = dir.minSize ?? dir.size;
        final int maxSize = dir.maxSize ?? dir.size;
        return size >= minSize && size <= maxSize;
      case IconThemeDirectoryType.threshold:
        final int threshold = dir.threshold ?? 2;
        return size < dir.size * threshold;
      case IconThemeDirectoryType.fixed:
      default:
        return dir.size == size;
    }
  }

  Future<void> _populateFor(String path) async {
    final Directory directory = Directory(path);
    final List<FileSystemEntity> entities;

    try {
      entities = await directory.list(recursive: true).toList();
    } catch (e) {
      logger.warning("Exception while listing icons for $path", e);
      return;
    }

    final List<IconTheme> foundIconThemes = [];

    for (final FileSystemEntity entity in entities) {
      if (entity is! Directory) continue;

      final List<FileSystemEntity> children =
          await Directory(entity.path).list().toList();

      bool hasThemeFile = false;
      bool hasCacheFile = false;
      File? cacheFile;

      for (final FileSystemEntity child in children) {
        if (child is! File) continue;

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

          foundIconThemes.add(entry);
        } catch (error, stackTrace) {
          logger.warning(
            "Failed to parse icon theme for ${child.path}",
            error,
            stackTrace,
          );
        }
      }

      if (!hasThemeFile && hasCacheFile && cacheFile != null) {
        // Chances are this is one of these dumb fuck themes that has a cache but
        // doesn't have an icon theme file (the unfortunate case of the .local hicolor theme).
        // For such "people" we have to use this weird ass mechanism, oh well

        final String path = cacheFile.parent.path;
        final IconCache? cache = await IconCache.create(path);

        if (cache == null) continue;

        final List<IconThemeDirectory?> directories =
            cache.directories.map(_buildDirFromName).toList();
        directories.removeWhere((e) => e == null);

        foundIconThemes.add(
          IconTheme(
            path: path,
            name: LocalizedString(p.basenameWithoutExtension(path)),
            comment: const LocalizedString("Generated by IconService"),
            directoryNames: cache.directories,
            directories: directories.cast<IconThemeDirectory>(),
          ),
        );
      }
    }

    iconFolders.add(_IconFolder(path, foundIconThemes));
  }

  IconThemeDirectory? _buildDirFromName(String name) {
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

  Future<void> _loadThemes(String name) async {
    cache.clear();
    loadedBundles.clear();

    for (final _IconFolder folder in iconFolders) {
      final IconTheme? rootTheme =
          folder.themes.firstWhereOrNull((e) => e.name.main == name);

      if (rootTheme == null) {
        final _LoadedIconTheme? theme = await _loadTheme("hicolor", folder);

        if (theme == null) continue;

        loadedBundles.add(_LoadedIconBundle([theme]));
        continue;
      }

      final List<String> inheritances = _getInheritances(folder, rootTheme);
      final List<String> cleanInheritances = _cleanInheritances(inheritances);

      if (cleanInheritances.isEmpty) cleanInheritances.add("hicolor");

      final List<_LoadedIconTheme> themes = [];

      for (final String inheritance in cleanInheritances) {
        final _LoadedIconTheme? theme = await _loadTheme(inheritance, folder);

        if (theme == null) continue;

        themes.add(theme);
      }

      loadedBundles.add(_LoadedIconBundle(themes));
    }
  }

  Future<_LoadedIconTheme?> _loadTheme(String name, _IconFolder folder) async {
    final IconTheme? iconTheme = folder.themes.firstWhereOrNull(
      (e) => e.name.main.toLowerCase() == name.toLowerCase(),
    );

    if (iconTheme == null) return null;

    final IconCache? cache = await IconCache.create(iconTheme.path);

    final List<IconThemeDirectory> dirs = List.of(iconTheme.directories);
    dirs.sort((a, b) => b.size.compareTo(a.size));

    return _LoadedIconTheme(
      iconTheme.copyWith(directories: dirs),
      cache: cache,
    );
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
      await _loadThemes(systemTheme!);
      notifyListeners();
    }
  }
}

class _StraightThroughIconServiceImpl extends IconService {
  @override
  Future<String?> lookup(String name, [int? size]) => Future.value(name);

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

class _IconFolder {
  final String path;
  final List<IconTheme> themes;

  const _IconFolder(this.path, this.themes);
}

class _LoadedIconBundle {
  final List<_LoadedIconTheme> themes;

  const _LoadedIconBundle(this.themes);
}

class _LoadedIconTheme {
  final IconTheme theme;
  final IconCache? cache;

  const _LoadedIconTheme(
    this.theme, {
    this.cache,
  });
}

class _CachedIcon {
  final String path;
  final DateTime date;

  const _CachedIcon(this.path, this.date);
}
