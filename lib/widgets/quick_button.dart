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

import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QuickActionButton extends StatefulWidget {
  const QuickActionButton({
    super.key,
    this.onPressed,
    this.title,
    this.leading,
    this.padding,
    this.textStyle,
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.size,
  });

  final VoidCallback? onPressed;
  final String? title;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry margin;
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
      padding: widget.margin,
      child: SizedBox(
        height: widget.size ?? 40,
        width: titleIsNull ? widget.size ?? 40 : null,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).surfaceColor,
          shape: Constants.circularShape,
          child: InkWell(
            onTap: widget.onPressed,
            child: Padding(
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: titleIsNull ? 8.0 : 12.0,
                    vertical: 8.0,
                  ),
              child: IconTheme.merge(
                data: const IconThemeData(
                  size: 18,
                ),
                child: DefaultTextStyle(
                  style: widget.textStyle ??
                      context.theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                  child: !titleIsNull
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
