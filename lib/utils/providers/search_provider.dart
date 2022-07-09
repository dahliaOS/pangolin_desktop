import 'package:pangolin/services/preferences.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  static SearchProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<SearchProvider>(context, listen: listen);

  SearchProvider() {
    loadData();
  }

  // Initial Values

  List<String> _recentSearchResults = List.from([]);
  String _searchQueryCache = '';

  // Getters

  List<String> get recentSearchResults => _recentSearchResults;
  String get searchQueryCache => _searchQueryCache;

  // Setters

  void addRecentSearchResult(String value) {
    _recentSearchResults.add(value);
    notifyListeners();
    PreferencesService.current.set("recentSearchResults", _recentSearchResults);
  }

  set recentSearchResults(List<String> value) {
    _recentSearchResults = value;
    notifyListeners();
    PreferencesService.current.set("recentSearchResults", _recentSearchResults);
  }

  set searchQueryCache(String value) {
    _searchQueryCache = value;
    notifyListeners();
  }

  void loadData() {
    //recentSearchResults =
    // List.castFrom(PreferencesService.running.get("recentSearchResults"));
  }
}
