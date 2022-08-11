import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/widgets/notification.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/resource/icon/icon.dart';
import 'package:pangolin/widgets/global/resource/image/image.dart';

class NotificationImageWidget extends StatefulWidget {
  final NotificationImage image;
  final double? width;
  final double? height;

  const NotificationImageWidget({
    required this.image,
    this.width,
    this.height,
    super.key,
  });

  @override
  State<NotificationImageWidget> createState() =>
      _NotificationImageWidgetState();
}

class _NotificationImageWidgetState extends State<NotificationImageWidget> {
  ui.Image? _rawImage;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  @override
  void didUpdateWidget(covariant NotificationImageWidget oldWidget) {
    if (widget.image != oldWidget.image) {
      _decodeImage();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _decodeImage() {
    final NotificationImage image = widget.image;
    if (image is! RawNotificationImage) return;

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
    final NotificationImage image = widget.image;

    if (image is PathNotificationImage) {
      final Uri? uri = Uri.tryParse(image.path);

      if (uri != null && (uri.scheme == "file" || image.path.startsWith("/"))) {
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
            value: image.path,
          ),
          size: squareSize,
        );
      }
    } else if (image is RawNotificationImage) {
      if (_rawImage != null) {
        return CustomPaint(
          painter: _UiImagePainter(_rawImage!),
          size: Size(
            widget.width ?? image.width.toDouble(),
            widget.height ?? image.height.toDouble(),
          ),
        );
      }
    } else if (image is IconDataNotificationImage) {
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
