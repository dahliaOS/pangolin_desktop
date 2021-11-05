import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/clock_provider.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:pangolin/utils/providers/icon_provider.dart';
import 'package:pangolin/utils/providers/io_provider.dart';
import 'package:pangolin/utils/providers/misc_provider.dart';

class ProviderManager {
  late BuildContext context;
  bool listen = true;

  late IOProvider ioProvider;
  late IconProvider iconProvider;
  late CustomizationProvider customizationProvider;
  late ClockProvider clockProvider;
  late MiscProvider miscProvider;

  ProviderManager.of(this.context, {this.listen = true}) {
    this.ioProvider = IOProvider.of(context, listen: listen);
    this.iconProvider = IconProvider.of(context, listen: listen);
    this.customizationProvider =
        CustomizationProvider.of(context, listen: listen);
    this.clockProvider = ClockProvider.of(context, listen: listen);
    this.miscProvider = MiscProvider.of(context, listen: listen);
  }
}
