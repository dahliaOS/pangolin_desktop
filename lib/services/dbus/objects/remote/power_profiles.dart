// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object lib/services/dbus/specifications/net.hadess.PowerProfiles.xml

import 'package:dbus/dbus.dart';

/// Signal data for net.hadess.PowerProfiles.ProfileReleased.
class HadessPowerProfilesProfileReleased extends DBusSignal {
  int get cookie => values[0].asUint32();

  HadessPowerProfilesProfileReleased(DBusSignal signal)
      : super(
          sender: signal.sender,
          path: signal.path,
          interface: signal.interface,
          name: signal.name,
          values: signal.values,
        );
}

class HadessPowerProfiles extends DBusRemoteObject {
  /// Stream of net.hadess.PowerProfiles.ProfileReleased signals.
  late final Stream<HadessPowerProfilesProfileReleased> profileReleased;

  HadessPowerProfiles(
    super.client,
    String destination,
    DBusObjectPath path,
  ) : super(name: destination, path: path) {
    profileReleased = DBusRemoteObjectSignalStream(
      object: this,
      interface: 'net.hadess.PowerProfiles',
      name: 'ProfileReleased',
      signature: DBusSignature('u'),
    )
        .asBroadcastStream()
        .map((signal) => HadessPowerProfilesProfileReleased(signal));
  }

  /// Gets net.hadess.PowerProfiles.ActiveProfile
  Future<String> getActiveProfile() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'ActiveProfile',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Sets net.hadess.PowerProfiles.ActiveProfile
  Future<void> setActiveProfile(String value) async {
    await setProperty(
      'net.hadess.PowerProfiles',
      'ActiveProfile',
      DBusString(value),
    );
  }

  /// Gets net.hadess.PowerProfiles.PerformanceInhibited
  Future<String> getPerformanceInhibited() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'PerformanceInhibited',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets net.hadess.PowerProfiles.PerformanceDegraded
  Future<String> getPerformanceDegraded() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'PerformanceDegraded',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets net.hadess.PowerProfiles.Profiles
  Future<List<Map<String, DBusValue>>> getProfiles() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'Profiles',
      signature: DBusSignature('aa{sv}'),
    );
    return value.asArray().map((child) => child.asStringVariantDict()).toList();
  }

  /// Gets net.hadess.PowerProfiles.Actions
  Future<List<String>> getActions() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'Actions',
      signature: DBusSignature('as'),
    );
    return value.asStringArray().toList();
  }

  /// Gets net.hadess.PowerProfiles.ActiveProfileHolds
  Future<List<Map<String, DBusValue>>> getActiveProfileHolds() async {
    final value = await getProperty(
      'net.hadess.PowerProfiles',
      'ActiveProfileHolds',
      signature: DBusSignature('aa{sv}'),
    );
    return value.asArray().map((child) => child.asStringVariantDict()).toList();
  }

  /// Invokes net.hadess.PowerProfiles.HoldProfile()
  Future<int> callHoldProfile(
    String profile,
    String reason,
    String applicationId, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    final result = await callMethod(
      'net.hadess.PowerProfiles',
      'HoldProfile',
      [DBusString(profile), DBusString(reason), DBusString(applicationId)],
      replySignature: DBusSignature('u'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues[0].asUint32();
  }

  /// Invokes net.hadess.PowerProfiles.ReleaseProfile()
  Future<void> callReleaseProfile(
    int cookie, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'net.hadess.PowerProfiles',
      'ReleaseProfile',
      [DBusUint32(cookie)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }
}
