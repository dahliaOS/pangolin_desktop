class PackageManifest {
  final bool enabled;
  final List<IndividualPackage> package;

  PackageManifest({required this.enabled, required this.package});

  factory PackageManifest.fromJson(Map<String, dynamic> parsedJson) {
    final List<dynamic> list = parsedJson['package']! as List<dynamic>;

    // print(list.runtimeType);
    final List<IndividualPackage> packageList = list
        .map((i) => IndividualPackage.fromJson(i as Map<String, dynamic>))
        .toList();

    return PackageManifest(
      enabled: parsedJson['enabled']! as bool,
      package: packageList,
    );
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

  const IndividualPackage({
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
      id: parsedJson['id']! as String,
      altName: parsedJson['altName']! as String,
      realName: parsedJson['realName']! as String,
      version: parsedJson['version']! as String,
      description: parsedJson['description']! as String,
      url: parsedJson['url']! as String,
      iconURL: parsedJson['iconURL']! as String,
      accentColor: parsedJson['accentColor']! as String,
      backgroundColor: parsedJson['backgroundColor']! as String,
      themeMode: parsedJson['themeMode']! as String,
      titleBarColor: parsedJson['titleBarColor']! as String,
    );
  }
}
