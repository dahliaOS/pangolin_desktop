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

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(new Welcome());
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome',
      theme: new ThemeData(
        platform: TargetPlatform.fuchsia,
        primarySwatch: Colors.deepOrange,
        canvasColor: const Color(0xFFfffffff),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/info': (context) => BuildInfo(),
        '/feedback': (context) => Feedback(),
        '/social': (context) => SocialMedia(),
        '/credits': (context) => Credits(),
        '/software': (context) => Software(),
      },
    );
  }
}

Container feature(
    String icon, String header, String main, String target, context) {
  return Container(
      width: 512,
      child: Card(
        color: Color(0xffffffff),
        elevation: 0,
        margin: EdgeInsets.all(25),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, target);
            },
            splashColor: Colors.deepOrange.withAlpha(50),
            child: Row(children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    width: 64,
                    height: 64,
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(header,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w600)),
                Text(main,
                    style: TextStyle(fontSize: 15, color: Color(0xff333333)))
              ]),
              new Expanded(
                child: new Container(),
              ),
              new Center(
                child: new Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[800],
                  size: 32,
                ),
              )
            ])),
      ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: Image.asset(
          'lib/images/logo-color.png',
          fit: BoxFit.fitHeight,
          width: 300,
          height: 32,
        ),
      ),
      body: Center(
          child: new SingleChildScrollView(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              scrollDirection: Axis.vertical,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text(
                    "Welcome to dahliaOS",
                    style: new TextStyle(
                        fontSize: 36.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Sulphur Point"),
                  ),
                  /* new Image.asset(
                      
       'lib/images/logo-color.png',
        fit: BoxFit.fitHeight,
        
        width: 300,
       height:32,
      ),*/
                  feature(
                      "lib/images/icons/v2/compiled/welcome-info.png",
                      "Build Information",
                      "dahliaOS Linux-Based 200806 ...",
                      "/info",
                      context),
                  feature(
                      "lib/images/icons/v2/compiled/messages.png",
                      "Feedback",
                      "Have an issue or a suggestion?",
                      "/feedback",
                      context),
                  feature(
                      "lib/images/icons/v2/compiled/social.png",
                      "Social media",
                      "Check us out on nearly every platform!",
                      "/social",
                      context),
                  feature(
                      "lib/images/icons/v2/compiled/credits.png",
                      "Credits",
                      "Here's everyone who helped make this happen!",
                      "/credits",
                      context),
                  feature(
                      "lib/images/icons/v2/compiled/software-shared.png",
                      "Software",
                      "View information about third-party software...",
                      "/software",
                      context),

                  /* RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),*/
                ],
              ))),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Welcome'),
              decoration: BoxDecoration(
                color: Colors.deepOrange[500],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Color(0x00ffffff),
          child: new SizedBox(
              height: 50,
              width: 15,
              child: new Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    elevation: 0,
                    color: Colors.amber[500],
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Row(
                        children: [
                          new Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.grey[900],
                                  ))),
                          Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: new Text(
                                    "WARNING: You are on a pre-release build of dahliaOS. For your protection, wireless networking has been disabled.",
                                    style: new TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  )))),
    );
  }
}

class BuildInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Build Information",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class Feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Feedback",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

Container socialItem(String icon, String header, String main) {
  return Container(
      width: 512,
      child: Card(
        color: Color(0xffffffff),
        elevation: 0,
        margin: EdgeInsets.all(25),
        child: InkWell(
            splashColor: Colors.deepOrange.withAlpha(50),
            child: Row(children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    width: 64,
                    height: 64,
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(header,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff222222),
                        fontWeight: FontWeight.w600)),
                Text(main,
                    style: TextStyle(fontSize: 15, color: Color(0xff333333)))
              ]),
            ])),
      ));
}

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Social Media",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: new SingleChildScrollView(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              scrollDirection: Axis.vertical,
              child: new Wrap(
                children: [
                  /* new Image.asset(
                      
       'lib/images/logo-color.png',
        fit: BoxFit.fitHeight,
        
        width: 300,
       height:32,
      ),*/

                  socialItem(
                    "lib/images/dahlia.png",
                    "Official Website",
                    "https://dahliaos.io",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/discord.png",
                    "Discord",
                    "https://discord.gg/jwgS3t6",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/facebook.png",
                    "Facebook",
                    "https://facebook.com/pg/officialdahliaos/",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/github.png",
                    "Github",
                    "https://github.com/dahlia-os",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/instagram.png",
                    "Instagram",
                    "https://instagram.com/officialdahliaos/",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/reddit.png",
                    "Reddit",
                    "https://reddit.com/r/dahliaos",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/telegram.png",
                    "Telegram",
                    "https://t.me/dahliaos/",
                  ),
                  socialItem(
                    "lib/images/icons/v2/compiled/twitter.png",
                    "Twitter",
                    "https://twitter.com/realdahliaos",
                  ),

                  /* RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),*/
                  new Text(
                    "    ",
                    style: new TextStyle(
                        fontSize: 36.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Sulphur Point"),
                  ),
                ],
              ))),
    );
  }
}

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Credits",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class Software extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Software",
          style: new TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
