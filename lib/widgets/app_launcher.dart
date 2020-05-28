import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../window/model.dart';
import 'package:random_color/random_color.dart';

class AppLauncherButton extends StatelessWidget {
  final Widget app;
  final String icon;
  final bool appExists;
  final double childHeight;
  final double childWidth;

  AppLauncherButton(this.app, this.icon,
      {this.appExists = true, this.childHeight = 60.0, this.childWidth = 60.0});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: appExists ? 1.0 : 0.4,
      child: new FlatButton(
        child: Image.asset(
          icon,
          fit: BoxFit.contain,
          width: childWidth,
          height: childHeight,
        ),
        onPressed: () {
          (appExists)
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
                          },
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }

  /// Creates a copy of this [AppLauncherButton] but with the given fields replaced with
  /// the new values.
  AppLauncherButton copyWith({double childWidth, double childHeight}) {
    return AppLauncherButton(
      this.app,
      this.icon,
      childHeight: childWidth,
      childWidth: childHeight,
    );
  }
}
