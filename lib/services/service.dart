import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pangolin/utils/other/log.dart';

abstract class Service<T extends Service<T>> with LoggerProvider {
  bool _running = false;
  bool get running => _running;

  FutureOr<void> start();
  FutureOr<void> stop();

  @override
  String toString() {
    return "$T, ${running ? "running" : "not running"}";
  }
}

abstract class ListenableService<T extends ListenableService<T>>
    extends Service<T> with ChangeNotifier {}

class FailedService extends Service<FailedService> {
  final Type service;

  FailedService._(this.service);

  @override
  FutureOr<void> start() => _error();

  @override
  FutureOr<void> stop() => _error();

  Never _error() {
    throw UnimplementedError(
      "Instances of FailedService exist only to signal that a service that was supposed to exist does not for some reason. Avoid calling any method on such instances.",
    );
  }

  @override
  String toString() {
    return "$service, failed";
  }
}

typedef ServiceBuilder<T extends Service<T>> = FutureOr<T> Function();

class ServiceManager with LoggerProvider {
  final Map<Type, _ServiceBuilderWithFallback> _awaitingForStartup = {};
  static final ServiceManager _instance = ServiceManager._();
  final Map<Type, Service<dynamic>> _registeredServices = {};

  ServiceManager._();

  static void registerService<T extends Service<T>>(
    ServiceBuilder<T> builder, {
    T? fallback,
  }) =>
      _instance._registerService<T>(builder, fallback);

  static Future<void> startServices() => _instance._startServices();

  static Future<void> stopServices() => _instance._stopServices();

  static Future<void> waitForService<T extends Service<T>>() =>
      _instance._waitForService<T>();

  static Future<void> unregisterService<T extends Service<T>>() =>
      _instance._unregisterService<T>();

  static T? getService<T extends Service<T>>() => _instance._getService<T>();

  void _registerService<T extends Service<T>>(
    ServiceBuilder<T> builder, [
    T? fallback,
  ]) {
    _awaitingForStartup[T] = _ServiceBuilderWithFallback<T>(builder, fallback);
  }

  Future<void> _waitForService<T extends Service<T>>() {
    return Future.value();
    /* final Completer<void>? completer = _completionTracker[T];

    if (completer == null) {
      throw Exception(
        "Can't wait for Service $T because it was not registered",
      );
    }

    return _completionTracker[T]!.future; */
  }

  Future<void> _startServices() async {
    for (final MapEntry<Type, _ServiceBuilderWithFallback> awaiting
        in _awaitingForStartup.entries) {
      logger.info("Starting service ${awaiting.key}");
      final Service<dynamic> service = await _startWithFallback(
        awaiting.key,
        awaiting.value.builder,
        awaiting.value.fallback,
      );
      logger.info("Started service ${awaiting.key}");
      _registeredServices[awaiting.key] = service;
    }
  }

  Future<void> _stopServices() async {
    for (final Type type in _registeredServices.keys) {
      await _unregisterServiceByType(type);
    }

    // Better safe than sorry
    _registeredServices.clear();
  }

  Future<Service<dynamic>> _startWithFallback(
    Type type,
    ServiceBuilder<Service<dynamic>> builder,
    Service<dynamic>? fallback,
  ) async {
    try {
      final Service<dynamic> service = await builder();
      await service.start();
      service._running = true;

      //_startupPool.completeComputation(type, service);
      return service;
    } catch (exception, stackTrace) {
      if (fallback == null) {
        logger.severe(
          "The service $type failed to start",
          exception,
          stackTrace,
        );

        //_startupPool.completeComputation(type, FailedService._(type));
        return FailedService._(type);
      }

      logger.warning(
        "The service $type failed to start",
        exception,
        stackTrace,
      );
      logger.info("Starting fallback service for $type");

      return _startWithFallback(type, () => fallback, null);
    }
  }

  Future<void> _unregisterService<T extends Service<T>>() =>
      _unregisterServiceByType(T);

  Future<void> _unregisterServiceByType(Type type) async {
    final Service<dynamic>? service = _registeredServices.remove(type);
    await service?.stop();
    service?._running = false;
  }

  T? _getService<T extends Service<T>>() {
    final Service<dynamic>? service = _registeredServices[T];

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

class _ServiceBuilderWithFallback<T extends Service<T>> {
  final ServiceBuilder<T> builder;
  final T? fallback;

  const _ServiceBuilderWithFallback(this.builder, this.fallback);
}
