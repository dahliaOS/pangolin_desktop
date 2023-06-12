import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/resource/icon/icon.dart';
import 'package:pangolin/widgets/resource/image/image.dart';

class AutoVisualResource extends StatelessWidget {
  final String resource;
  final double size;

  const AutoVisualResource({
    required this.resource,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Resource? parsedResource = Resource.tryParse(resource);

    if (parsedResource == null || parsedResource is IconResource) {
      return ResourceIcon(
        resource: parsedResource as IconResource? ??
            IconResource(
              type: IconResourceType.xdg,
              value: resource,
            ),
        size: size,
        lookupForSize: true,
      );
    }

    if (parsedResource is ImageResource) {
      return ResourceImage(
        resource: parsedResource,
        width: size,
        height: size,
      );
    }

    return SizedBox.square(dimension: size);
  }
}
