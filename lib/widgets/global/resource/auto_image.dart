import 'package:flutter/material.dart';
import 'package:pangolin/utils/other/resource.dart';
import 'package:pangolin/widgets/global/resource/icon/icon.dart';
import 'package:pangolin/widgets/global/resource/image/image.dart';

class AutoVisualResource extends StatelessWidget {

  const AutoVisualResource({
    required this.resource,
    required this.size,
    super.key,
  });
  final String resource;
  final double size;

  @override
  Widget build(BuildContext context) {
    final parsedResource = Resource.tryParse(resource);

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
