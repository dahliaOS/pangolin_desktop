/*
Copyright 2019 The dahliaOS Authors

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

import 'package:Pangolin/applications/files/hover.dart';
import 'package:Pangolin/commons/functions.dart';
import 'package:flutter/material.dart';
import '../model.dart';
import 'model.dart';

/// Signature of window interaction callbacks.
typedef void WindowInteractionCallback();

/// A window container
class Window extends StatefulWidget {
  /// The window's initial position.
  final Offset initialPosition;

  /// The window's initial size.
  final Size initialSize;

  /// Called when the user started interacting with this window.
  final WindowInteractionCallback onWindowInteraction;

  /// Called when the user clicks close button in this window.
  final WindowInteractionCallback onWindowClose;

  /// The window's child.
  final dynamic child;

  /// The window's theme color.
  final Color color;

  /// The window's custom bar, if there is one.
  Widget customBar;

  /// Constructor.
  Window({
    Key key,
    this.onWindowInteraction,
    this.onWindowClose,
    this.initialPosition: Offset.zero,
    this.initialSize: Size.zero,
    @required this.child,
    this.color: Colors.blueAccent,
  }) : super(key: key);

  @override
  WindowState createState() => WindowState();
}

/// The window's mode.
enum WindowMode { NORMAL_MODE, MAXIMIZE_MODE, MINIMIZE_MODE }

class WindowState extends State<Window> {
  /// The window's position.
  Offset _position;

  /// The window's position before maximizing.
  Offset _prePosition;

  /// The window's size.
  Size _size;

  /// The window's size before maximizing.
  Size _preSize;

  /// The windows's current mode.
  WindowMode _windowMode = WindowMode.NORMAL_MODE;

  /// The window's child.
  dynamic _child;

  /// The window's color.
  Color _color;

  /// The window's minimum height.
  final double _minHeight = 400.0;

  /// The window's minimum width.
  final double _minWidth = 600.0;

  /// Controls focus on this window.
  final FocusNode _focusNode = new FocusNode();

  /// Control is an illusion so let's make it a big one
  FocusAttachment _focusAttachment;

  static bool isMaximized = false;

  @override
  void initState() {
    super.initState();
    _focusAttachment = _focusNode.attach(context);
    _position = widget.initialPosition;
    _size = widget.initialSize;
    _child = widget.child;
    _color = widget.color;
  }

  @override
  void dispose() {
    _focusAttachment.detach();
    _focusNode.dispose();
    super.dispose();
  }

  /// Requests this window to be focused.
  void focus() => _focusNode.requestFocus();

  void _registerInteraction() {
    widget.onWindowInteraction?.call();
    focus();
  }

  void _maximizeWindow() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = true;
      _windowMode = WindowMode.MAXIMIZE_MODE;
      _prePosition = _position;
      _preSize = _size;
      _position = Offset(0, 0);
      _size = Size(deviceSize.width, deviceSize.height - 45);
    });
  }

  void _dockWindowLeft() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = true;
      _windowMode = WindowMode.MAXIMIZE_MODE;
      _prePosition = _position;
      _preSize = _size;
      _position = Offset(0, 0);
      _size = Size(deviceSize.width / 2, deviceSize.height - 45);
    });
  }

  void _dockWindowRight() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = true;
      _windowMode = WindowMode.MAXIMIZE_MODE;
      _prePosition = _position;
      _preSize = _size;
      _position = Offset(deviceSize.width / 2, 0);
      _size = Size(deviceSize.width / 2, deviceSize.height - 45);
    });
  }

  void _dockWindowUp() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = true;
      _windowMode = WindowMode.MAXIMIZE_MODE;
      _prePosition = _position;
      _preSize = _size;
      _position = Offset(0, 0);
      _size = Size(deviceSize.width, deviceSize.height / 2);
    });
  }

  void _dockWindowDown() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = true;
      _windowMode = WindowMode.MAXIMIZE_MODE;
      _prePosition = _position;
      _preSize = _size;
      _position = Offset(0, deviceSize.height / 2);
      _size = Size(deviceSize.width, (deviceSize.height / 2) - 45);
    });
  }

  void _restoreWindowFromMaximizeMode() {
    setState(() {
      isMaximized = false;
      _windowMode = WindowMode.NORMAL_MODE;
      _size = _preSize;
      _position = _prePosition;
    });
  }

  void _restoreWindowFromDock() {
    Size deviceSize = MediaQuery.of(context).size;
    setState(() {
      isMaximized = false;
      _windowMode = WindowMode.NORMAL_MODE;
      _size = Size(deviceSize.width / 2, deviceSize.height / 2);
      _position = _prePosition;
    });
  }

  void _alertFunctional() {
    setState(() {
      isMaximized = false;
      _windowMode = WindowMode.NORMAL_MODE;
      _size = _preSize;
      _position = _prePosition;
    });
  }

  void _closeWindow() {
    widget.onWindowClose?.call();
  }

  bool hoverClose = false;
  bool hoverMaximize = false;
  bool hoverLeftRight = false;
  bool hoverUpDown = false;

  @override
  Widget build(BuildContext context) =>
      ScopedModelDescendant<WindowData>(builder: (
        BuildContext context,
        Widget child,
        WindowData model,
      ) {
        // Make sure the focus tree is properly updated.
        _focusAttachment.reparent();
        /*if (model.tabs.length == 1 && model.tabs[0].id == _draggedTabId) {
          // If the lone tab is being dragged, hide this window.
          return new Container();
        }
        final TabData selectedTab = _getCurrentSelection(model);*/
        Widget Function(
            {

            /// The function called to close the window.
            Function close,

            /// The function called to minimize the window.
            Function minimize,

            /// The function called to maximize or restore the window.
            Function maximize,

            /// The getter to determine whether or not the window is maximized.
            bool Function() maximizeState}) customBar;
        try {
          customBar = widget.child.customBar;
          widget.customBar = widget.child.customBar;
        } catch (e) {}
        try {
          setState(() {
            _color = widget.child.customBackground;
          });
        } catch (e) {}
        return Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onTapDown: (_) => _registerInteraction(),
            child:
                /*new RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) =>
        _handleKeyEvent(event, model, selectedTab.id),
        child: new*/
                //check to see if there's a customBar property in the passed app class
                RepaintBoundary(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        var _newSize = _size + details.delta;
                        if (_newSize.width >= _minWidth &&
                            _newSize.height >= _minHeight)
                          _size += details.delta;
                      });
                    },
                    child: Hover(
                      opacity: 0.8,
                      child: Container(
                        width: (_windowMode == WindowMode.MAXIMIZE_MODE)
                            ? _size.width
                            : _size.width + 20,
                        height: (_windowMode == WindowMode.MAXIMIZE_MODE)
                            ? _size.height
                            : _size.height + 20,
                        //color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    width: _size.width,
                    height: _size.height,
                    constraints: BoxConstraints(
                        minWidth: _minWidth, minHeight: _minHeight), //
                    decoration:
                        BoxDecoration(boxShadow: kElevationToShadow[12]),
                    child: Column(
                      children: [
                        GestureDetector(
                          onPanUpdate: (DragUpdateDetails details) {
                            setState(() {
                              _position += details.delta;
                              if (_windowMode == WindowMode.MAXIMIZE_MODE) {
                                _windowMode = WindowMode.NORMAL_MODE;
                                _size = _preSize;
                              }
                            });
                          },
                          onDoubleTap: () {
                            _windowMode == WindowMode.NORMAL_MODE
                                ? _maximizeWindow()
                                : _restoreWindowFromMaximizeMode();
                          },
                          child: customBar != null
                              ? customBar(
                                  close: _closeWindow,
                                  maximize: () =>
                                      _windowMode == WindowMode.NORMAL_MODE
                                          ? _maximizeWindow()
                                          : _restoreWindowFromMaximizeMode(),
                                  minimize: () => null, // for now
                                  maximizeState: () =>
                                      _windowMode == WindowMode.MAXIMIZE_MODE
                                          ? true
                                          : false)
                              : Container(
                                  decoration: BoxDecoration(
                                    color: _color,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular((_windowMode ==
                                                WindowMode.MAXIMIZE_MODE)
                                            ? 0
                                            : 5),
                                        topRight: Radius.circular(
                                            (_windowMode ==
                                                    WindowMode.MAXIMIZE_MODE)
                                                ? 0
                                                : 5)),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  height: 35.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      upDownButton(),
                                      SizedBox(width: 3.0),
                                      leftRightButton(),
                                      SizedBox(width: 3.0),
                                      maximizeButton(),
                                      SizedBox(width: 3.0),
                                      closeButton()
                                    ],
                                  )),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    (_windowMode == WindowMode.MAXIMIZE_MODE)
                                        ? 0
                                        : 5),
                                bottomRight: Radius.circular(
                                    (_windowMode == WindowMode.MAXIMIZE_MODE)
                                        ? 0
                                        : 5)),
                            child: (_child is Widget)
                                ? _child
                                : Text("ERROR: Window is not a Widget!"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  MouseRegion closeButton() {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hoverClose = true;
        });
      },
      onExit: (event) {
        setState(() {
          hoverClose = false;
        });
      },
      child: GestureDetector(
        onTap: () => _closeWindow(),
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: hoverClose
                  ? Colors.grey[800].withOpacity(0.3)
                  : Colors.grey[800].withOpacity(0.0),
            ),
            child: Icon(Icons.close, color: Colors.white, size: 20)),
      ),
    );
  }

  MouseRegion maximizeButton() {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hoverMaximize = true;
        });
      },
      onExit: (event) {
        setState(() {
          hoverMaximize = false;
        });
      },
      child: GestureDetector(
        onTap: () => _windowMode == WindowMode.NORMAL_MODE
            ? _maximizeWindow()
            : _restoreWindowFromMaximizeMode(),
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: hoverMaximize
                  ? Colors.grey[800].withOpacity(0.3)
                  : Colors.grey[800].withOpacity(0.0),
            ),
            child:
                Icon(Icons.crop_square_sharp, color: Colors.white, size: 20)),
      ),
    );
  }

  MouseRegion upDownButton() {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hoverUpDown = true;
        });
      },
      onExit: (event) {
        setState(() {
          hoverUpDown = false;
        });
      },
      child: GestureDetector(
        onTap: () => _windowMode == WindowMode.NORMAL_MODE
            ? _restoreWindowFromDock()
            : _restoreWindowFromDock(),
        /* onLongPress: () => _windowMode == WindowMode.NORMAL_MODE
            ? _dockWindowRight()
            : _restoreWindowFromMaximizeMode(),*/
        onPanUpdate: (details) {
          /*  if (details.delta.dx > 0)
            //right drag
            _dockWindowRight();
          else
            //left drag

            _dockWindowLeft();*/

          if (details.delta.dy > 0)
            //upwards drag
            _dockWindowDown();
          else
            //downwards drag
            _dockWindowUp();
        },
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: hoverUpDown
                  ? Colors.grey[800].withOpacity(0.3)
                  : Colors.grey[800].withOpacity(0.0),
            ),
            child: Icon(Icons.unfold_more, color: Colors.white, size: 20)),
      ),
    );
  }

  MouseRegion leftRightButton() {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hoverLeftRight = true;
        });
      },
      onExit: (event) {
        setState(() {
          hoverLeftRight = false;
        });
      },
      child: GestureDetector(
        onTap: () => _windowMode == WindowMode.NORMAL_MODE
            ? _restoreWindowFromDock()
            : _restoreWindowFromDock(),
        /* onLongPress: () => _windowMode == WindowMode.NORMAL_MODE
            ? _dockWindowRight()
            : _restoreWindowFromMaximizeMode(),*/
        onPanUpdate: (details) {
          if (details.delta.dx > 0)
            //right drag
            _dockWindowRight();
          else
            //left drag

            _dockWindowLeft();
/*
          if (details.delta.dy > 0)
            //upwards drag
            _dockWindowDown();
          else
            //downwards drag
            _dockWindowUp();*/
        },
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: hoverLeftRight
                  ? Colors.grey[800].withOpacity(0.3)
                  : Colors.grey[800].withOpacity(0.0),
            ),
            child: Transform.rotate(
                angle: 90 * 3.14 / 180,
                child: Icon(Icons.unfold_more, color: Colors.white, size: 20))),
      ),
    );
  }
}
