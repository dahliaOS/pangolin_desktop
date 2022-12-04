import 'package:pangolin/utils/other/json.dart';

const wallpaperParser = JsonArray(
  type: JsonObjectWithTransformer(
    transformer: Wallpaper.parse,
    fields: [
      JsonObjectField(name: "name", type: JsonString()),
      JsonObjectField(name: "path", type: JsonString()),
      JsonObjectField(name: "sha", type: JsonString()),
      JsonObjectField(name: "size", type: JsonNumber()),
      JsonObjectField(name: "url", type: JsonString()),
      JsonObjectField(name: "html_url", type: JsonString()),
      JsonObjectField(name: "git_url", type: JsonString()),
      JsonObjectField(name: "download_url", type: JsonString()),
      JsonObjectField(name: "type", type: JsonString()),
      JsonObjectField(
        name: "_links",
        type: JsonObjectWithTransformer(
          transformer: Links.parse,
          fields: [
            JsonObjectField(name: "self", type: JsonString()),
            JsonObjectField(name: "git", type: JsonString()),
            JsonObjectField(name: "html", type: JsonString()),
          ],
        ),
      ),
    ],
  ),
);

class Wallpaper {
  Wallpaper({
    required this.name,
    required this.path,
    required this.sha,
    required this.size,
    required this.url,
    required this.htmlUrl,
    required this.gitUrl,
    required this.downloadUrl,
    required this.type,
    required this.links,
  });

  String name;
  String path;
  String sha;
  int size;
  String url;
  String htmlUrl;
  String gitUrl;
  String downloadUrl;
  String type;
  Links links;

  factory Wallpaper.parse(Map<String, dynamic> json) {
    return Wallpaper(
      name: json["name"] as String,
      path: json["path"] as String,
      sha: json["sha"] as String,
      size: json["size"] as int,
      url: json["url"] as String,
      htmlUrl: json["html_url"] as String,
      gitUrl: json["git_url"] as String,
      downloadUrl: json["download_url"] as String,
      type: json["type"] as String,
      links: json["_links"] as Links,
    );
  }
}

class Links {
  Links({
    required this.self,
    required this.git,
    required this.html,
  });

  String self;
  String git;
  String html;

  factory Links.parse(Map<String, dynamic> json) {
    return Links(
      self: json["self"] as String,
      git: json["git"] as String,
      html: json["html"] as String,
    );
  }
}
