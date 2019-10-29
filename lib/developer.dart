import 'package:flutter/material.dart';

class Desktop extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(4293848814),
        
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


          new Container(
            child:
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                  "Enable Developer Options",
                    style: new TextStyle(
                    color: const Color(0xFF000000),
                    fontFamily: "Roboto"),
                  ),
    
                  new Switch(onChanged: switchChanged, value:true)
                  
                ]
    
              ),
    
             color: Colors.grey[500],
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.center,
            width: 1.7976931348623157e+308,
            height: 40.0,
          ),
    
   
            ]),
        appBar: AppBar(
            backgroundColor: Colors.red[700],
            title: Text('Developer Options', style: TextStyle()),
            leading: Center(child: Icon(Icons.warning))));
  }
}
 void switchChanged(bool value) {}

