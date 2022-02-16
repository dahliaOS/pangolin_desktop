// To parse this JSON data, do
//
//     final bingWallpaper = bingWallpaperFromJson(jsonString);

import 'dart:convert';

BingWallpaper bingWallpaperFromJson(String str) =>
    BingWallpaper.fromJson(json.decode(str) as Map<String, dynamic>);

String bingWallpaperToJson(BingWallpaper data) => json.encode(data.toJson());

class BingWallpaper {
  BingWallpaper({
    required this.images,
    required this.tooltips,
  });

  final List<Image> images;
  final Tooltips tooltips;

  factory BingWallpaper.fromJson(Map<String, dynamic> json) => BingWallpaper(
        images: List<Image>.from(
          (json["images"] as List<dynamic>).map(
            (x) => Image.fromJson(
              x as Map<String, dynamic>,
            ),
          ),
        ),
        tooltips: Tooltips.fromJson(json["tooltips"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "tooltips": tooltips.toJson(),
      };
}

class Image {
  Image({
    required this.startdate,
    required this.fullstartdate,
    required this.enddate,
    required this.url,
    required this.urlbase,
    required this.copyright,
    required this.copyrightlink,
    required this.title,
    required this.quiz,
    required this.wp,
    required this.hsh,
    required this.drk,
    required this.top,
    required this.bot,
    required this.hs,
  });

  final String startdate;
  final String fullstartdate;
  final String enddate;
  final String url;
  final String urlbase;
  final String copyright;
  final String copyrightlink;
  final String title;
  final String quiz;
  final bool wp;
  final String hsh;
  final int drk;
  final int top;
  final int bot;
  final List<dynamic> hs;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        startdate: json["startdate"]! as String,
        fullstartdate: json["fullstartdate"]! as String,
        enddate: json["enddate"]! as String,
        url: json["url"]! as String,
        urlbase: json["urlbase"]! as String,
        copyright: json["copyright"]! as String,
        copyrightlink: json["copyrightlink"]! as String,
        title: json["title"]! as String,
        quiz: json["quiz"]! as String,
        wp: json["wp"]! as bool,
        hsh: json["hsh"]! as String,
        drk: json["drk"]! as int,
        top: json["top"]! as int,
        bot: json["bot"]! as int,
        hs: json["hs"]! as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        "startdate": startdate,
        "fullstartdate": fullstartdate,
        "enddate": enddate,
        "url": url,
        "urlbase": urlbase,
        "copyright": copyright,
        "copyrightlink": copyrightlink,
        "title": title,
        "quiz": quiz,
        "wp": wp,
        "hsh": hsh,
        "drk": drk,
        "top": top,
        "bot": bot,
        "hs": List<dynamic>.from(hs.map((x) => x)),
      };
}

class Tooltips {
  Tooltips({
    required this.loading,
    required this.previous,
    required this.next,
    required this.walle,
    required this.walls,
  });

  final String loading;
  final String previous;
  final String next;
  final String walle;
  final String walls;

  factory Tooltips.fromJson(Map<String, dynamic> json) => Tooltips(
        loading: json["loading"]! as String,
        previous: json["previous"]! as String,
        next: json["next"]! as String,
        walle: json["walle"]! as String,
        walls: json["walls"]! as String,
      );

  Map<String, dynamic> toJson() => {
        "loading": loading,
        "previous": previous,
        "next": next,
        "walle": walle,
        "walls": walls,
      };
}
