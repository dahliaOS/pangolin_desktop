import 'package:flutter/material.dart';

void main() {
  runApp(new TerminalApp());
}
class TerminalApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new Terminal(),
    );
  }
}

class Terminal extends StatefulWidget {
  Terminal({Key key}) : super(key: key);
  @override
  _TerminalState createState() => new _TerminalState();
}

class _TerminalState extends State<Terminal> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:
          
        
        
       new Column(children: [
      Container(
          height: 55,
          color: Color(0xff292929),
          child: Row(children: [
            MaterialButton(
              onPressed:null,
              child: Icon(Icons.add, size: 25, color: Color(0xffffffff))),
            
            Expanded(
                child: Center(
                    child: Text('Terminal',
                       style: TextStyle(
                            fontSize: 18, color: Color(0xffffffff))))),
            
            MaterialButton(
              onPressed:null,
                child:
                    Icon(Icons.settings, size: 25, color: Color(0xffffffff))),
            MaterialButton(
              onPressed:null,
                child:
                    Icon(Icons.more_vert, size: 25, color: Color(0xffffffff)))
          ])),
         new Expanded(child: 
         
          new Padding(
            child:
new TextFormField(
 style:    
         TextStyle(fontSize:15.0,
            color: const Color(0xFFf2f2f2),
            
            fontFamily: "Cousine",),
          decoration: InputDecoration.collapsed(hintText: ""),
          autocorrect: false,
          minLines: null,
          maxLines: null,
          expands: true,
          initialValue: "debug_shell \$",
    cursorColor: const Color(0xFFf2f2f2),
  cursorRadius: Radius.circular(0.0),
  cursorWidth: 10.0,
        ),
padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
          ),
         
         
         ),
          
    ]),        
        
        
          );
      
    }
}


