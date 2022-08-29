import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/window/window_surface.dart';
import 'package:pangolin/components/window/window_toolbar.dart';
import 'package:pangolin/services/langpacks.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/data/app_list.dart' as app_list;
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/wm/properties.dart';
import 'package:path/path.dart' as p;
import 'package:utopia_wm/wm.dart';
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

  FutureOr<void> startApp(String name);
  DesktopEntry? getApp(String name);
}

class _LinuxApplicationService extends ApplicationService {
  final Map<String, DesktopEntry> entries = {};
  final List<StreamSubscription<FileSystemEvent>> directoryWatchers = [];

  @override
  List<DesktopEntry> listApplications() => entries.values.toList();

  @override
  void startApp(String name) {
    final DesktopEntry? app = getApp(name);

    if (app == null) {
      logger.warning(
        "The specified app $name can't be opened as it doesn't exist",
      );
      return;
    }

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

  @override
  DesktopEntry? getApp(String name) => null;

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
      final DesktopEntry entry = DesktopEntry.fromIni(entity.path, content);
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
  final List<_BuiltinDesktopEntry> entries = [];
  final Map<DesktopEntry, Widget> builders = {};

  static const WindowEntry windowEntry = WindowEntry(
    features: [
      ResizeWindowFeature(),
      SurfaceWindowFeature(),
      FocusableWindowFeature(),
      ToolbarWindowFeature(),
    ],
    layoutInfo: FreeformLayoutInfo(
      position: Offset(32, 32),
      size: Size(1280, 720),
    ),
    properties: {
      ResizeWindowFeature.minSize: Size(480, 360),
      SurfaceWindowFeature.elevation: 4.0,
      SurfaceWindowFeature.shape: Constants.mediumShape,
      SurfaceWindowFeature.background: PangolinWindowSurface(),
      ToolbarWindowFeature.widget: PangolinWindowToolbar(
        barColor: Colors.transparent,
        textColor: Colors.black,
      ),
      ToolbarWindowFeature.size: 40.0,
    },
  );

  @override
  void start() {
    for (final Application app in app_list.applications) {
      if (!app.canBeOpened) continue;

      String exec = app.packageName;

      if (app.runtimeFlags.isNotEmpty) {
        exec += " ${app.runtimeFlags.join(" ")}";
      }

      final _BuiltinDesktopEntry entry = _BuiltinDesktopEntry(
        id: app.packageName,
        content: app.app,
        type: DesktopEntryType.application,
        name: LocalizedString(app.name),
        icon: LocalizedString("image:dahlia#icons/${app.iconName}.png"),
        exec: exec,
        version: app.version,
        categories: app.category != null ? [app.category!.name] : null,
      );

      entries.add(entry);

      builders[entry] = app.app;
    }
  }

  @override
  _BuiltinDesktopEntry? getApp(String name) =>
      entries.firstWhereOrNull((e) => e.id == name);

  @override
  List<_BuiltinDesktopEntry> listApplications() => entries;

  @override
  void startApp(String name) {
    final _BuiltinDesktopEntry? app = getApp(name);

    if (app == null) {
      logger.warning(
        "The specified app $name can't be opened as it doesn't exist",
      );
      return;
    }

    WindowManagerService.current.push(
      windowEntry.newInstance(
        content: app.content,
        overrideProperties: {
          WindowExtras.stableId: app.id,
          WindowEntry.title: app.name.main,
          WindowEntry.icon: app.icon != null
              ? AssetImage(
                  app.icon!.main.toResource().resolve().toString(),
                )
              : null,
        },
      ),
    );
  }

  @override
  void stop() {
    entries.clear();
    builders.clear();
  }
}

class _BuiltinDesktopEntry extends DesktopEntry {
  final Widget content;

  const _BuiltinDesktopEntry({
    required super.id,
    required this.content,
    required super.type,
    super.version,
    required super.name,
    super.icon,
    super.exec,
    super.categories,
  });
}
