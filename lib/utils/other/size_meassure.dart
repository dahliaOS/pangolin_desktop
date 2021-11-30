/*
Copyright 2021 The dahliaOS Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

//Credit: @HrX03
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizeMeasureWidget extends SingleChildRenderObjectWidget {
  final Widget child;
  final SizeMeasureCallback onSizeMeasure;

  const SizeMeasureWidget({
    Key? key,
    required this.child,
    required this.onSizeMeasure,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeMeasureRenderBox(onSizeMeasure);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _SizeMeasureRenderBox renderObject,
  ) {
    renderObject.onSizeMeasure = onSizeMeasure;
  }
}

class _SizeMeasureRenderBox extends RenderProxyBox {
  SizeMeasureCallback onSizeMeasure;

  _SizeMeasureRenderBox(this.onSizeMeasure);

  @override
  void paint(PaintingContext context, Offset offset) {
    onSizeMeasure.call(child!.size);
    context.paintChild(child!, offset);
  }
}

typedef SizeMeasureCallback = void Function(Size size);
