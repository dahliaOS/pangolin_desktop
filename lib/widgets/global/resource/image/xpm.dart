import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class XpmParser {
  static final RegExp _varDeclRegex = RegExp(
    r"static\s+char(\s*\*\s+|\s+\*\s*)[a-zA-Z_][a-zA-Z_0-9]+\s*\[\]\s*=\s*{",
  );

  const XpmParser();

  Xpm? parse(String input) {
    final _ConsumableStringBuffer buffer = _ConsumableStringBuffer(input, "\n");

    if (!buffer.canRead()) return null;
    if (buffer.read() != "/* XPM */") return null;
    if (!_varDeclRegex.hasMatch(buffer.read())) return null;

    buffer.parts.removeWhere((e) => RegExp(r"\/\*.*\*\/").hasMatch(e));

    final List<String> parts =
        buffer.read().replaceAll(RegExp('",?'), "").trim().split(RegExp(r"\s"));
    final List<int> values = parts.map((e) => int.parse(e)).toList();

    if (values.length != 4 && values.length != 6) return null;

    final int width = values[0];
    final int height = values[1];
    final int ncolors = values[2];
    final int cpp = values[3];

    final Map<String, ui.Color> colors = {};

    for (int i = 0; i < ncolors && buffer.canRead(); i++) {
      final String line = buffer
          .read()
          .replaceAll(RegExp(r'",$'), "")
          .replaceAll(RegExp('"'), "");
      final _ConsumableStringBuffer lineBuffer =
          _ConsumableStringBuffer(line, "");

      final String char = lineBuffer.read(cpp);
      lineBuffer.skip(RegExp(r"\s"));

      if (lineBuffer.read() != "c") return null;
      lineBuffer.skip(RegExp(r"\s"));

      if (lineBuffer.toString() == "None") {
        colors[char] = const ui.Color(0x00000000);
        continue;
      }

      if (lineBuffer.read() != "#") return null;

      final String hexColorStr = lineBuffer.toString().substring(0, 6);
      final int? hexColor = int.tryParse(hexColorStr, radix: 16);
      if (hexColor == null) return null;

      final int r = (0xff0000 & hexColor) >> 16;
      final int g = (0x00ff00 & hexColor) >> 8;
      final int b = (0x0000ff & hexColor) >> 0;

      colors[char] = ui.Color.fromARGB(0xff, r, g, b);
    }

    if (colors.length != ncolors) return null;

    final Uint32List colorBuffer = Uint32List(width * height);

    for (int y = 0; y < height; y++) {
      final String line = buffer.read().replaceAll(RegExp('"(,|};)?'), "");
      final _ConsumableStringBuffer lineBuffer =
          _ConsumableStringBuffer(line, "");

      for (int x = 0; x < width; x++) {
        final String char = lineBuffer.read(cpp);
        final int? color = colors[char]?.value;

        if (color == null) return null;

        colorBuffer[x + y * width] = color;
      }
    }

    return Xpm(
      width: width,
      height: height,
      data: Uint8List.sublistView(colorBuffer),
    );
  }
}

class Xpm {
  final int width;
  final int height;
  final Uint8List data;

  const Xpm({
    required this.width,
    required this.height,
    required this.data,
  }) : assert(data.length == width * height * 4);

  @override
  int get hashCode => Object.hash(width, height, data);

  @override
  bool operator ==(Object? other) {
    if (other is Xpm) {
      return width == other.width &&
          height == other.height &&
          data == other.data;
    }

    return false;
  }
}

class _ConsumableStringBuffer {
  final String separator;
  final List<String> parts;

  _ConsumableStringBuffer(String string, this.separator)
      : parts = string.split(separator);

  String read([int amount = 1]) {
    final String content = parts.getRange(0, amount).join(separator);
    parts.removeRange(0, amount);
    return content;
  }

  String peek() {
    return parts.first;
  }

  void skip(Pattern pattern) {
    if (pattern.allMatches(peek()).isNotEmpty) read();
  }

  bool canRead() {
    return parts.isNotEmpty;
  }

  @override
  String toString() {
    return parts.join(separator);
  }
}

class XpmImage extends StatefulWidget {
  final File file;
  final double? width;
  final double? height;
  final double scale;
  final BoxFit? fit;

  const XpmImage(
    this.file, {
    this.width,
    this.height,
    this.scale = 1.0,
    this.fit,
    super.key,
  });

  @override
  State<XpmImage> createState() => _XpmImageState();
}

class _XpmImageState extends State<XpmImage> {
  static const XpmParser parser = XpmParser();
  Xpm? loadedXpm;
  ui.Image? loadedImage;

  @override
  void initState() {
    super.initState();
    loadXpm(widget.file);
  }

  @override
  void didUpdateWidget(XpmImage oldWidget) {
    if (widget.file != oldWidget.file) {
      loadXpm(widget.file);
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadXpm(File file) async {
    final String input = await file.readAsString();
    loadedXpm = parser.parse(input);

    if (loadedXpm == null) {
      throw Exception("Invalid xpm file");
    }

    ui.decodeImageFromPixels(
      loadedXpm!.data,
      loadedXpm!.width,
      loadedXpm!.height,
      ui.PixelFormat.bgra8888,
      imageLoaded,
      targetHeight: widget.width?.toInt(),
      targetWidth: widget.height?.toInt(),
    );
  }

  void imageLoaded(ui.Image img) {
    loadedImage = img;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: loadedImage,
      width: widget.width,
      height: widget.height,
      scale: widget.scale,
      fit: widget.fit,
    );
  }
}
