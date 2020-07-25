import 'package:flutter/material.dart';

void main() {
  runApp(new TextEditorApp());
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Text Editor',
      theme: new ThemeData(
        platform: TargetPlatform.fuchsia,
        primarySwatch: Colors.amber,
        canvasColor: const Color(0xFFfafafa),
      ),
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(children: [
        Container(
            width: 300,
            color: Color(0xffeeeeee),
            child: Column(children: [
              AppBar(
                centerTitle: false,
                title: Text('Text Editor'),
                actions: <Widget>[
                  // action button
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.folder_open),
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 6.0),
                            child: Text(
                              "asdfasd",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 6.0, 12.0, 12.0),
                            child: Text(
                              "Following the suspension of...",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "2/11/05",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                size: 25.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 6.0),
                            child: Text(
                              "Untitled Document",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 6.0, 12.0, 12.0),
                            child: Text(
                              "Lorem ipsum dolor...",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "2/11/05",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                size: 25.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Divider(
                    height: 2.0,
                    color: Colors.grey,
                  )*/
                ],
              ),
            ])),
        DocPreview()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ), //
    );
  }
}

class DocPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Untitled Document',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w300)),
                  Text(
                      '      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
                      style: TextStyle(
                          height: 1.5, fontSize: 14, color: Color(0xff2b2b2b)))
                ]))));
  }
}

// Navigator.pushNamed(context, '/second');

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFeeeeee),
        appBar: AppBar(
          centerTitle: false,
          title: Text('Untitled Document'),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
        body: Column(children: [
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: SingleChildScrollView(
                  //padding:
                  // new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.undo,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.redo,
                                size: 25, color: Color(0xff545454)))),
                    Container(width: 1, height: 30, color: Color(0xff545454)),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_bold,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.strikethrough_s,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_underlined,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_italic,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_quote,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.code,
                                size: 25, color: Color(0xff545454)))),
                    Container(width: 1, height: 30, color: Color(0xff545454)),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H1",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H2",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H3",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H4",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H5",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: new Text(
                            "H6",
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF545454),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Roboto"),
                          ),
                        )),
                    Container(width: 1, height: 30, color: Color(0xff545454)),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_list_bulleted,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.format_list_numbered,
                                size: 25, color: Color(0xff545454)))),
                    Container(width: 1, height: 30, color: Color(0xff545454)),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.link,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.image,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.table_chart,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.insert_emoticon,
                                size: 25, color: Color(0xff545454)))),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Icon(Icons.functions,
                                size: 25, color: Color(0xff545454)))),
                  ]))),
          new Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(25.0),
              width: 900,
              height: 1600,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: new TextFormField(
                    onChanged: (text) {
                      print("First text field: $text");
                    },
                    style: TextStyle(
                      fontSize: 15.0,
                      color: const Color(0xFF222222),
                      fontFamily: "Roboto",
                    ),
                    decoration: InputDecoration.collapsed(hintText: ""),
                    autocorrect: false,
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    cursorColor: const Color(0xFF222222),
                  ),
                ),
              ),
            ),
          ))
        ]));
  }
}
//Navigator.pop(context);
