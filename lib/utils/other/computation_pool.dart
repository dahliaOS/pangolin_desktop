import 'dart:async';

class ComputationPool<K, V> {
  final Map<K, Completer<V>> _results = {};

  void registerComputation(K key) {
    _results[key] = Completer<V>();
  }

  Future<V> waitFor(K key) {
    if (_results[key] == null) {
      throw Exception(
        "No computation registered for key $key, can't wait for anything",
      );
    }

    return _results[key]!.future;
  }

  void completeComputation(K key, V result) {
    if (_results[key] == null) {
      throw Exception(
        "No computation registered for key $key, nothing to complete",
      );
    }

    _results[key]!.complete(result);
  }

  Future<Map<K, V>> waitForResults([OnResultCallback<K, V>? callback]) async {
    final Map<K, V> results = {};

    for (final MapEntry<K, Completer<V>> computation in _results.entries) {
      final V value = await computation.value.future;
      callback?.call(computation.key, value);
      results[computation.key] = value;
    }

    return results;
  }

  void dispose() {
    _results.clear();
  }
}

typedef OnResultCallback<K, V> = void Function(K key, V value);
