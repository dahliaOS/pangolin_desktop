import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkupText extends StatelessWidget {
  static final _hrefRegexp = RegExp('(?<=href=").+?(?=")');

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow overflow;

  const MarkupText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextPart> partList = [];
    String current = "";
    final List<TextType> currentTypes = [];
    String? cUrl;
    String? cColor;

    void addPart() {
      if (current != "") {
        partList.add(
          TextPart(
            current,
            url: cUrl,
            color: cColor,
          )..addAll(currentTypes),
        );
        current = "";
      }
    }

    void addType(TextType t) {
      if (!currentTypes.contains(t)) currentTypes.add(t);
    }

    void removeType(TextType t) {
      if (currentTypes.contains(t)) currentTypes.remove(t);
    }

    for (int pointer = 0; pointer < text.length; pointer++) {
      if (text[pointer] == "<") {
        final int end = text.indexOf(">", pointer);
        if (end > 0) {
          final String code = text.substring(pointer + 1, end);
          switch (code) {
            case "b":
              addPart();
              addType(TextType.bold);
              pointer += 2;
            case "i":
              addPart();
              addType(TextType.italic);
              pointer += 2;
            case "u":
              addPart();
              addType(TextType.underlined);
              pointer += 2;
            case "/b":
              addPart();
              removeType(TextType.bold);
              pointer += 3;
            case "/i":
              addPart();
              removeType(TextType.italic);
              pointer += 3;
            case "/u":
              addPart();
              removeType(TextType.underlined);
              pointer += 3;
            case "/a":
              addPart();
              removeType(TextType.link);
              cUrl = null;
              pointer += 3;
            default:
              if (code.startsWith("a ") &&
                  _hrefRegexp.firstMatch(code) != null) {
                addPart();
                addType(TextType.link);
                cUrl = _hrefRegexp.firstMatch(code)!.group(0);
                pointer += code.length + 1;
                break;
              }
              current += text[pointer];
          }
        } else {
          current += text[pointer];
        }
      } else {
        current += text[pointer];
      }
    }
    addPart();

    return RichText(
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.merge(style),
        children: partList.map((e) => e.toSpan()).toList(),
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum TextType { link, bold, italic, underlined }

class TextPart {
  final String text;
  final String? url;
  final String? color;
  final List<TextType> types = [];

  TextPart(
    this.text, {
    this.url,
    this.color,
  });

  void add(TextType type) {
    types.add(type);
  }

  void addAll(List<TextType> currentTypes) {
    for (final TextType type in currentTypes) {
      types.add(type);
    }
  }

  InlineSpan toSpan() {
    final List<TextDecoration> decorations = [];
    Color? cColor;
    TapGestureRecognizer? recognizer;
    FontWeight fontWeight = FontWeight.normal;
    FontStyle fontStyle = FontStyle.normal;

    for (final TextType type in types) {
      switch (type) {
        case TextType.link:
          cColor = Colors.blue;
          decorations.add(TextDecoration.underline);
          if (url != null) {
            recognizer = TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrlString(url!)) launchUrlString(url!);
              };
          }
        case TextType.bold:
          fontWeight = FontWeight.bold;
        case TextType.italic:
          fontStyle = FontStyle.italic;
        case TextType.underlined:
          decorations.add(TextDecoration.underline);
      }
    }

    return TextSpan(
      text: text,
      recognizer: recognizer,
      mouseCursor: recognizer != null ? SystemMouseCursors.click : null,
      style: TextStyle(
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: cColor,
        decoration: TextDecoration.combine(decorations),
      ),
    );
  }
}
