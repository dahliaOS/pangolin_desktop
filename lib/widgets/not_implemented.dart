import 'package:flutter/material.dart';

void notImplemented(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
            /* LocaleStrings.pangolin.featurenotimplementedTitle */ "Error"),
        content: new Text(
            /* LocaleStrings.pangolin.featurenotimplementedValue */ "Not Implemented"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
