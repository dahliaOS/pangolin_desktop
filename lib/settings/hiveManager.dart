import '../main.dart';

class HiveManager {
  initializeHive() {
    createEntryIfNotExisting("darkMode", false);
    createEntryIfNotExisting("centerTaskbar", false);
    createEntryIfNotExisting("languageName", "English - United States");
  }

  set(String key, dynamic value) {
    Pangolin.settingsBox.put(key, value);
  }

  get(String key) {
    return Pangolin.settingsBox.get(key);
  }
}

createEntryIfNotExisting(String key, dynamic value) {
  if (Pangolin.settingsBox.get(key) == null) {
    Pangolin.settingsBox.put(key, value);
  }
}
