// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'animated_content_builder.dart';

/// Base class for UI elements behaving as toggles.
class Toggle extends StatefulWidget {
  final AnimatedContentBuilder _builder;
  final ValueChanged<bool> _callback;

  /// Constructor.
  Toggle({Key key, AnimatedContentBuilder builder, ValueChanged<bool> callback})
      : _builder = builder,
        _callback = callback,
        super(key: key);

  @override
  ToggleState createState() => new ToggleState();
}

/// Manages the state of a [Toggle].
class ToggleState extends State<Toggle> with TickerProviderStateMixin {
  bool _toggled = false;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => new RepaintBoundary(
        child: new GestureDetector(
          onTap: () {
            setState(() {
              toggled = !_toggled;
              widget._callback?.call(_toggled);
            });
          },
          behavior: HitTestBehavior.opaque,
          child: widget._builder(_animation),
        ),
      );

  /// Sets the toggle state.
  set toggled(bool value) {
    if (value == _toggled) {
      return;
    }
    setState(() {
      _toggled = value;
      _toggled ? _controller.forward() : _controller.reverse();
    });
  }
}
