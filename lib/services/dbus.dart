import 'dart:async';

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:dbus/dbus.dart';

mixin DBusService<T extends Service> on Service {
  DBusServiceBackend get backend;
  final DBusServer _server = DBusServer();

  DBusClient? _client;
  DBusClient? get client => _client;

  Set<DBusRequestNameFlag> get nameFlags => {};

  @override
  Future<void> start() async {
    if (await _registerClient(DBusClient.session())) {
      await onClientRegistered();
      return;
    }

    throw Exception(
      "Could not connect to a DBus instance, crashing the service to get fallback",
    );
  }

  @override
  Future<void> stop() async {
    await onClientUnregistering();
    await _unregisterClient(_client!);
    await _server.close();
    _client = null;
  }

  Future<bool> _registerClient(DBusClient client) async {
    try {
      await client.requestName(backend.interface, flags: nameFlags);
      await client.registerObject(backend);
      _client = client;
      return true;
    } catch (e) {
      logger.warning(
        "Could not register client $client for notification service, unregistering",
      );
      await _unregisterClient(client);
      _client = null;
      return false;
    }
  }

  Future<void> _unregisterClient(DBusClient client) async {
    if (backend.client != null) {
      await client.unregisterObject(backend);
    }
    await client.releaseName(backend.interface);
    await client.close();
    _client = null;
  }

  FutureOr<void> onClientRegistered() {}
  FutureOr<void> onClientUnregistering() {}
}

mixin DBusServiceBackend<T> on DBusObject {
  String get interface;
}
