import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
// ignore: implementation_imports
import 'package:jovial_svg/src/dag.dart';
// ignore: implementation_imports
import 'package:jovial_svg/src/svg_parser.dart';
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/utils/other/log.dart';
import 'package:pangolin/widgets/global/icon/xpm.dart';
import 'package:path/path.dart' as p;

typedef IconBuilder = Widget Function(
  BuildContext context,
  String resolvedIcon,
  double size,
);

class DynamicIcon extends StatefulWidget {
  final String icon;
  final int size;
  final bool lookupForSize;

  const DynamicIcon({
    required this.icon,
    this.size = 24,
    this.lookupForSize = false,
    super.key,
  });

  @override
  State<DynamicIcon> createState() => _DynamicIconState();
}

class _DynamicIconState extends State<DynamicIcon> with LoggerProvider {
  static const IconBuilder builder = !kIsWeb ? _buildIconIO : _buildIconWeb;

  String? _loadedIcon;

  @override
  void initState() {
    super.initState();
    _loadIcon();
    IconService.current.addListener(_loadAndUpdate);
  }

  @override
  void dispose() {
    IconService.current.removeListener(_loadAndUpdate);
    super.dispose();
  }

  @override
  void didUpdateWidget(DynamicIcon oldWidget) {
    if (widget.icon != oldWidget.icon || widget.size != oldWidget.size) {
      _loadIcon();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadAndUpdate() {
    _loadIcon();
    if (mounted) setState(() {});
  }

  void _loadIcon() {
    if (widget.icon.startsWith("/")) {
      _loadedIcon = widget.icon;
    } else {
      _loadedIcon = IconService.current.lookup(
        widget.icon,
        size: widget.lookupForSize ? widget.size : null,
        fallback: "application-x-executable",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadedIcon == null) {
      return SizedBox.square(dimension: widget.size.toDouble());
    }

    return builder(context, _loadedIcon!, widget.size.toDouble());
  }
}

Widget _buildIconIO(BuildContext context, String loadedIcon, double size) {
  if (loadedIcon.startsWith("asset://")) {
    return Image.asset(
      loadedIcon.replaceAll("asset://", ""),
      width: size,
      height: size,
    );
  }

  final String ext = p.extension(loadedIcon);

  switch (ext) {
    case ".svg":
    case ".svgz":
      return _SvgFileRenderer(
        file: File(loadedIcon),
        width: size,
        height: size,
      );
    case ".png":
      return Image.file(
        File(loadedIcon),
        width: size,
        height: size,
        filterQuality: FilterQuality.medium,
        isAntiAlias: true,
        gaplessPlayback: true,
      );
    case ".xpm":
      return XpmImage(
        File(loadedIcon),
        width: size,
        height: size,
      );
  }

  return SizedBox.square(dimension: size);
}

Widget _buildIconWeb(BuildContext context, String loadedIcon, double size) {
  if (loadedIcon.startsWith("asset://")) {
    return Image.asset(
      loadedIcon.replaceAll("asset://", ""),
      width: size,
      height: size,
    );
  }

  return SizedBox.square(dimension: size);
}

class _SvgFileRenderer extends StatefulWidget {
  final File file;
  final double? width;
  final double? height;

  const _SvgFileRenderer({
    required this.file,
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
    _loadIcon();
  }

  @override
  void didUpdateWidget(_SvgFileRenderer oldWidget) {
    if (widget.file != oldWidget.file) {
      _loadIcon();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _loadIcon() async {
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
      child: image != null ? ScalableImageWidget(si: image!) : null,
    );
  }
}
