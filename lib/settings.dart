import 'package:flutter/material.dart';
import 'dart:convert';

   class CustomBarWidget extends StatelessWidget {

      GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            height: 1.7976931348623157e+308,
            child: Stack(
              children: <Widget>[

               
                Container(
                  color: const Color(0xFFf5f5f5),
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,



                  child:
                  
                  new Padding(
            child:
             new    Text(
                      "Settings",
                      style: TextStyle(color: Colors.deepOrange[500], fontSize: 18.0),
                    ),
    
            padding: const EdgeInsets.all(17.0),
                  
               
              
                
                ),
                ),
                
                
                new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.red
              ),
              
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.deepOrange
              ),
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.yellow
              ),
              
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.amber
              ),
              
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.green
              ),
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.blue
              ),
              
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.indigo
              ),
              
              new FlutterLogo(
                size: 50.0,
                colors: Colors.pink
              ),
              
              
              
              
            ]
    
          ),



 
  

                

              ],
            ),
          ),
        );
      }
    }


/*void main() {
  runApp(new MyApp());
}*/

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFFffffff),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:
          

         
new CustomBarWidget(),


           
    
         
    




          

    
      );
    }
}


