import 'package:pangolin/utils/wm/wm.dart';

class WindowExtras {
  static const WindowPropertyKey<String?> stableId =
      WindowPropertyKey("window.stableId", null, readonly: true);
}

class ExtraWindowProperties {
  final WindowPropertyRegistry _registry;

  const ExtraWindowProperties.mapFrom(this._registry);

  String get stableId => _registry.get(WindowExtras.stableId)!;

  set stableId(String value) => _registry.set(WindowExtras.stableId, value);
}

extension ExtraRegistryUtils on WindowPropertyRegistry {
  ExtraWindowProperties get extra => ExtraWindowProperties.mapFrom(this);
}
