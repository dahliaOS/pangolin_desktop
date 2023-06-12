import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
// ignore: implementation_imports
import 'package:jovial_svg/src/dag.dart';
// ignore: implementation_imports
import 'package:jovial_svg/src/svg_parser.dart';
import 'package:pangolin/widgets/resource/image/xpm.dart';
import 'package:path/path.dart' as p;

typedef ImageBuilder = Widget Function(
  BuildContext context,
  String resolvedResource,
  ImageResourceType resourceType,
  ImageErrorWidgetBuilder? errorBuilder,
  BoxFit? fit,
  double? width,
  double? height,
);

class ResourceImage extends StatefulWidget {
  final ImageResource resource;
  final ImageErrorWidgetBuilder? errorBuilder;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ResourceImage({
    required this.resource,
    this.errorBuilder,
    this.width,
    this.height,
    this.fit,
    super.key,
  });

  @override
  State<ResourceImage> createState() => _ResourceImageState();
}

class _ResourceImageState extends State<ResourceImage> {
  static const ImageBuilder builder =
      !kIsWeb ? _buildResourceIO : _buildResourceWeb;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      widget.resource.resolve(),
      widget.resource.subtype,
      widget.errorBuilder,
      widget.fit,
      widget.width,
      widget.height,
    );
  }
}

Widget _buildResourceIO(
  BuildContext context,
  String resolvedResource,
  ImageResourceType resourceType,
  ImageErrorWidgetBuilder? errorBuilder,
  BoxFit? fit,
  double? width,
  double? height,
) {
  switch (resourceType) {
    case ImageResourceType.dahlia:
      return Image.asset(
        resolvedResource,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: errorBuilder,
      );
    case ImageResourceType.network:
      return CachedNetworkImage(
        imageUrl: resolvedResource,
        fit: fit,
        cacheKey: resolvedResource,
        useOldImageOnUrlChange: true,
        width: width,
        height: height,
        errorWidget: errorBuilder != null
            ? (context, url, error) => errorBuilder(context, url, null)
            : null,
      );
    case ImageResourceType.file:
      final String path = resolvedResource;
      final String ext = p.extension(path);

      switch (ext) {
        case ".svg":
        case ".svgz":
          return _SvgFileRenderer(
            file: File(path),
            width: width,
            height: height,
            fit: fit,
          );
        case ".xpm":
          return XpmImage(
            File(path),
            width: width,
            height: height,
            fit: fit,
          );
        default:
          return Image.file(
            File(path),
            width: width,
            height: height,
            filterQuality: FilterQuality.medium,
            isAntiAlias: true,
            gaplessPlayback: true,
            fit: fit,
            errorBuilder: errorBuilder,
          );
      }
    default:
      return SizedBox(width: width, height: height);
  }
}

Widget _buildResourceWeb(
  BuildContext context,
  String resolvedResource,
  ImageResourceType resourceType,
  ImageErrorWidgetBuilder? errorBuilder,
  BoxFit? fit,
  double? width,
  double? height,
) {
  switch (resourceType) {
    case ImageResourceType.dahlia:
      return Image.asset(
        resolvedResource,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: errorBuilder,
      );
    case ImageResourceType.network:
      return CachedNetworkImage(
        imageUrl: resolvedResource,
        fit: fit,
        cacheKey: resolvedResource,
        useOldImageOnUrlChange: true,
        width: width,
        height: height,
        errorWidget: errorBuilder != null
            ? (context, url, error) => errorBuilder(context, url, null)
            : null,
      );
    default:
      break;
  }

  return SizedBox(width: width, height: height);
}

class _SvgFileRenderer extends StatefulWidget {
  final File file;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const _SvgFileRenderer({
    required this.file,
    this.fit,
    this.width,
    this.height,
  });

  @override
  State<_SvgFileRenderer> createState() => _SvgFileRendererState();
}

class _SvgFileRendererState extends State<_SvgFileRenderer> {
  ScalableImage? image;

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  @override
  void didUpdateWidget(_SvgFileRenderer oldWidget) {
    if (widget.file != oldWidget.file) {
      _loadResource();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _loadResource() async {
    List<int> src = await widget.file.readAsBytes();
    final ByteData data = ByteData.sublistView(Uint8List.fromList(src));
    final int header = data.getUint16(0);

    if (header == 0x1f8b || header == 0x8b1f) {
      src = gzip.decode(src);
    }

    final b = SIDagBuilder(warn: (_) {});
    StringSvgParser(utf8.decode(src), b, warn: (_) {}).parse();
    image = b.si;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: image != null
          ? ScalableImageWidget(
              si: image!,
              fit: widget.fit ?? BoxFit.contain,
            )
          : null,
    );
  }
}
