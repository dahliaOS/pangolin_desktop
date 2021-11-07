import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  static SearchProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<SearchProvider>(context, listen: listen);

  SearchProvider() {
    loadData();
  }

  // Initial Values

  List<String> _recentSearchResults = List.from([], growable: true);

  // Getters

  List<String> get recentSearchResults => _recentSearchResults;

  // Setters

  void addRecentSearchResult(String value) {
    _recentSearchResults.add(value);
    notifyListeners();
    DatabaseManager.set("recentSearchResults", _recentSearchResults);
  }

  set recentSearchResults(List<String> value) {
    _recentSearchResults = value;
    notifyListeners();
    DatabaseManager.set("recentSearchResults", _recentSearchResults);
  }

  void loadData() {
    recentSearchResults =
        DatabaseManager.get("recentSearchResults") ?? _recentSearchResults;
  }
}
