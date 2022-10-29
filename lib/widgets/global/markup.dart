import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkupText extends StatelessWidget {

  const MarkupText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });
  static final _hrefRegexp = RegExp('(?<=href=").+?(?=")');

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final partList = <TextPart>[];
    var current = '';
    final currentTypes = <TextType>[];
    String? cUrl;
    String? cColor;

    void addPart() {
      if (current != '') {
        partList.add(
          TextPart(
            current,
            url: cUrl,
            color: cColor,
          )..addAll(currentTypes),
        );
        current = '';
      }
    }

    void addType(TextType t) {
      if (!currentTypes.contains(t)) currentTypes.add(t);
    }

    void removeType(TextType t) {
      if (currentTypes.contains(t)) currentTypes.remove(t);
    }

    for (var pointer = 0; pointer < text.length; pointer++) {
      if (text[pointer] == '<') {
        final end = text.indexOf('>', pointer);
        if (end > 0) {
          final code = text.substring(pointer + 1, end);
          switch (code) {
            case 'b':
              addPart();
              addType(TextType.bold);
              pointer += 2;
              break;
            case 'i':
              addPart();
              addType(TextType.italic);
              pointer += 2;
              break;
            case 'u':
              addPart();
              addType(TextType.underlined);
              pointer += 2;
              break;
            case '/b':
              addPart();
              removeType(TextType.bold);
              pointer += 3;
              break;
            case '/i':
              addPart();
              removeType(TextType.italic);
              pointer += 3;
              break;
            case '/u':
              addPart();
              removeType(TextType.underlined);
              pointer += 3;
              break;
            case '/a':
              addPart();
              removeType(TextType.link);
              cUrl = null;
              pointer += 3;
              break;
            default:
              if (code.startsWith('a ') &&
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

  TextPart(
    this.text, {
    this.url,
    this.color,
  });
  final String text;
  final String? url;
  final String? color;
  final List<TextType> types = [];

  void add(TextType type) {
    types.add(type);
  }

  void addAll(List<TextType> currentTypes) {
    for (final type in currentTypes) {
      types.add(type);
    }
  }

  InlineSpan toSpan() {
    final decorations = <TextDecoration>[];
    Color? cColor;
    TapGestureRecognizer? recognizer;
    var fontWeight = FontWeight.normal;
    var fontStyle = FontStyle.normal;

    for (final type in types) {
      switch (type) {
        case TextType.link:
          cColor = Colors.blue;
          decorations.add(TextDecoration.underline);
          if (url != null) {
            recognizer = TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrlString(url!)) await launchUrlString(url!);
              };
          }
          break;
        case TextType.bold:
          fontWeight = FontWeight.bold;
          break;
        case TextType.italic:
          fontStyle = FontStyle.italic;
          break;
        case TextType.underlined:
          decorations.add(TextDecoration.underline);
          break;
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
