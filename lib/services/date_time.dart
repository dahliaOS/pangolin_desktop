import 'dart:async';

import 'package:intl/intl.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/services/service.dart';

abstract class DateTimeService extends ListenableService<DateTimeService> {
  DateTimeService();

  static DateTimeService get current {
    return ServiceManager.getService<DateTimeService>()!;
  }

  static DateTimeService build() => _DateTimeServiceImpl();

  DateTime get date;

  String get formattedDate;
  String get formattedTime;
}

class _DateTimeServiceImpl extends DateTimeService {
  CustomizationService get customization => CustomizationService.current;

  Timer? _timer;
  late DateTime _lastDate;

  @override
  DateTime get date => _lastDate;

  @override
  String get formattedDate => DateFormat("dd.MM.yyyy").format(date);

  @override
  String get formattedTime => DateFormat("Hms").format(date);

  @override
  Future<void> start() async {
    await ServiceManager.waitForService<CustomizationService>();

    _lastDate = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 200), _checkTime);

    CustomizationService.current.addListener(notifyListeners);
  }

  @override
  void stop() {
    _timer?.cancel();
    CustomizationService.current.removeListener(notifyListeners);
  }

  void _checkTime(Timer timer) {
    final DateTime now = DateTime.now();

    if (_lastDate.second == now.second) return;

    _lastDate = now;
    notifyListeners();
  }
}
