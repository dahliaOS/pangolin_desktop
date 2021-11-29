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

class QsActionButton extends StatefulWidget {
  const QsActionButton({
    Key? key,
    this.onPressed,
    this.title,
    this.leading,
    this.padding,
    this.isCircular,
    this.textStyle,
    this.margin,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  final bool? isCircular;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;

  @override
  _QsActionButtonState createState() => _QsActionButtonState();
}

class _QsActionButtonState extends State<QsActionButton> {
  @override
  Widget build(BuildContext context) {
    bool titleIsNull = widget.title == null;
    bool leadingIsNull = widget.leading == null;
    return Padding(
      padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 40,
        width: widget.isCircular == true ? 40 : null,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: context.theme.darkMode
              ? ColorsX.black.op(0.5)
              : ColorsX.white.op(0.5),
          borderRadius: BorderRadius.circular(32),
          child: InkWell(
            onTap: () => widget.onPressed?.call(),
            child: Padding(
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                      horizontal: !titleIsNull ? 12.0 : 8.0, vertical: 8.0),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: context.theme.darkMode ? ColorsX.white : ColorsX.black,
                  size: 18,
                ),
                child: DefaultTextStyle(
                  style: widget.textStyle ??
                      context.theme.textTheme.bodyText1!.copyWith(
                          fontSize: 13, fontWeight: FontWeight.normal),
                  child: !(widget.isCircular == true)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.leading ?? const SizedBox.shrink(),
                            !(titleIsNull || leadingIsNull)
                                ? const SizedBox(width: 8)
                                : const SizedBox.shrink(),
                            !titleIsNull
                                ? Text(widget.title!)
                                : const SizedBox.shrink(),
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
