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

    return new Expanded(child:Container(
        
      padding: new EdgeInsets.only(left: 10.0,right: 10.0,top: 3.0, bottom: 3),
      margin: new EdgeInsets.only(top: 0.0),
      child: new Material(
          color: Colors.white,
        borderRadius: const BorderRadius.all(const Radius.circular(5)),
        elevation: 0,
        child: new Container(
            
          
          margin: new EdgeInsets.only(left: 16.0,right: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    style: new TextStyle(color: Color(0xff222222)),
                    maxLines: 1,
                    decoration: new InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff333333)),
                      icon: Icon(Icons.search, color: const Color(0xff222222),),
                      hintText: 'Search DuckDuckGo or type a URL',
                      border: InputBorder.none,
                    ),
                    onSubmitted: null,
                    controller: editingController,
                  )
              )
            ],
          ),
        ),
      ),
    ));
  }
}
