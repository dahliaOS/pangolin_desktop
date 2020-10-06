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

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  List<Widget> actions = List<Widget>();
  SearchAppBar({this.actions});

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(65);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController editingController = new TextEditingController();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return new Container(
      padding: new EdgeInsets.only(left: 5.0, right: 5.0, top: 8.0, bottom: 8),
      //margin: new EdgeInsets.only(top: 15.0),
      width: 700,
      height: 65,
      color: Colors.deepOrange,
      child: Row(
        children: [
          Expanded(
            child: new Material(
              color: Colors.white.withOpacity(0.3),
              borderRadius: const BorderRadius.all(const Radius.circular(5)),
              elevation: 0.0,
              child: new Container(
                width: 700,
                height: 100.0,
                margin: new EdgeInsets.only(left: 16.0, right: 16.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new TextField(
                      style: new TextStyle(color: Colors.white),
                      maxLines: 1,
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.search,
                            color: const Color(0xFFffffff),
                          ),
                          hintText: 'Search Files and Folders',
                          border: InputBorder.none),
                      onSubmitted: null,
                      controller: editingController,
                    )),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: widget.actions,
          )
        ],
      ),
    );
  }
}
