import 'dart:typed_data';

import 'package:flutter/widgets.dart' show IconData;

abstract class DBusImage {
  const DBusImage();
}

class PngDBusImage extends DBusImage {

  const PngDBusImage(this.bytes);
  final Uint8List bytes;
}

class RawDBusImage extends DBusImage {

  const RawDBusImage({
    required this.width,
    required this.height,
    required this.rowStride,
    required this.hasAlpha,
    required this.bytes,
  });
  final int width;
  final int height;
  final int rowStride;
  final bool hasAlpha;
  final Uint8List bytes;
}

class RawDBusImageCollection extends DBusImage {

  const RawDBusImageCollection(this.pixmaps);
  final Map<int, RawDBusImage> pixmaps;
}

class NameDBusImage extends DBusImage {

  const NameDBusImage(this.name);
  final String name;
}

class IconDataDBusImage extends DBusImage {

  const IconDataDBusImage(this.data);
  final IconData data;
}
