import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/utils/widgets/hover.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Theme.of(context).cardColor,
      child: Center(
          child: SingleChildScrollView(
        child: Wrap(
            spacing: 20,
            direction: Axis.horizontal,
            children: [
                  Container(
                    child: Hero(
                      tag: "search",
                      child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(25)),
                        //elevation: 5.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/search");
                          },
                          child: new Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 45.0,
                            margin: new EdgeInsets.only(left: 10, right: 5),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                    child: AbsorbPointer(
                                  child: new TextField(
                                    style: new TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    decoration: new InputDecoration(
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color,
                                          fontSize: 15,
                                        ),
                                        icon: Icon(
                                          Icons.search,
                                          color: Color(HiveManager.get(
                                              "accentColorValue")),
                                        ),
                                        hintText: 'Search settings...',
                                        border: InputBorder.none),
                                    onSubmitted: null,
                                    controller: editingController,
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] +
                List.generate(
                  Settings.items.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: 300,
                    height: 85,
                    child: Hover(
                      color: Color(HiveManager.get("accentColorValue"))
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: ListTile(
                                dense: true,
                                title: Text(Settings.items[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                subtitle: Text(Settings.items[index].subtitle),
                                leading: Icon(
                                  Settings.items[index].icon,
                                  size: 35,
                                  color: Color(
                                      HiveManager.get("accentColorValue")),
                                ),
                                onTap: () {
                                  setState(() {
                                    //setSelected(i, Settings.items);
                                  });
                                  Navigator.pop(context);
                                  Settings.contoller.animateToPage(index,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.decelerate);
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      )),
    );
  }
}
