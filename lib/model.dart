// Copyright 2016 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';

/// Base class for classes that provide data via [InheritedWidget]s.
abstract class Model {
  final Set<VoidCallback> _listeners = new Set<VoidCallback>();
  int _version = 0;
  int _microtaskVersion = 0;

  /// [listener] will be notified when the model changes.
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// [listener] will no longer be notified when the model changes.
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Returns the number of listeners listening to this model.
  int get listenerCount => _listeners.length;

  /// Should be called only by [Model] when the model has changed.
  void notifyListeners() {
    // We schedule a microtask as it's not uncommon for changes that trigger
    // listener notifications to occur in a build step and for listeners to
    // call setState.  Its a big no-no to setState during build so we schedule
    // for them to happen later.
    // TODO(apwilson): This is a bad-flutter-code-smell. Eliminate the need for
    // this scheduleMicrotask.
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;
        _listeners.toList().forEach((VoidCallback listener) => listener());
      });
    }
  }
}

/// Finds a [Model].  This class is necessary as templated classes are relified
/// but static templated functions are not.
class ModelFinder<T extends Model> {
  /// Returns the [Model] of type [T] of the closest ancestor [ScopedModel].
  ///
  /// [Widget]s who call [of] with a [rebuildOnChange] of true will be rebuilt
  /// whenever there's a change to the returned model.
  T of(BuildContext context, {bool rebuildOnChange: false}) {
    final Type type = new _InheritedModel<T>.forRuntimeType().runtimeType;
    Widget widget = rebuildOnChange
        ? context.inheritFromWidgetOfExactType(type)
        : context.ancestorWidgetOfExactType(type);
    return (widget is _InheritedModel<T>) ? widget.model : null;
  }
}

/// Allows the given [model] to be accessed by [child] or any of its descendants
/// using [ModelFinder].
class ScopedModel<T extends Model> extends StatelessWidget {
  /// The [Model] to provide to [child] and its descendants.
  final T model;

  /// The [Widget] the [model] will be available to.
  final Widget child;

  /// Constructor.
  ScopedModel({this.model, this.child});

  @override
  Widget build(BuildContext context) => new _ModelListener(
        model: model,
        builder: (BuildContext context) => new _InheritedModel<T>(
              model: model,
              child: child,
            ),
      );
}

/// Listens to [model] and calls [builder] whenever [model] changes.
class _ModelListener extends StatefulWidget {
  final Model model;
  final WidgetBuilder builder;

  _ModelListener({this.model, this.builder});

  @override
  _ModelListenerState createState() => new _ModelListenerState();
}

class _ModelListenerState extends State<_ModelListener> {
  @override
  void initState() {
    super.initState();
    widget.model.addListener(_onChange);
  }

  @override
  void didUpdateWidget(_ModelListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_onChange);
      widget.model.addListener(_onChange);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);

  void _onChange() => setState(() {});
}

/// Provides [model] to its [child] [Widget] tree via [InheritedWidget].  When
/// [version] changes, all descendants who request (via
/// [BuildContext.inheritFromWidgetOfExactType]) to be rebuilt when the model
/// changes will do so.
class _InheritedModel<T extends Model> extends InheritedWidget {
  final T model;
  final int version;
  _InheritedModel({Key key, Widget child, T model})
      : this.model = model,
        this.version = model._version,
        super(key: key, child: child);

  /// Used to return the runtime type.
  _InheritedModel.forRuntimeType()
      : this.model = null,
        this.version = 0;

  @override
  bool updateShouldNotify(_InheritedModel<T> oldWidget) =>
      (oldWidget.version != version);
}

/// Builds a child for a [ScopedModelDescendant].
typedef Widget ScopedModelDescendantBuilder<T extends Model>(
  BuildContext context,
  Widget child,
  T model,
);

/// A [Widget] who rebuilds its child by calling [builder] whenever the [Model]
/// provided by an ancestor [ScopedModel] changes.
class ScopedModelDescendant<T extends Model> extends StatelessWidget {
  /// Called whenever the [Model] changes.
  final ScopedModelDescendantBuilder<T> builder;

  /// An optional constant child that depends on the model.  This will be passed
  /// as the child of [builder].
  final Widget child;

  /// Constructor.
  ScopedModelDescendant({this.builder, this.child});

  @override
  Widget build(BuildContext context) => builder(
        context,
        child,
        new ModelFinder<T>().of(context, rebuildOnChange: true),
      );
}
