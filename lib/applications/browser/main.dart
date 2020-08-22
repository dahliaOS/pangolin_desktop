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

import 'dart:ui';
import 'searchbar.dart';
import 'package:flutter/material.dart';
import '../welcome.dart';


void main() => runApp(BrowserApp());

class BrowserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Terminal',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFF212121),
        canvasColor: const Color(0xFF303030),
      ),
      home: new Browser(),
    );
  }
}

//double iconSize = null;

class Desktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(height: 50, color: Color(0xffF7F7F7),
               child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed:(){},
                //iconSize: iconSize,
                color: const Color(0xFF000000),
              ),
    
              new IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed:(){},
                //iconSize: iconSize,
                color: const Color(0xFF000000),
              ),
    
              new IconButton(
                icon: const Icon(Icons.refresh),
                onPressed:(){},
              //  iconSize: iconSize,
                color: const Color(0xFF000000),
              ),

new SearchWidget(),

new IconButton(

  icon: const Icon(Icons.star_border),
                onPressed:(){},
              //  iconSize: iconSize,
                color: const Color(0xFF000000),
              ),
new IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed:(){},
              //  iconSize: iconSize,
                color: const Color(0xFF000000),
              ),

            ]
    
          ),),
      
    ]);
  }
}


class Browser extends StatefulWidget {
  Browser({Key key}) : super(key: key);
  @override
  BrowserState createState() => new BrowserState();
}

class BrowserState extends State<Browser>
    with TickerProviderStateMixin {
  List<Tab> tabs = [];
  TabController tabController;
  var count = 1;
  void newTab() {
    setState(() {
      tabs.add(
        Tab(
          child: Row(
            children: <Widget>[
              Text('New Tab'),
              Padding(
                padding: EdgeInsets.only(left: 8),
              ),
              new Expanded(child: new Container()),
              GestureDetector(
                child: Icon(
                  Icons.clear,
                  size: 16,
                  //color: Colors.black,
                ),
                onTap: closeCurrentTab,
              ),
            ],
          ),
        ),
      );
      count++;
      tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  void closeCurrentTab() {
    setState(() {
      tabs.removeAt(tabController.index);
      tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  
  
  @override
  void initState() {
    super.initState();
    tabs.add(
      Tab(
        child: Row(
          children: <Widget>[
            Text('New Tab'),
            Padding(
              padding: EdgeInsets.only(left: 8),
            ),
            new Expanded(child: new Container()),
            GestureDetector(
              child: Icon(
                Icons.clear,
                size: 16,
                //color: Colors.black,
              ),
              onTap: closeCurrentTab,
            ),
          ],
        ),
      ),
    );
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blue,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  55.0), // here the desired height of the status bar
              child: AppBar(
                  elevation: 0.0,
                  backgroundColor: const Color(0xFFD6D6D6),
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(
                          55.0), // here the desired height of the status bar
                      child: new Row(
                        children: [
                          new Expanded(
                              child: new Container(
                            child: TabBar(
                                controller: tabController,
                                labelColor: Color(0xFF222222),
                                unselectedLabelColor: Color(0xFF222222),
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Color(0xFFF7F7F7)),
                                tabs: tabs.map((tab) => tab).toList()),
                          )),
                          new Center(
                            child: new IconButton(
                                icon: Icon(Icons.add),
                                color: Color(0xFF222222),
                                onPressed: newTab),
                          ),
                         /* new Center(
                            child: new Container(height:20,width:1,color:Color(0xFF222222),)
                          ),
                          new Center(
                            child: new IconButton(
                                icon: Icon(Icons.more_vert),
                                color: Color(0xFF222222),
                                onPressed: newTab),
                          )*/
                        ],
                      )) // A trick to trigger TabBar rebuild.
                  )),
          body: Stack(
            children: [
              new Center(
                child: new Text(
                  "?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TabBarView(
                controller: tabController,
                children: tabs.map((tab) => Column(children: [new Desktop(),new Expanded(child: new Welcome(),)],)).toList(),
              ),
            ],
          )),
    );
  }
}
