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

//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'model.dart';
import 'package:flutter/material.dart';
import 'window/model.dart';
import 'window/window.dart';
import 'themes/main.dart';
import 'package:provider/provider.dart';

/// Displays a set of windows.
class WindowPlaygroundWidget extends StatefulWidget {
  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<WindowPlaygroundWidget> {
  WindowsData _windows;
//    ..add(
//      color: Colors.green[700],
//      child: Calculator(),
//    )
//     ..add(
//      color: Colors.amber[700],
//      child: TextEditorApp(),
//    )
//    ..add(
//      color: Colors.grey[900],
//      child: Terminal(),
//    )
//    ..add(
//      color: Colors.deepOrange[500],
//      child: Settings(),
//    )
//

  ///Throws 'soft' exception //TODO: Dear Haru, think about your crimes. Love, Haru.
//  @override
//  void initState() {
//    super.initState();
//
//    _windows = widget._app..add(color: Colors.red[800], child: HisApp());
//  }

  //..add(); //adds default purple window, see widget/model.dart
  final Map<WindowId, GlobalKey<WindowState>> _windowKeys =
      Map<WindowId, GlobalKey<WindowState>>();
  final FocusScopeNode _focusNode = FocusScopeNode();

  /// Currently highlighted window when paging through windows.
  WindowId _highlightedWindow;

  /*@override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    _focusNode.detach();
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    super.dispose();
  }

  /// Interprets key chords.
  void _handleKeyEvent(RawKeyEvent event) {
    final bool isDown = event is RawKeyDownEvent;
    final RawKeyEventDataFuchsia data = event.data;
    // Switch the focused window with Ctrl-(Shift-)A
    if (isDown &&
            (data.codePoint == 97 || data.codePoint == 65) // a or A
            &&
            (data.modifiers & 24) != 0 // Ctrl down
        ) {
      setState(() {
        _highlightedWindow = _windows.next(
          id: _highlightedWindow ?? _windows.windows.last.id,
          forward: data.codePoint == 65, // A means shift is down
        );
      });
    } else if (!isDown && (data.codePoint == 97 || data.codePoint == 65)) {
      setState(() {
        if (_highlightedWindow != null) {
          _windows.moveToFront(_windows.find(_highlightedWindow));
          _windowKeys[_highlightedWindow].currentState.focus();
          _highlightedWindow = null;
        }
      });
    }
  }*/

  /// Builds the widget representations of the current windows.
  List<Widget> _buildWindows(
      WindowsData model, double maxWidth, double maxHeight) {
    // Remove keys that are no longer useful.
    List<WindowId> obsoleteIds = List<WindowId>();
    _windowKeys.keys.forEach((WindowId id) {
      if (!model.windows.any((WindowData window) => window.id == id)) {
        obsoleteIds.add(id);
      }
    });
    obsoleteIds.forEach((WindowId id) => _windowKeys.remove(id));

    // Adjust window order if there's a highlighted window.
    final List<WindowData> windows = List<WindowData>.from(model.windows);
    if (_highlightedWindow != null) {
      final WindowData window = model.find(_highlightedWindow);
      if (window != null) {
        windows.remove(window);
        windows.add(window);
      }
    }

    return windows
        .map((WindowData window) => ScopedModel<WindowData>(
              model: window,
              child: Window(
                key: _windowKeys.putIfAbsent(
                  window.id,
                  () => GlobalKey<WindowState>(),
                ),
                initialPosition: Offset(maxWidth / 4, maxHeight / 4),
                initialSize: Size(maxWidth / 2, maxHeight / 2),
                onWindowInteraction: () => model.moveToFront(window),
                onWindowClose: () => model.close(window),
                color: window.color,
                child: window.child,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _windows = Provider.of<WindowsData>(context);

          // Multiplying maxWidth by 1.4 & maxHeight by 1.2 to avoid overflow on
          // smaller screens.
          final double width = constraints.maxWidth * 1.4;
          final double height = constraints.maxHeight * 1.2;
          return Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (BuildContext context) => FocusScope(
                  node: _focusNode,
                  autofocus: true,
                  child: ScopedModel<WindowsData>(
                    model: _windows,
                    child: ScopedModelDescendant<WindowsData>(
                      builder: (
                        BuildContext context,
                        Widget child,
                        WindowsData model,
                      ) =>
                          Stack(
                        children: <Widget>[
                          /* DragTarget<TabId>(
                                    builder: (BuildContext context,
                                            List<TabId> candidateData,
                                            List<dynamic> rejectedData) =>
                                         Container(),
                                    onAccept: (TabId id) => model.add(id: id),
                                  )*/
                        ]..addAll(_buildWindows(model, width, height)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
}
