import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:zenit_ui/zenit_ui.dart';

class Searchbar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const Searchbar({super.key, this.onChanged, this.focusNode, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 720,
      child: Material(
        type: MaterialType.card,
        shape: Constants.smallShape,
        clipBehavior: Clip.antiAlias,
        child: ZenitTextField(
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
          hint: "Search device, web and apps",
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints.tightFor(width: 56),
            suffixIcon: Icon(Icons.close),
            suffixIconConstraints: BoxConstraints.tightFor(width: 56),
            contentPadding: EdgeInsets.symmetric(vertical: 22),
          ),
        ),
      ),
    );
  }
}
