import 'dart:async';

Future<T?> callAsNullable<T>(FutureOr<T> Function() method) async {
  try {
    final T value = await method();
    return value;
  } catch (e) {
    return null;
  }
}

T? callAsNullableSync<T>(T Function() method) {
  try {
    final T value = method();
    return value;
  } catch (e) {
    return null;
  }
}
