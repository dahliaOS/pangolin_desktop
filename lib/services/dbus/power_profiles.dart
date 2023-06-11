import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:pangolin/services/dbus/objects/remote/power_profiles.dart';

class PowerProfilesClient {
  final DBusClient _bus;

  late final HadessPowerProfiles _root;
  late final List<PowerProfile> _profiles;
  late ValueNotifier<PowerProfile> _activeProfile;

  Timer? _pollingActiveProfileTimer;

  PowerProfilesClient({DBusClient? bus}) : _bus = bus ?? DBusClient.system() {
    _root = HadessPowerProfiles(
      _bus,
      "net.hadess.PowerProfiles",
      DBusObjectPath("/net/hadess/PowerProfiles"),
    );
  }

  Future<void> connect() async {
    final profile = PowerProfile.fromDbusName(await _root.getActiveProfile());
    _activeProfile = ValueNotifier(profile);
    _pollingActiveProfileTimer =
        Timer.periodic(const Duration(milliseconds: 200), _pollActiveProfile);
    _profiles = (await _root.getProfiles())
        .map((e) => PowerProfile.fromDbusName(e["Profile"]!.asString()))
        .toList();
  }

  Future<void> dispose() async {
    _pollingActiveProfileTimer?.cancel();
  }

  Future<void> _pollActiveProfile(Timer timer) async {
    final currentProfile =
        PowerProfile.fromDbusName(await _root.getActiveProfile());

    if (currentProfile != _activeProfile.value) {
      _activeProfile.value = currentProfile;
    }
  }

  Future<void> setActiveProfile(PowerProfile profile) async {
    try {
      await _root.setActiveProfile(profile.dbusName);
      _activeProfile.value = profile;
    } catch (e) {
      rethrow;
    }
  }

  List<PowerProfile> get profiles => List.of(_profiles);
  ValueNotifier<PowerProfile> get activeProfile => _activeProfile;
}

enum PowerProfile {
  powerSaver("power-saver"),
  balanced("balanced"),
  performance("performance");

  final String dbusName;

  const PowerProfile(this.dbusName);

  factory PowerProfile.fromDbusName(String dbusName) {
    return values.firstWhere((e) => e.dbusName == dbusName);
  }
}
