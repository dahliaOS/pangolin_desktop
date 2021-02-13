import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Searchbar extends StatelessWidget {
  final Widget? leading, trailing;
  final String? hint;
  final TextEditingController? controller;
  final BorderRadius? borderRadius;
  final FocusNode? focusNode;
  const Searchbar(
      {required this.leading,
      required this.trailing,
      required this.hint,
      required this.controller,
      this.borderRadius,
      this.focusNode});
  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      customBorderRadius: borderRadius ?? BorderRadius.circular(8),
      color: Theme.of(context).cardColor,
      useSystemOpacity: true,
      width: 800,
      height: 48,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 48,
              width: 48,
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: this.leading ??
                    SizedBox(
                      height: 48,
                      width: 48,
                    ),
              )),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              height: 48,
              width: 48,
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                child: this.trailing ??
                    SizedBox(
                      height: 48,
                      width: 48,
                    ),
              )),
        ],
      ),
    );
  }
}
