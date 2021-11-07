import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class MiscProvider extends ChangeNotifier {
  static MiscProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<MiscProvider>(context, listen: listen);

  MiscProvider() {
    _loadData();
  }

  // Initial Values
  bool enableBlueLightFilter = false;
  bool enableDeveloperOptions = false;

  String keyboardLayout = 'en_US';

  //TODO fix data loading
  void _loadData() {}
}
