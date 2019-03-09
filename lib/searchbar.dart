
import 'dart:async';
import 'package:flutter/material.dart';





class SearchWidget extends StatelessWidget {

  final TextEditingController editingController = new TextEditingController();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      margin: const EdgeInsets.only(),
      child: new Material(
        borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
        color: const Color(0xFFffffff),
        elevation: 0.0,
        child: new Container(
          height: 50.0,
          margin: new EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    maxLines: 1,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.search, color: Theme
                            .of(context)
                            .accentColor,),
                        hintText: "Search your device, apps, web...",
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