import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:zenit_ui/zenit_ui.dart';

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
            ZenitSwitchListTile(
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
                    .map((e) => _AccentColorBox(e: e, service: service))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentColorBox extends StatelessWidget {
  const _AccentColorBox({
    required this.e,
    required this.service,
  });

  final BuiltinColor e;
  final CustomizationService service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () => service.accentColor =
              ColorResource(type: ColorResourceType.dahlia, value: e.name),
          borderRadius: BorderRadius.circular(8.0),
          child: ColoredBox(
            color: e.value,
          ),
        ),
      ),
    );
  }
}
