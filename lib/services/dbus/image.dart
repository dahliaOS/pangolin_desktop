import 'dart:typed_data';

import 'package:flutter/widgets.dart' show IconData;

abstract class DBusImage {
  const DBusImage();
}

class PngDBusImage extends DBusImage {
  final Uint8List bytes;

  const PngDBusImage(this.bytes);
}

class RawDBusImage extends DBusImage {
  final int width;
  final int height;
  final int rowStride;
  final bool hasAlpha;
  final Uint8List bytes;

  const RawDBusImage({
    required this.width,
    required this.height,
    required this.rowStride,
    required this.hasAlpha,
    required this.bytes,
  });
}

class RawDBusImageCollection extends DBusImage {
  final Map<int, RawDBusImage> pixmaps;

  const RawDBusImageCollection(this.pixmaps);
}

class NameDBusImage extends DBusImage {
  final String name;

  const NameDBusImage(this.name);
}

class IconDataDBusImage extends DBusImage {
  final IconData data;

  const IconDataDBusImage(this.data);
}
