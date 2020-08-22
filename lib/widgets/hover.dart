import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final Widget child;
  final Color color;
  final BorderRadius borderRadius;
  const Hover({
    @required this.child,
    this.color,
    this.borderRadius,
    Key key,
  }) : super(key: key);

  @override
  _HoverState createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        color: _hover
            ? (widget.color == null)
                ? Colors.black.withOpacity(0.5)
                : widget.color.withOpacity(0.5)
            : Colors.black.withOpacity(0.0),
      ),
      child: Center(
        child: MouseRegion(
            onEnter: (event) {
              setState(() {
                _hover = true;
              });
            },
            onExit: (event) {
              setState(() {
                _hover = false;
              });
            },
            child: widget.child),
      ),
    );
  }
}
