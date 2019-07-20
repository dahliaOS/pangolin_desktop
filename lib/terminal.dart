import 'package:flutter/material.dart';

   class CustomBarWidget extends StatelessWidget {

      GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            height: 160.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.grey[850],
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,
                  child:  Text(
                      "Terminal",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
              
                
                )
              ],
            ),
          ),
        );
      }
    }


/*void main() {
  runApp(new MyApp());
}*/

class Terminal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFFfafafa),
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


