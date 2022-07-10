import 'dart:async';

import 'package:pangolin/utils/other/log.dart';

abstract class Service<T extends Service<T>> {
  bool _running = false;
  bool get running => _running;

  FutureOr<void> start();
  FutureOr<void> stop();

  @override
  String toString() {
    return "$T, ${running ? "running" : "not running"}";
  }
}

class FailedService<T extends Service<T>> extends Service<T> {
  FailedService._();

  @override
  FutureOr<void> start() => _error();

  @override
  FutureOr<void> stop() => _error();

  Never _error() {
    throw UnimplementedError(
      "Instances of FailedService exist only to signal that a service that was supposed to exist is not for some reason. Avoid calling any method on such instances.",
    );
  }

  @override
  String toString() {
    return "$T, failed";
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
    final Service service = await _startWithFallback<T>(builder, fallback);

    _registeredServices[T] = service;
  }

  Future<Service> _startWithFallback<T extends Service<T>>(
    final ServiceBuilder<T> builder,
    final T? fallback,
  ) async {
    try {
      final T service = await builder();
      await service.start();
      service._running = true;

      return service;
    } catch (exception, stackTrace) {
      if (fallback == null) {
        logger.severe(
          "The service $T failed to start",
          exception,
          stackTrace,
        );
        return FailedService<T>._();
      }

      logger.info("Starting fallback service for $T");

      return _startWithFallback<T>(() => fallback, null);
    }
  }

  Future<void> _unregisterService<T extends Service<T>>() async {
    final Service? service = _registeredServices.remove(T);
    await service?.stop();
    service?._running = false;
  }

  T? _getService<T extends Service<T>>() {
    final Service? service = _registeredServices[T];

    if (service == null) return null;

    if (!service.running || service is FailedService) {
      throw ServiceNotRunningException<T>();
    }

    return service as T;
  }
}

class ServiceNotRunningException<T extends Service<T>> implements Exception {
  const ServiceNotRunningException();

  @override
  String toString() {
    return 'The service $T is currently not running.\n'
        'This is probably caused by an exception thrown while starting, consider adding a fallback service to avoid these situations.';
  }
}
