import 'package:pangolin/utils/wm/wm.dart';

extension ExtraWindowHierarchyController on WindowHierarchyController {
  void removeFromStableId(String stableId) {
    for (final LiveWindowEntry entry in entriesByFocus) {
      final String? entryStableId =
          entry.registry.maybeGet(WindowExtras.stableId);

      if (entryStableId != null && entryStableId == stableId) {
        removeWindowEntry(entry.registry.info.id);
      }
    }
  }
}
