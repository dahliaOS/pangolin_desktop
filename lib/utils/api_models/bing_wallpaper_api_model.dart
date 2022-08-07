import 'package:pangolin/utils/other/json.dart';

const bingParser = JsonObjectWithTransformer<BingImageOfTheDay>(
  transformer: BingImageOfTheDay.parse,
  fields: [
    JsonObjectField(
      name: "images",
      type: JsonArray(
        type: JsonObjectWithTransformer(
          transformer: BingImage.parse,
          fields: [
            JsonObjectField(
              name: "startdate",
              type: JsonConstantWithTransformer(
                type: JsonString(validator: _dateValidator),
                transformer: _dateTransformer,
              ),
            ),
            JsonObjectField(
              name: "fullstartdate",
              type: JsonConstantWithTransformer(
                type: JsonString(validator: _dateValidator),
                transformer: _dateTransformer,
              ),
            ),
            JsonObjectField(
              name: "enddate",
              type: JsonConstantWithTransformer(
                type: JsonString(validator: _dateValidator),
                transformer: _dateTransformer,
              ),
            ),
            JsonObjectField(
              name: "url",
              type: JsonConstantWithTransformer(
                type: JsonString(),
                transformer: _urlTransformer,
              ),
            ),
            JsonObjectField(
              name: "urlbase",
              type: JsonConstantWithTransformer(
                type: JsonString(),
                transformer: _urlTransformer,
              ),
            ),
            JsonObjectField(
              name: "copyright",
              type: JsonString(),
            ),
            JsonObjectField(
              name: "copyrightlink",
              type: JsonString(),
            ),
            JsonObjectField(
              name: "title",
              type: JsonString(),
            ),
            JsonObjectField(
              name: "quiz",
              type: JsonConstantWithTransformer(
                type: JsonString(),
                transformer: _urlTransformer,
              ),
            ),
            JsonObjectField(
              name: "wp",
              type: JsonBoolean(),
            ),
            JsonObjectField(
              name: "hsh",
              type: JsonString(),
            ),
            JsonObjectField(
              name: "drk",
              type: JsonNumber(),
            ),
            JsonObjectField(
              name: "top",
              type: JsonNumber(),
            ),
            JsonObjectField(
              name: "bot",
              type: JsonNumber(),
            ),
            JsonObjectField(
              name: "hs",
              type: JsonArray(type: JsonConstant()),
            ),
          ],
        ),
      ),
    ),
    JsonObjectField(
      name: "tooltips",
      type: JsonObjectWithTransformer(
        transformer: BingTooltips.parse,
        fields: [
          JsonObjectField(
            name: "loading",
            type: JsonString(),
          ),
          JsonObjectField(
            name: "previous",
            type: JsonString(),
          ),
          JsonObjectField(
            name: "next",
            type: JsonString(),
          ),
          JsonObjectField(
            name: "walle",
            type: JsonString(),
          ),
          JsonObjectField(
            name: "walls",
            type: JsonString(),
          ),
        ],
      ),
    ),
  ],
);

class BingImageOfTheDay {
  final List<BingImage> images;
  final BingTooltips tooltips;

  const BingImageOfTheDay({
    required this.images,
    required this.tooltips,
  });

  factory BingImageOfTheDay.parse(Map<String, dynamic> json) {
    return BingImageOfTheDay(
      images: (json["images"] as List).cast<BingImage>(),
      tooltips: json["tooltips"] as BingTooltips,
    );
  }
}

class BingTooltips {
  final String loading;
  final String previous;
  final String next;
  final String walle;
  final String walls;

  const BingTooltips({
    required this.loading,
    required this.previous,
    required this.next,
    required this.walle,
    required this.walls,
  });

  factory BingTooltips.parse(Map<String, dynamic> json) {
    return BingTooltips(
      loading: json["loading"] as String,
      previous: json["previous"] as String,
      next: json["next"] as String,
      walle: json["walle"] as String,
      walls: json["walls"] as String,
    );
  }
}

class BingImage {
  final DateTime startDate;
  final DateTime fullStartDate;
  final DateTime endDate;
  final Uri url;
  final Uri urlBase;
  final String copyright;
  final String copyrightLink;
  final String title;
  final Uri quiz;
  final bool wp;
  final String hash;
  final num drk;
  final num top;
  final num bot;

  const BingImage({
    required this.startDate,
    required this.fullStartDate,
    required this.endDate,
    required this.url,
    required this.urlBase,
    required this.copyright,
    required this.copyrightLink,
    required this.title,
    required this.quiz,
    required this.wp,
    required this.hash,
    required this.drk,
    required this.top,
    required this.bot,
  });

  factory BingImage.parse(Map<String, dynamic> json) {
    return BingImage(
      startDate: json["startdate"] as DateTime,
      fullStartDate: json["fullstartdate"] as DateTime,
      endDate: json["enddate"] as DateTime,
      url: json["url"] as Uri,
      urlBase: json["urlbase"] as Uri,
      copyright: json["copyright"] as String,
      copyrightLink: json["copyrightlink"] as String,
      title: json["title"] as String,
      quiz: json["quiz"] as Uri,
      wp: json["wp"] as bool,
      hash: json["hsh"] as String,
      drk: json["drk"] as num,
      top: json["top"] as num,
      bot: json["bot"] as num,
    );
  }
}

bool _dateValidator(String date) {
  return DateTime.tryParse(date.substring(0, 8)) != null;
}

DateTime _dateTransformer(String date) => DateTime.parse(date.substring(0, 8));

Uri _urlTransformer(String orig) {
  return Uri.parse("https://bing.com$orig");
}
