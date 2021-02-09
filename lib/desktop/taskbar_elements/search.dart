import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: Icon(Icons.search, size: 20)),
          ),
        ),
      ),
    );
  }
}
