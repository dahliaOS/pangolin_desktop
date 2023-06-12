import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/services/icon.dart';
import 'package:pangolin/widgets/resource/image/image.dart';

class ResourceIcon extends StatefulWidget {
  final IconResource resource;
  final String? themePath;
  final double? size;
  final Color? color;
  final bool lookupForSize;

  const ResourceIcon({
    required this.resource,
    this.themePath,
    this.size,
    this.color,
    this.lookupForSize = false,
    super.key,
  });

  @override
  State<ResourceIcon> createState() => _ResourceIconState();
}

class _ResourceIconState extends State<ResourceIcon> {
  bool _iconServiceReady = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await ServiceManager.waitForService<IconService>();
    _iconServiceReady = true;
    IconService.current.addListener(_update);
    _update();
  }

  @override
  void dispose() {
    if (_iconServiceReady) IconService.current.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (mounted) setState(() {});
  }

  Future<String?> resolveReference(IconReference reference) {
    return switch (reference) {
      DahliaIconReference(:final name) => Future.value(name),
      FileIconReference(:final name) => Future.value(name),
      XdgIconReference() => _resolveXdg(reference),
    };
  }

  Future<String?> _resolveXdg(XdgIconReference ref) async {
    if (!_iconServiceReady) return null;

    if (ref.directory != null) {
      return IconService.current.lookupFromDirectory(
        ref.directory!,
        ref.name,
        fallback: ref.fallback,
      );
    } else {
      return IconService.current.lookup(
        ref.name,
        size: ref.size,
        fallback: ref.fallback,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: resolveReference(
        widget.resource.resolve(
          size: widget.lookupForSize ? widget.size?.toInt() : null,
          directory: widget.themePath,
          fallback: "application-x-executable",
        ),
      ),
      builder: (context, snapshot) {
        final String? resolvedResource = snapshot.data;

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
      },
    );
  }
}
