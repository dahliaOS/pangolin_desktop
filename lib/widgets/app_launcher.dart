import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../window/model.dart';
import 'package:random_color/random_color.dart';

class AppLauncherButton extends StatelessWidget {
  Widget app;
  Image icon;
  bool appExists;

  AppLauncherButton(this.app, this.icon, {this.appExists = true});

  @override
  Widget build(BuildContext context) {
    return new
SizedBox(
  width: 64.0,
  height: 64.0,
  child:
     FlatButton(
      
      child: icon,
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
}
