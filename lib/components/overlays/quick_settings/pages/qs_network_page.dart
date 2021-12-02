import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/services/network_manager.dart';

class QsNetworkPage extends StatelessWidget {
  const QsNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QsTitlebar(
        title: 'Network Settings',
      ),
      body: Center(
        child: ListView(
          children: parseNetworks(context),
        ),
      ),
    );
  }
}
