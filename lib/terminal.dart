import 'package:flutter/material.dart';

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
                  color: Colors.grey[850],
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,



                  child:  
                  
                  new Padding(
            child:
             new    Text(
                      "Terminal",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
    
            padding: const EdgeInsets.all(17.0),
                  
               
              
                
                ),
                ),


 
  

          new Padding(
            child:
new TextFormField(
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            
            fontFamily: "monospace",),
          decoration: InputDecoration.collapsed(hintText: ""),
          autocorrect: false,
          minLines: null,
          maxLines: null,
          expands: true,
          initialValue: "debug_shell \$"
        ),
padding: const EdgeInsets.fromLTRB(0.0, 55.0, 0.0, 0.0),
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

class Terminal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: const Color(0xFFff5722),
        accentColor: const Color(0xFFff5722),
        canvasColor: const Color(0xFF222222),
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


