import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/components/settings/data/presets.dart';
import 'package:pangolin/components/settings/widgets/accent_color_button.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/customization_provider.dart';
import 'package:provider/provider.dart';

class QsThemePage extends StatelessWidget {
  const QsThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QsTitlebar(
        title: "Theme Settings",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Consumer(
          builder: (context, CustomizationProvider provider, _) => Column(
            children: [
              SwitchListTile(
                hoverColor: Colors.transparent,
                secondary: Icon(Icons.brightness_6_rounded),
                title: Text("System Dark Mode"),
                value: provider.darkMode,
                onChanged: (value) => provider.darkMode = value,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  shrinkWrap: true,
                  children: SettingsPresets.accentColorPresets
                      .map((e) => AccentColorButton(model: e))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
