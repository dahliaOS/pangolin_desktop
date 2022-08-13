import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pangolin/services/dbus/image.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/resource/icon/icon.dart';
import 'package:pangolin/widgets/global/resource/image/image.dart';

class DBusImageWidget extends StatefulWidget {
  final DBusImage image;
  final double? width;
  final double? height;

  /// Valid only for xdg icons
  final String? themePath;

  const DBusImageWidget({
    required this.image,
    this.width,
    this.height,
    this.themePath,
    super.key,
  });

  @override
  State<DBusImageWidget> createState() => _DBusImageWidgetState();
}

class _DBusImageWidgetState extends State<DBusImageWidget> {
  ui.Image? _rawImage;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  @override
  void didUpdateWidget(covariant DBusImageWidget oldWidget) {
    if (widget.image != oldWidget.image) {
      _decodeImage();
    }

    super.didUpdateWidget(oldWidget);
  }

  DBusImage _selectBestForSize(Map<int, DBusImage> images) {
    if (squareSize == null) return images.values.last;

    for (final int size in images.keys) {
      if (size > squareSize!) {
        return images[size]!;
      }
    }

    return images.values.last;
  }

  Future<void> _decodeImage() async {
    DBusImage image = widget.image;

    if (image is RawDBusImageCollection) {
      image = _selectBestForSize(image.pixmaps);
    }

    if (image is RawDBusImage) {
      final Uint8List bytes;
      final int rowBytes;

      if (!image.hasAlpha) {
        bytes = _patchBytes(image.bytes, image.width, image.height);
        rowBytes = image.rowStride + image.width;
      } else {
        bytes = image.bytes;
        rowBytes = image.rowStride;
      }

      ui.decodeImageFromPixels(
        bytes,
        image.width,
        image.height,
        ui.PixelFormat.rgba8888,
        _updateImage,
        rowBytes: rowBytes,
        targetWidth: widget.width?.round(),
        targetHeight: widget.height?.round(),
      );
    } else if (image is PngDBusImage) {
      final ui.Codec codec = await ui.instantiateImageCodec(
        image.bytes,
        targetWidth: widget.width?.round(),
        targetHeight: widget.height?.round(),
      );
      final ui.FrameInfo frame = await codec.getNextFrame();
      _updateImage(frame.image);
    }
  }

  Uint8List _patchBytes(Uint8List bytes, int width, int height) {
    final List<int> result = [];

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width * 3; x += 3) {
        final int r = bytes[x + y * width * 3];
        final int g = bytes[x + 1 + y * width * 3];
        final int b = bytes[x + 2 + y * width * 3];

        result.addAll([r, g, b, 255]);
      }
    }

    return Uint8List.fromList(result);
  }

  void _updateImage(ui.Image image) {
    _rawImage = image;
    if (mounted) setState(() {});
  }

  double? get squareSize {
    if (widget.width == null && widget.height == null) return null;

    if (widget.width == null) return widget.height!;
    if (widget.height == null) return widget.width!;

    return min(widget.height!, widget.width!);
  }

  @override
  Widget build(BuildContext context) {
    DBusImage image = widget.image;

    if (image is RawDBusImageCollection) {
      image = _selectBestForSize(image.pixmaps);
    }

    if (image is NameDBusImage) {
      final Uri? uri = Uri.tryParse(image.name);

      if (uri != null && (uri.scheme == "file" || image.name.startsWith("/"))) {
        return ResourceImage(
          resource: ImageResource(
            type: ImageResourceType.file,
            value: uri.toFilePath(),
          ),
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
        );
      } else {
        return ResourceIcon(
          resource: IconResource(
            type: IconResourceType.xdg,
            value: image.name,
          ),
          size: squareSize,
          themePath: widget.themePath,
        );
      }
    } else if (image is RawDBusImage) {
      if (_rawImage != null) {
        return CustomPaint(
          painter: _UiImagePainter(_rawImage!),
          size: Size(
            widget.width ?? image.width.toDouble(),
            widget.height ?? image.height.toDouble(),
          ),
        );
      }
    } else if (image is PngDBusImage) {
      return Image.memory(
        image.bytes,
        width: widget.width,
        height: widget.height,
      );
      /* if (_rawImage != null) {
        return CustomPaint(
          painter: _UiImagePainter(_rawImage!),
          size: Size(
            widget.width ?? double.infinity,
            widget.height ?? double.infinity,
          ),
        );
      } */
    } else if (image is IconDataDBusImage) {
      return Icon(
        image.data,
        size: squareSize,
      );
    }

    return const SizedBox.expand();
  }
}

class _UiImagePainter extends CustomPainter {
  final ui.Image image;

  const _UiImagePainter(this.image);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    paintImage(
      canvas: canvas,
      rect: Offset.zero & size,
      image: image,
      fit: BoxFit.contain,
    );
  }

  @override
  bool shouldRepaint(covariant _UiImagePainter old) => image != old.image;
}
