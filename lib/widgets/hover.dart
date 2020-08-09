import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  const Hover({
    Key key,
    this.animationDuration = const Duration(milliseconds: 150),
    this.builder,
  }) : super(key: key);

  final Duration animationDuration;
  final Widget Function(BuildContext context, Animation<double> animation)
      builder;

  @override
  _HoverState createState() => _HoverState();
}

class _HoverState extends State<Hover> with TickerProviderStateMixin<Hover> {
  AnimationController _controller;

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: widget.builder(context, _controller.view),
    );
  }
}
