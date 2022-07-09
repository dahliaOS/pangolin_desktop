import 'dart:async';

import 'package:pangolin/utils/other/log.dart';

abstract class Service<T extends Service<T>> {
  final String name;

  Service(this.name);

  bool _running = false;
  bool get running => _running;

  FutureOr<void> start();
  FutureOr<void> stop();

  @override
  String toString() {
    return "$name, ${running ? "running" : "not running"}";
  }
}

typedef ServiceBuilder<T extends Service<T>> = FutureOr<T> Function();

class ServiceManager with LoggerProvider {
  final Map<Type, Service> _registeredServices = {};
  static final ServiceManager _instance = ServiceManager._();

  ServiceManager._();

  static Future<void> registerService<T extends Service<T>>(
    ServiceBuilder<T> builder, {
    T? fallback,
  }) =>
      _instance._registerService<T>(builder, fallback);

  static Future<void> unregisterService<T extends Service<T>>() =>
      _instance._unregisterService<T>();

  static T? getService<T extends Service<T>>() => _instance._getService<T>();

  Future<void> _registerService<T extends Service<T>>(
    ServiceBuilder<T> builder, [
    T? fallback,
  ]) async {
    final T? service = await _startWithFallback<T>(await builder(), fallback);

    if (service == null) return;

    _registeredServices[T] = service;
  }

  Future<T?> _startWithFallback<T extends Service<T>>(
    final T service,
    final T? fallback,
  ) async {
    try {
      await service.start();
      service._running = true;

      return service;
    } catch (exception, stackTrace) {
      if (fallback == null) {
        logger.severe(
          "The service ${service.name} failed to start",
          exception,
          stackTrace,
        );
        return null;
      }

      return _startWithFallback(fallback, null);
    }
  }

  Future<void> _unregisterService<T extends Service<T>>() async {
    final Service? service = _registeredServices.remove(T);
    await service?.stop();
    service?._running = false;
  }

  T? _getService<T extends Service<T>>() {
    final T? service = _registeredServices[T] as T?;

    if (service == null) return null;

    if (!service.running) {
      throw ServiceNotRunningException<T>(service);
    }

    return service;
  }
}

class ServiceNotRunningException<T extends Service<T>> implements Exception {
  final T service;

  const ServiceNotRunningException(this.service);

  @override
  String toString() {
    return 'The service ${service.name} is currently not running.\n'
        'This is probably caused by an exception thrown while starting, consider adding a fallback service to avoid these situations.';
  }
}
