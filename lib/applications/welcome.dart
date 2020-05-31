import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Container(
                  padding: EdgeInsets.all(5),
                 
                  color: Colors.amber[500],
                  child: Row(children: [
                    Icon(Icons.warning, color: Color(0xff222222),),
                    Text(
                        ' Warning: You are on a pre-release build of dahliaOS. For your protection, this build has been airgapped. ',
                        overflow: TextOverflow.visible,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff222222)))
                  ]))),
          Container(
              width: 200,
              height: 100,
              color: Color(0xffcc4646),
              margin: EdgeInsets.only(left: 50, right: 0, bottom: 20, top: 20),
              child:  new Image.asset(
       'images/logo-color.png',
        fit: BoxFit.fill,
        width: 100,
        height: 64.0,
      ),
              ),
        ]));
  }
}
