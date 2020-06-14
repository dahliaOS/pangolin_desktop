/*
Copyright 2019 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
