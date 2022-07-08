import 'dart:async';

abstract class Service<T extends Service<T>> {
  final String name;

  const Service(this.name);

  FutureOr<void> start();
  FutureOr<void> stop();

  T? get fallbackService => null;
}

typedef ServiceBuilder<T extends Service<T>> = FutureOr<T> Function();

class ServiceManager {
  final Map<String, Service> _registeredServices = {};
  final Map<Type, String> _typeKeys = {};
  static final ServiceManager _instance = ServiceManager._();

  ServiceManager._();

  static Future<void> registerService<T extends Service<T>>(
    ServiceBuilder<T> builder,
  ) =>
      _instance._registerService<T>(builder);

  static void unregisterService<T extends Service<T>>() =>
      _instance._unregisterService<T>();

  static Future<void> startServices() => _instance._startServices();

  static Future<void> stopServices() => _instance._stopServices();

  static T getService<T extends Service<T>>() => _instance._getService<T>();

  static T? getOptionalService<T extends Service<T>>() =>
      _instance._getOptionalService<T>();

  Future<void> _registerService<T extends Service<T>>(
    ServiceBuilder<T> builder,
  ) async {
    final T service = await builder();

    _typeKeys[T] = service.name;
    _registeredServices[service.name] = service;
  }

  void _unregisterService<T extends Service<T>>() {
    _registeredServices.remove(T);
  }

  Future<void> _startServices() async {
    for (final Service service in _registeredServices.values) {
      try {
        await service.start();
      } catch (e) {
        if (service.fallbackService == null) {
          rethrow;
        }

        final Service fallback = service.fallbackService! as Service;
        _registeredServices[service.name] = fallback;

        await fallback.start();
      }
    }
  }

  Future<void> _stopServices() async {
    for (final Service service in _registeredServices.values) {
      await service.stop();
    }
  }

  T _getService<T extends Service<T>>() {
    return _registeredServices[_typeKeys[T]!]! as T;
  }

  T? _getOptionalService<T extends Service<T>>() {
    final String? nameKey = _typeKeys[T];
    if (nameKey == null) return null;

    return _registeredServices[nameKey] as T?;
  }
}
