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
import 'package:Pangolin/main.dart';
import 'dart:ui';
import 'package:Pangolin/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() {
  runApp(new Welcome());
}

extension CustomColorScheme on ColorScheme {
  Color get titleText => brightness == Brightness.light
      ? const Color(0xFF000000)
      : const Color(0xFFffffff);
  Color get foregroundText => brightness == Brightness.light
      ? const Color(0xFF222222)
      : const Color(0xFFffffff);
  String get logoMode => brightness == Brightness.light
      ? "assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text_drop_shadow.png"
      : "assets/images/logos/dahliaOS/PNG/logo-white.png";
  Color get lowerText => brightness == Brightness.light
      ? const Color(0xFF333333)
      : const Color(0xFFffffff);
  Color get cardColor => brightness == Brightness.light
      ? const Color(0xFFffffff)
      : const Color(0xFF303030);
  Color get barIconColor => brightness == Brightness.light
      ? const Color(0xFF454545)
      : const Color(0xFFffffff);
  Color get barColor => brightness == Brightness.light
      ? const Color(0xFFe0e0e0)
      : const Color(0xFF333333);
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome',
      theme: new ThemeData(
        brightness: Brightness.light,
        platform: TargetPlatform.fuchsia,
        primarySwatch: Colors.deepOrange,
        canvasColor: const Color(0xFFfffffff),
      ),
      darkTheme: new ThemeData(
          brightness: Brightness.dark,
          platform: TargetPlatform.fuchsia,
          primarySwatch: Colors.deepOrange),
      themeMode: Pangolin.settingsBox.get("darkMode")
          ? ThemeMode.dark
          : ThemeMode.light,
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
        color: Theme.of(context).colorScheme.cardColor,
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
                        color: Theme.of(context).colorScheme.foregroundText,
                        fontWeight: FontWeight.w600)),
                Text(main,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.lowerText))
              ]),
              new Expanded(
                child: new Container(),
              ),
              new Center(
                child: new Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.foregroundText,
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
          color: Theme.of(context)
              .colorScheme
              .foregroundText, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor,
        shadowColor: const Color(0x00ffffff),
        title: Image.asset(
          Theme.of(context).colorScheme.logoMode,
          fit: BoxFit.fitHeight,
          filterQuality: FilterQuality.medium,
          width: 300,
          height: 25,
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
                    "Welcome to dahliaOS!",
                    style: new TextStyle(
                        fontSize: 36.0,
                        color: Theme.of(context).colorScheme.titleText,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Sulphur Point"),
                  ),
                  /* new Image.asset(
                      
       'assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text_drop_shadow.png',
        fit: BoxFit.fitHeight,
        
        width: 300,
       height:32,
      ),*/
                  feature(
                      "assets/images/icons/PNG/welcome-info.png",
                      "Build Information",
                      headingFeatureString,
                      "/info",
                      context),
                  feature("assets/images/icons/PNG/messages.png", "Feedback",
                      "Have an issue or a suggestion?", "/feedback", context),
                  feature(
                      "assets/images/icons/PNG/social.png",
                      "Social media",
                      "Check us out on nearly every platform!",
                      "/social",
                      context),
                  feature(
                      "assets/images/icons/PNG/credits.png",
                      "Credits",
                      "Here's everyone who helped make this happen!",
                      "/credits",
                      context),
                  feature(
                      "assets/images/icons/PNG/software-shared.png",
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
              child: Text('Welcome to dahliaOS!'),
              decoration: BoxDecoration(
                color: Colors.deepOrange[500],
              ),
            ),
            ListTile(
              title: Text('Build Information'),
              leading: Icon(Icons.info_outline),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
                Navigator.pushNamed(context, "/info");
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              leading: Icon(Icons.comment),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, "/feedback");
              },
            ),
            ListTile(
              title: Text('Social Media'),
              leading: Icon(Icons.share),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, "/social");
              },
            ),
            ListTile(
              title: Text('Credits'),
              leading: Icon(Icons.people),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, "/credits");
              },
            ),
            ListTile(
              title: Text('Software'),
              leading: Icon(Icons.developer_board),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, "/software");
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
                                    "WARNING: You are on a pre-release build of dahliaOS. Some features may not work as intended.",
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

//double width = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio - 256;

class BuildInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context)
                .colorScheme
                .foregroundText, //change your color here
          ),
          backgroundColor: Theme.of(context).colorScheme.cardColor,
          shadowColor: const Color(0x00ffffff),
          title: new Text(
            "Build Information",
            style: new TextStyle(
                color: Theme.of(context).colorScheme.foregroundText),
          ),
        ),
        body: new Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          new Image.asset(
            Theme.of(context).colorScheme.logoMode,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.medium,
            width: 300,
            height: 52,
          ),
          Text(longName,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          Text(kernel,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          Text(pangolinCommit,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          RaisedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('See dahliaos.io for updates'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                  width: 300,
                  padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                );

                Scaffold.of(context).showSnackBar(snackBar);
              },
              elevation: 1,
              color: Colors.deepOrange[600],
              child: Text('RELEASE NOTES',
                  style: TextStyle(fontSize: 14, color: Color(0xffffffff)))),
        ])));
  }
}

class Feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .colorScheme
              .foregroundText, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Feedback",
          style: new TextStyle(
              color: Theme.of(context).colorScheme.foregroundText),
        ),
      ),
      body: Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('We are always looking for ways we can improve!',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          Text('Please submit feedback to contact+feedback@dahliaos.io',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          Text(
              'Experienced a bug? Report an issue at github.com/dahlia-os/releases',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.foregroundText)),
          RaisedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.pop(context);
            },
            child: Text('BACK'),
          ),
        ],
      )),
    );
  }
}

Container socialItem(String icon, String header, String main, context) {
  return Container(
      width: 512,
      child: Card(
        color: Theme.of(context).colorScheme.cardColor,
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
                        color: Theme.of(context).colorScheme.foregroundText,
                        fontWeight: FontWeight.w600)),
                Text(main,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.lowerText))
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
          color: Theme.of(context)
              .colorScheme
              .foregroundText, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Social Media",
          style: new TextStyle(
              color: Theme.of(context).colorScheme.foregroundText),
        ),
      ),
      body: Center(
          child: new SingleChildScrollView(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              scrollDirection: Axis.vertical,
              child: new Wrap(
                children: [
                  /* new Image.asset(
                      
       'assets/images/logos/dahliaOS/PNG/dahliaOS_logo_with_text_drop_shadow.png',
        fit: BoxFit.fitHeight,
        
        width: 300,
       height:32,
      ),*/

                  socialItem(
                      "assets/images/logos/dahliaOS/PNG/dahliaOS_logo_drop_shadow.png",
                      "Official Website",
                      "https://dahliaos.io",
                      context),
                  socialItem("assets/images/icons/PNG/discord.png", "Discord",
                      "https://dahliaos.io/discord", context),
                  socialItem("assets/images/icons/PNG/facebook.png", "Facebook",
                      "https://dahliaos.io/facebook", context),
                  socialItem("assets/images/icons/PNG/github.png", "Github",
                      "https://dahliaos.io/github", context),
                  socialItem("assets/images/icons/PNG/instagram.png",
                      "Instagram", "https://dahliaos.io/instagram", context),
                  socialItem("assets/images/icons/PNG/reddit.png", "Reddit",
                      "https://dahliaos.io/reddit", context),
                  socialItem("assets/images/icons/PNG/telegram.png", "Telegram",
                      "https://dahliaos.io/telegram", context),
                  socialItem("assets/images/icons/PNG/twitter.png", "Twitter",
                      "https://dahliaos.io/twitter", context),

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

Container person(String icon, String header, String main, context) {
  return Container(
      width: 512,
      child: Card(
        color: Theme.of(context).colorScheme.cardColor,
        elevation: 0,
        margin: EdgeInsets.all(25),
        child: InkWell(
            splashColor: Colors.deepOrange.withAlpha(50),
            child: Row(children: [
              Center(
                child: new Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor:
                        Theme.of(context).colorScheme.foregroundText,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(icon),
                    ),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(header,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.foregroundText,
                        fontWeight: FontWeight.w600)),
                Text(main,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.lowerText))
              ]),
            ])),
      ));
}

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context)
                .colorScheme
                .foregroundText, //change your color here
          ),
          backgroundColor: Theme.of(context).colorScheme.cardColor,
          shadowColor: const Color(0x00ffffff),
          title: new Text(
            "Credits",
            style: new TextStyle(
                color: Theme.of(context).colorScheme.foregroundText),
          ),
        ),
        body: new SingleChildScrollView(
            padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            scrollDirection: Axis.vertical,
            child: new Column(children: <Widget>[
              Text("Thank you to everyone who made this dream come true!",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.foregroundText)),
              Text("Want to help out? Find us at https://github.com/dahlia-os",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.foregroundText)),
              new Center(
                child: new SingleChildScrollView(
                    padding:
                        new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    scrollDirection: Axis.vertical,
                    child: new Wrap(children: <Widget>[
                      person("assets/images/credits/profiles/bleonard.png",
                          "Blake Leonard", "bleonard252", context),
                      person("assets/images/credits/profiles/noah.jpeg",
                          "Noah Cain", "nmcain", context),
                      person("assets/images/credits/profiles/camden.jpeg",
                          "Camden Bruce", "EnderNightLord-ChromeBook", context),
                      person("assets/images/credits/profiles/faust.png",
                          "Marin Heđeš", "SincerelyFaust", context),
                      person("assets/images/credits/profiles/lars.jpeg", "Lars",
                          "larsb24", context),
                      person("assets/images/credits/profiles/horus.png",
                          "Hackerman", "Horus125", context),
                      person("assets/images/credits/profiles/haru.jpeg",
                          "Kanou Haru", "kanouharu", context),
                      person("assets/images/credits/profiles/nobody.png",
                          "Nobody", "nobody5050", context),
                      person("assets/images/credits/profiles/subspace.png",
                          "Lucas Puntillo", "puntillol59", context),
                      person("assets/images/credits/profiles/hexa.png",
                          "Quinten", "HexaOneOfficial", context),
                      person("assets/images/credits/profiles/x7.jpeg",
                          "Syed Mushaheed", "predatorx7", context),
                      person("assets/images/credits/profiles/vanzh.png", "V.",
                          "xVanzh", context),
                      person("assets/images/credits/profiles/funeoz.jpeg",
                          "Funeoz", "Funeoz", context),
                      person("assets/images/credits/profiles/fristover.png",
                          "Fristover", "Fristover", context),
                      person("assets/images/credits/profiles/allansrc.jpeg",
                          "Allan Ramos", "Allansrc", context),
                      person("assets/images/credits/profiles/xeu100.png",
                          "xeu100", "xeu100", context),
                      person("assets/images/credits/profiles/Seplx.png",
                          "Seplx", "Seplx", context),
                      person("assets/images/credits/profiles/aoaowangxiao.jpeg",
                          "aoaowangxiao", "aoaowangxiao", context),
                      person(
                          "assets/images/credits/profiles/evolutionevotv.png",
                          "evoDesign",
                          "evolutionevotv",
                          context),
                      person(
                          "assets/images/credits/profiles/febryardiansyah.jpeg",
                          "Febry Ardiansyah",
                          "febryardiansyah",
                          context),
                      person(
                          "assets/images/credits/profiles/goktugvatandas.jpeg",
                          "Göktuğ Vatandaş",
                          "goktugvatandas",
                          context),
                      person(
                          "assets/images/logos/dahliaOS/PNG/dahliaOS_logo_drop_shadow.png",
                          "And... you!",
                          "Thanks for testing out this build!",
                          context),
                    ])),
              )
            ])));
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Flutter',
      expandedValue: 'BSD 3-Clause "New" or "Revised" License',
    );
    return Item(
      headerValue: 'Hive',
      expandedValue: 'Apache 2.0',
    );
  });
}

class SoftwareWidget extends StatefulWidget {
  SoftwareWidget({Key key}) : super(key: key);

  @override
  _SoftwareWidgetState createState() => _SoftwareWidgetState();
}

class _SoftwareWidgetState extends State<SoftwareWidget> {
  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To view full license, tap the arrow'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print("show licenese yes");
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
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
          color: Theme.of(context)
              .colorScheme
              .foregroundText, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.cardColor,
        shadowColor: const Color(0x00ffffff),
        title: new Text(
          "Software",
          style: new TextStyle(
              color: Theme.of(context).colorScheme.foregroundText),
        ),
      ),
      body: Center(
          child: new SizedBox(
        width: 800,
        child: SoftwareWidget(),
      )),
    );
  }
}
