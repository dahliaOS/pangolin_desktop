import 'package:flutter/material.dart';
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/other/log.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/resource/image/image.dart';

class ResourceIcon extends StatefulWidget {
  final IconResource resource;
  final double? size;
  final Color? color;
  final bool lookupForSize;

  const ResourceIcon({
    required this.resource,
    this.size,
    this.color,
    this.lookupForSize = false,
    super.key,
  });

  @override
  State<ResourceIcon> createState() => _ResourceIconState();
}

class _ResourceIconState extends State<ResourceIcon> with LoggerProvider {
  @override
  void initState() {
    super.initState();
    IconService.current.addListener(_update);
  }

  @override
  void dispose() {
    IconService.current.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String? resolvedResource = widget.resource.resolve(
      size: widget.lookupForSize ? widget.size?.toInt() : null,
      fallback: "application-x-executable",
    );

    if (resolvedResource == null) {
      return SizedBox.square(dimension: widget.size);
    }

    switch (widget.resource.subtype) {
      case IconResourceType.dahlia:
        return Icon(
          Constants.builtinIcons[resolvedResource],
          size: widget.size,
          color: widget.color,
        );
      case IconResourceType.xdg:
        return ResourceImage(
          resource: ImageResource(
            type: ImageResourceType.file,
            value: resolvedResource,
          ),
          width: widget.size,
          height: widget.size,
        );
    }
  }
}
