import 'package:flutter/material.dart';


class SearchWidget extends StatelessWidget{

  final TextEditingController editingController = new TextEditingController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {

    _context = context;

    return new Container(
        
      padding: new EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
      margin: new EdgeInsets.only(top: 15.0),
      child: new Material(
          color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(const Radius.circular(25)),
        elevation: 2.0,
        child: new Container(
            width:700,
          height: 50.0,
          margin: new EdgeInsets.only(left: 16.0,right: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    style: new TextStyle(color: Colors.white),
                    maxLines: 1,
                    decoration: new InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(Icons.search, color: const Color(0xFFffffff),),
                      hintText: 'Search your device, apps, web...',
                      border: InputBorder.none
                    ),
                    onSubmitted: null,
                    controller: editingController,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}