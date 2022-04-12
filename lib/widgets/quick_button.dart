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

import 'package:pangolin/utils/extensions/extensions.dart';

class QuickActionButton extends StatefulWidget {
  const QuickActionButton({
    Key? key,
    this.onPressed,
    this.title,
    this.leading,
    this.padding,
    this.isCircular = true,
    this.textStyle,
    this.margin,
    this.size,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  final bool? isCircular;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;
  final double? size;

  @override
  _QuickActionButtonState createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  @override
  Widget build(BuildContext context) {
    final bool titleIsNull = widget.title == null;
    final bool leadingIsNull = widget.leading == null;

    return Padding(
      padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: widget.size ?? 40,
        width: widget.isCircular == true ? widget.size ?? 40 : null,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: context.theme.backgroundColor.op(0.5),
          borderRadius: BorderRadius.circular(32),
          child: InkWell(
            onTap: () => widget.onPressed?.call(),
            child: Padding(
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: !titleIsNull ? 12.0 : 8.0,
                    vertical: 8.0,
                  ),
              child: IconTheme.merge(
                data: const IconThemeData(
                  size: 18,
                ),
                child: DefaultTextStyle(
                  style: widget.textStyle ??
                      context.theme.textTheme.bodyText1!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                  child: !(widget.isCircular == true)
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.leading ?? const SizedBox.shrink(),
                            if (!(titleIsNull || leadingIsNull))
                              const SizedBox(width: 8)
                            else
                              const SizedBox.shrink(),
                            if (!titleIsNull)
                              Text(widget.title!)
                            else
                              const SizedBox.shrink(),
                          ],
                        )
                      : widget.leading ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
