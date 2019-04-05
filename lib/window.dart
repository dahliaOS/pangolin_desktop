import 'package:flutter/material.dart';
/// A window container
class Window extends StatefulWidget{
  /// The window's initial position.
  final Offset initialPosition;

  /// The window's initial size.
  final Size initialSize;

  /// The window's child.
  final Widget child;

  //TODO: get the color from child's material app primary swatch
  /// The window's theme color.
  final Color color;

  /// Constructor.
  Window({
    Key key,
    this.initialPosition: Offset.zero,
    this.initialSize: Size.zero,
  @required this.child,
    this.color: Colors.blueAccent,
  }):super(key: key);

  @override
  WindowState createState() => WindowState();
}

class WindowState extends State<Window> {
  /// The window's position.
  Offset _position;

  /// The window's size.
  Size _size;

  /// The window's child.
  Widget _child;

  /// The window's color.
  Color _color;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
    _size = widget.initialSize;
    _child = widget.child;
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Container(
        width: _size.width,
        height: _size.height,
        decoration: BoxDecoration(boxShadow: kElevationToShadow[12]),
        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details){
                setState(() {
                  _position += details.delta;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                height: 35.0,
                color: _color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.minimize,color: Colors.white),
                    Icon(Icons.crop_square,color: Colors.white),
                    Icon(Icons.close,color: Colors.white),
                  ],
                )
              ),
            ),
            Expanded(
              child:
              GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _size += details.delta;
                  });
                },
                child: _child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}