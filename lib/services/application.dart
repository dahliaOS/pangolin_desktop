import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:path/path.dart' as p;
import 'package:xdg_desktop/xdg_desktop.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg;

abstract class ApplicationService
    extends ListenableService<ApplicationService> {
  ApplicationService();

  static ApplicationService get current {
    return ServiceManager.getService<ApplicationService>()!;
  }

  static ApplicationService build() {
    if (!Platform.isLinux) return _BuiltInApplicationService();

    return _LinuxApplicationService();
  }

  factory ApplicationService.fallback() = _BuiltInApplicationService;

  List<DesktopEntry> listApplications();

  FutureOr<void> startApp(DesktopEntry app);
}

class _LinuxApplicationService extends ApplicationService {
  final Map<String, DesktopEntry> entries = {};
  final List<StreamSubscription<FileSystemEvent>> directoryWatchers = [];

  @override
  List<DesktopEntry> listApplications() => entries.values.toList();

  @override
  void startApp(DesktopEntry app) {
    final List<String> commandParts = app.exec!.split(" ");
    commandParts.removeWhere((e) => e.startsWith(RegExp("%[fuFU]")));

    Process.run(
      commandParts.first,
      commandParts.sublist(1),
      environment: {
        ...Platform.environment,
      },
    );
  }

  @override
  Future<void> start() async {
    await ServiceManager.waitForService<LangPacksService>();
    logger.info("Starting loading app service");

    _loadFolder(p.join(xdg.dataHome.path, "applications"));
    for (final Directory dir in xdg.dataDirs) {
      _loadFolder(p.join(dir.path, "applications"));
    }
    _loadFolder("/usr/share/applications");
  }

  Future<void> _loadFolder(String path) async {
    final Directory directory = Directory(path);
    final List<FileSystemEntity> entities;

    if (!directory.existsSync()) return;

    try {
      entities = await directory.list(recursive: true).toList();
    } catch (e) {
      logger.warning("Exception while listing applications for $path", e);
      return;
    }

    for (final FileSystemEntity entity in entities) {
      await _parseEntity(entity);
    }

    final Stream<FileSystemEvent> watcher = directory.watch();
    directoryWatchers.add(watcher.listen(_onDirectoryEvent));
  }

  Future<void> _parseEntity(FileSystemEntity entity) async {
    if (entity is! File) return;
    if (p.extension(entity.path) != ".desktop") return;

    final String content = await entity.readAsString();
    try {
      final DesktopEntry entry = DesktopEntry.fromIni(content);
      if (entry.noDisplay == true || entry.hidden == true) return;

      if (entry.tryExec != null && !File(entry.tryExec!).existsSync()) return;

      final List<String> onlyShowIn = entry.onlyShowIn ?? [];
      final List<String> notShowIn = entry.notShowIn ?? [];

      if (onlyShowIn.isNotEmpty && !onlyShowIn.contains("Pangolin") ||
          notShowIn.contains("Pangolin")) {
        return;
      }

      if (entry.domainKey != null) {
        LangPacksService.current.warmup(entry.domain!);
      }

      entries[entity.path] = entry;
      notifyListeners();
    } catch (e) {
      logger.warning("Failed to parse desktop entry at '${entity.path}'");
      return;
    }
  }

  Future<void> _onDirectoryEvent(FileSystemEvent event) async {
    if (event.isDirectory) return;

    switch (event.type) {
      case FileSystemEvent.delete:
        entries.remove(event.path);
        notifyListeners();
        break;
      case FileSystemEvent.create:
      case FileSystemEvent.modify:
        await _parseEntity(File(event.path));
        break;
    }
  }

  @override
  Future<void> stop() async {
    for (final StreamSubscription watcher in directoryWatchers) {
      await watcher.cancel();
    }
  }
}

class _BuiltInApplicationService extends ApplicationService {
  final List<DesktopEntry> entries = [];
  final Map<DesktopEntry, Widget> builders = {};

  @override
  void start() {
    for (final Application app in applications) {
      String exec = app.packageName;

      if (app.runtimeFlags.isNotEmpty) {
        exec += " ${app.runtimeFlags.join(" ")}";
      }

      final DesktopEntry entry = DesktopEntry(
        type: DesktopEntryType.application,
        name: LocalizedString(app.name),
        icon: LocalizedString("image:dahlia#icons/${app.iconName}.png"),
        exec: exec,
        categories: app.category != null ? [app.category!.name] : null,
      );

      entries.add(entry);

      builders[entry] = app.app;
    }
  }

  @override
  List<DesktopEntry> listApplications({bool sort = false}) => entries;

  @override
  void startApp(DesktopEntry app) {}

  @override
  void stop() {
    entries.clear();
    builders.clear();
  }
}
