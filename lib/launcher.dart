import 'package:flutter/material.dart';
import 'searchbar.dart';

import 'cards.dart';








class LauncherWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFFeeeeee),
      ),
      home: launcher(title: 'Launcher'),
    );
  }
}

class launcher extends StatefulWidget {
  launcher({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _launcherState createState() => _launcherState();
}

class _launcherState extends State<launcher> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      body: Center(
      
        child: Column(
         
          //mainAxisAlignment: MainAxisAlignment.top,
          children: <Widget>[
           new SearchWidget(),
          
              
              
              new SingleChildScrollView(
                padding: new EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
     
  scrollDirection: Axis.horizontal,
  child: new Row(
   children: <Widget>[
       
       
    
       
       
       new SysInfoCard(),
       new NewsCard(),
       new NewsCard(),
       new NewsCard(),
       new NewsCard(),
       
       
    
       
      
       
       
       
       
       
       
       
       
   ]
  )
),
              
              
             








 new Text(
          "qWerty1",
            style: new TextStyle(fontSize:12.0,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.w200,
            fontFamily: "Roboto"),
          ),


             
    

       
              
              
              
          ],
        ),
      ),
      
    );
  }
}
