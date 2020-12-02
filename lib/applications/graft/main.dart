import 'dart:ui';

import 'package:flutter/material.dart';

main() {
  runApp(Graft());
}

class Graft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GraftHome(),
    );
  }
}

class GraftHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graft"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Container(
              //color: Colors.green,
              width: MediaQuery.of(context).size.width / 5.5,
              child: GraftSideBar(),
            ),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: GraftDetails(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GraftSideBar extends StatefulWidget {
  GraftSideBar({Key key}) : super(key: key);

  @override
  _GraftSideBarState createState() => _GraftSideBarState();
}

class _GraftSideBarState extends State<GraftSideBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Containers",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              FlatButton(
                color: Colors.blue.withOpacity(0.2),
                onPressed: () {},
                textColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 6, 14, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 8,
                      ),
                      Text("New"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              buildContainer(
                  context: context,
                  type: GraftType.CONTAINER,
                  title: "Debian 10",
                  size: "160"),
              buildContainer(
                  context: context,
                  type: GraftType.VIRTUALMACHINE,
                  title: "Windows 8.1",
                  size: "45"),
              buildContainer(
                  context: context,
                  type: GraftType.CONTAINER,
                  title: "BlissOS 13",
                  size: "32"),
              buildContainer(
                  context: context,
                  type: GraftType.CONTAINER,
                  title: "Fedora Workstation 33",
                  size: "32"),
              buildContainer(
                  context: context,
                  type: GraftType.CONTAINER,
                  title: "RHEL 8",
                  size: "32"),
            ],
          ),
        )
      ],
    );
  }

  Container buildContainer(
      {BuildContext context, GraftType type, String title, String size}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 100,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (type == GraftType.CONTAINER)
                      ? "Container"
                      : "Virtual Machine",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  "$title",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      letterSpacing: 1.1, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.storage,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${size}GB",
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.desktop_windows,
                  size: 32,
                ),
                SizedBox(
                  height: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GraftDetails extends StatefulWidget {
  @override
  _GraftDetailsState createState() => _GraftDetailsState();
}

class _GraftDetailsState extends State<GraftDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.desktop_windows,
                size: 40,
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "Fedora Workstation 33",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Management"),
                    Row(
                      children: [
                        FlatButton(
                          color: Colors.blue,
                          onPressed: () {},
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text("Start"),
                          ),
                        ),
                        FlatButton(
                          color: Colors.blue,
                          onPressed: () {},
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text("Restart"),
                          ),
                        ),
                        FlatButton(
                          color: Colors.red,
                          onPressed: () {},
                          textColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text("Erase"),
                          ),
                        ),
                      ],
                    ),
                    Text("System"),
                    Row(
                      children: [
                        Icon(
                          Icons.memory,
                          size: 32,
                          color: Colors.blue[600],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum GraftType { CONTAINER, VIRTUALMACHINE }
