import 'dart:async';

Future<T?> callAsNullable<T>(FutureOr<T> Function() method) async {
  try {
    final value = await method();
    return value;
  } catch (e) {
    return null;
  }
}

T? callAsNullableSync<T>(T Function() method) {
  try {
    final value = method();
    return value;
  } catch (e) {
    return null;
  }
}
