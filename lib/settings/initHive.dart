import '../main.dart';

class initHive {
  initializeHive() {
    if (Pangolin.settingsBox.get("languageName") == null) {
      Pangolin.settingsBox.put("languageName", "English - United States");
    }
  }
}
