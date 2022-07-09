import 'dart:async';

import 'package:pangolin/services/service.dart';

abstract class ErrorService extends Service<ErrorService> {
  ErrorService() : super("ErrorService");

  static ErrorService build() {
    return _ErrorServiceImpl();
  }

  factory ErrorService.fallback() = _FallbackErrorServiceImpl;

  @override
  FutureOr<void> stop() {
    // noop
  }

  void printRuntimeType();
}

class _ErrorServiceImpl extends ErrorService {
  @override
  void printRuntimeType() {
    // noop
  }

  @override
  FutureOr<void> start() {
    throw Exception("expected");
  }
}

class _FallbackErrorServiceImpl extends ErrorService {
  @override
  void printRuntimeType() {
    print(runtimeType);
  }

  @override
  FutureOr<void> start() {
    print("started fallback");
  }
}
