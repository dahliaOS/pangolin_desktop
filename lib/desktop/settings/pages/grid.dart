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
      padding: EdgeInsets.symmetric(horizontal: 200, vertical: 20),
      color: Theme.of(context).cardColor,
      child: Center(
          child: SingleChildScrollView(
        child: Wrap(
            spacing: 20,
            direction: Axis.horizontal,
            children: List.generate(
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
                                style: Theme.of(context).textTheme.bodyText1),
                            subtitle: Text(Settings.items[index].subtitle),
                            leading: Icon(
                              Settings.items[index].icon,
                              size: 35,
                              color: Color(HiveManager.get("accentColorValue")),
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
