class PackageManifest {
  final bool enabled;
  final List<IndividualPackage> package;

  PackageManifest({required this.enabled, required this.package});

  factory PackageManifest.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['package'] as List;

    // print(list.runtimeType);
    List<IndividualPackage> packageList =
        list.map((i) => IndividualPackage.fromJson(i)).toList();

    return PackageManifest(
        enabled: parsedJson['enabled'], package: packageList);
  }
}

class IndividualPackage {
  final String id;
  final String altName;
  final String realName;
  final String version;
  final String description;
  final String url;
  final String iconURL;
  final String accentColor;
  final String backgroundColor;
  final String titleBarColor;
  final String themeMode;

  IndividualPackage({
    required this.id, //e.g. "com.google.android.apps.docs"
    required this.altName, //e.g. "gdocs"
    required this.realName, //e.g. "Google Docs"
    required this.version, //e.g. "webapp"
    required this.description, //e.g. "Google Docs is a free, open-source, and cross-platform document editor."
    required this.url, //e.g. "https://docs.google.com"
    required this.iconURL,
    required this.accentColor,
    required this.backgroundColor,
    required this.titleBarColor,
    required this.themeMode, //e.g. "https://www.gstatic.com/android/market_images/web/icons/gdocs-2x.png"
  });
  factory IndividualPackage.fromJson(Map<String, dynamic> parsedJson) {
    return IndividualPackage(
        id: parsedJson['id'],
        altName: parsedJson['altName'],
        realName: parsedJson['realName'],
        version: parsedJson['version'],
        description: parsedJson['description'],
        url: parsedJson['url'],
        iconURL: parsedJson['iconURL'],
        accentColor: parsedJson['accentColor'],
        backgroundColor: parsedJson['backgroundColor'],
        themeMode: parsedJson['themeMode'],
        titleBarColor: parsedJson['titleBarColor']);
  }
}
