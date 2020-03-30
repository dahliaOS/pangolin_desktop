import 'package:flutter/material.dart';

class Desktop extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: 400.0,
          height: 50.0,
          color: Color(2566914047),
          padding:
              EdgeInsets.only(left: 15.0, right: 0.0, bottom: 0.0, top: 0.0),
          margin: EdgeInsets.all(75.0),
          child: Row(children: [
            Icon(Icons.search),
            Text('Search ',
                style: TextStyle(
                    color: Color(4294967295),
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal))
          ])),
      Container(
          width: 128.0,
          height: 128.0,
          child: Column(children: [
            Image(width: 64.0, height: 64.0, fit: BoxFit.cover),
            Text('Application',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(4294967295), fontSize: 20.0))
          ]))
    ]);
  }
}
