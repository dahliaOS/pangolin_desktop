import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/components/settings/widgets/accent_color_button.dart';
import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/widgets/services.dart';

class QsThemePage extends StatelessWidget
    with StatelessServiceListener<CustomizationService> {
  const QsThemePage({super.key});

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    return Scaffold(
      appBar: const QsTitlebar(
        title: "Theme Settings",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            SwitchListTile(
              hoverColor: Colors.transparent,
              secondary: const Icon(Icons.brightness_6_rounded),
              title: const Text("System Dark Mode"),
              value: service.darkMode,
              onChanged: (value) => service.darkMode = value,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                shrinkWrap: true,
                children: BuiltinColor.values
                    .map((e) => AccentColorButton(color: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
