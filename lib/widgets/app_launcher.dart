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

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../window/model.dart';

class AppLauncherButton extends StatefulWidget {
  final Widget app;
  final String icon;
  final bool appExists;
  final bool customBar;
  final double childHeight;
  final double childWidth;
  final String label;
  final AppLauncherButtonType type;
  final ValueChanged<bool> _callback;

  AppLauncherButton(
      {this.app,
      @required this.icon,
      this.label,
      this.type = AppLauncherButtonType.TaskBar,
      this.appExists = true,
      this.customBar = true,
      this.childHeight = 64.0,
      this.childWidth = 64.0,
      callback})
      : _callback =
            callback; //This alien syntax must be syntactical glucose for a setter. Neato.

  @override
  AppLauncherButtonState createState() => AppLauncherButtonState();
}

class AppLauncherButtonState extends State<AppLauncherButton> {
  bool _toggled = false;
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (widget.type == AppLauncherButtonType.Drawer)
            ? EdgeInsets.all(30.0)
            : EdgeInsets.symmetric(horizontal: 4.0),
        width: (widget.type == AppLauncherButtonType.Drawer) ? 64.0 : 45.0,
        height: (widget.type == AppLauncherButtonType.Drawer) ? 64.0 : 45.0,
        decoration: BoxDecoration(
            borderRadius: (widget.type == AppLauncherButtonType.Drawer)
                ? BorderRadius.circular(30)
                : BorderRadius.circular(0),
            color: hover
                ? (widget.appExists
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1))
                : Colors.grey.withOpacity(0.0)),
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              hover = true;
            });
          },
          onExit: (event) {
            setState(() {
              hover = false;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Opacity(
                opacity: widget.appExists ? 1.0 : 0.4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      toggled = !_toggled;
                      widget._callback?.call(_toggled);
                    });

                    widget.appExists
                        ? Provider.of<WindowsData>(context, listen: false)
                            .add(child: widget.app, color: Colors.grey[900])
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                  title: new Text("Feature not implemented"),
                                  content: new Text(
                                      "This feature is currently not available on your build of Pangolin. Please see https://reddit.com/r/dahliaos to check for updates."),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                  },
                  child: Container(
                    child: Image.asset(
                      widget.icon,
                      fit: BoxFit.contain,
                      width: (widget.type == AppLauncherButtonType.Drawer)
                          ? 64.0
                          : 34.0,
                      height: (widget.type == AppLauncherButtonType.Drawer)
                          ? 64.0
                          : 34.0,
                    ),
                  ),
                ),
              ),
              (widget.type == AppLauncherButtonType.Drawer)
                  ? Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color:
                            widget.appExists ? Colors.white : Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }

  set toggled(bool value) {
    if (value == _toggled) {
      return;
    }
  }
}

enum AppLauncherButtonType { Drawer, TaskBar }
