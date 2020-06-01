import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../window/model.dart';
import 'package:random_color/random_color.dart';

class AppLauncherPanelButton extends StatelessWidget {
  final Widget app;
  final String icon;
  final bool appExists;
  final double childHeight;
  final double childWidth;
  final Color color;

  AppLauncherPanelButton(
      {this.app,
      this.icon,
      this.appExists = true,
      this.childHeight = 35.0,
      this.childWidth = 35.0,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Opacity(
          opacity: appExists ? 1.0 : 0.4,
          child: GestureDetector(
            onTap: () {
              print(appExists);

              appExists
                  ? Provider.of<WindowsData>(context, listen: false)
                      .add(child: app, color: RandomColor().randomColor())
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
              padding: EdgeInsets.all(0),
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
                width: childWidth,
                height: childHeight,
              ),
            ),
          ),
        ))
      ],
    );
  }

  /// Creates a copy of this [AppLauncherPanelButton] but with the given fields replaced with
  /// the new values.
  AppLauncherPanelButton copyWith({double childWidth, double childHeight}) {
    return AppLauncherPanelButton(
      app: this.app,
      icon: this.icon,
      childHeight: childWidth,
      childWidth: childHeight,
    );
  }
}

class AppLauncherDrawerButton extends AppLauncherPanelButton {
  final Widget app;
  final String icon;
  final bool appExists;
  final double childHeight;
  final double childWidth;
  final String label;

  AppLauncherDrawerButton(
      {this.app,
      this.icon,
      this.label,
      this.appExists = true,
      this.childHeight = 64.0,
      this.childWidth = 64.0});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Opacity(
          opacity: appExists ? 1.0 : 0.4,
          child: GestureDetector(
            onTap: () {
              print(appExists);

              appExists
                  ? Provider.of<WindowsData>(context, listen: false)
                      .add(child: app, color: RandomColor().randomColor())
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
              padding: EdgeInsets.all(0),
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
                width: childWidth,
                height: childHeight,
              ),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: appExists ? Colors.white : Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
