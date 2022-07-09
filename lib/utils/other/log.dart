import 'package:logging/logging.dart';

mixin LoggerProvider {
  late final Logger logger = Logger(runtimeType.toString());
}
