import 'package:flutter/material.dart';
import '../model.dart';
import 'model.dart';

/// Signature of window interaction callbacks.
typedef void WindowInteractionCallback();

/// A window container
class Window extends StatefulWidget{
  /// The window's initial position.
  final Offset initialPosition;

  /// The window's initial size.
  final Size initialSize;

  /// Called when the user started interacting with this window.
  final WindowInteractionCallback onWindowInteraction;

  /// The window's child.
  final Widget child;

  //TODO: get the color from child's material app primary swatch
  /// The window's theme color.
  final Color color;

  /// Constructor.
  Window({
    Key key,
    this.onWindowInteraction,
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

  /// Controls focus on this window.
  final FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
    _size = widget.initialSize;
    _child = widget.child;
    _color = widget.color;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// Requests this window to be focused.
  void focus() => FocusScope.of(context).requestFocus(_focusNode);

  void _registerInteraction() {
    widget.onWindowInteraction?.call();
    focus();
  }

  @override
  Widget build(BuildContext context) => ScopedModelDescendant<WindowData>(
      builder: (
          BuildContext context,
          Widget child,
          WindowData model,
          ) {
        // Make sure the focus tree is properly updated.
        FocusScope.of(context).reparentIfNeeded(_focusNode);
        /*if (model.tabs.length == 1 && model.tabs[0].id == _draggedTabId) {
          // If the lone tab is being dragged, hide this window.
          return new Container();
        }
        final TabData selectedTab = _getCurrentSelection(model);*/
  return Positioned(
      left: _position.dx,
      top: _position.dy,

      child:GestureDetector(
      onTapDown: (_) => _registerInteraction(),
        child: /*new RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) =>
        _handleKeyEvent(event, model, selectedTab.id),
        child: new*/ RepaintBoundary(
        child:

        Container(
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
        ),
      ),
    );
  }
  );
}