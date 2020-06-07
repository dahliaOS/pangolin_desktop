import 'package:flutter/material.dart';

class MonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: 
        
        new Column(children: [

 Container(
            height: 45,
            color: Color(0xff00838f),
            child: Row(children: [
              new Expanded(child: 
              new Container(
                  width: 256,
                  child: Row(children: [
                    new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 10, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('PROCESSES',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),

                new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 5, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('RESOURCES',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),




                                    new Container(
                        width: 125,
                        height: 40,
                        
                        margin: EdgeInsets.only(
                            left: 5, right: 0, bottom: 0, top: 10),
                      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
          
                    topLeft:  const  Radius.circular(5.0),
                    topRight: const  Radius.circular(5.0),
            
          ),
          color: Colors.white,),
                        child: MaterialButton(
                          onPressed:null,
                            child: Text('CONTAINERS',
                                style: TextStyle(
                                    color: Color(0xff222222),
                                    fontWeight: FontWeight.w400)))),
                
                
                  ])),),
              
             new IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:null,
            iconSize: 25.0,
            color: const Color(0xFFffffff),
          ), 
             
            ])),

new Expanded(child: new Row(children: [





  
],),)


        ],)
       );
  }
}

void main() {
  runApp(new Tasks());
}
class Tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);
  @override
  _TasksState createState() => new _TasksState();
}

class _TasksState extends State<TasksPage> {
    @override
    Widget build(BuildContext context) {
      return new MonitorApp();
    }
}