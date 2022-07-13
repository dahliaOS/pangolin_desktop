class Benchmark {
  DateTime? _before;
  DateTime? _after;

  void begin() {
    _before = DateTime.now();
  }

  void end() {
    if (_before == null) {
      throw Exception("Should begin the benchmark before calling end()");
    }

    _after = DateTime.now();
  }

  Duration get duration {
    if (_before == null || _after == null) {
      throw Exception(
        "Should begin and end the benchmark before getting the duration",
      );
    }

    return _after!.difference(_before!);
  }
}
