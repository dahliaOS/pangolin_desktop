import 'package:Pangolin/desktop/settings/settings.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/utils/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsHome extends StatefulWidget {
  const SettingsHome({Key key}) : super(key: key);

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
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
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: 45.0,
                          margin: EdgeInsets.only(left: 10, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: AbsorbPointer(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      fontSize: 15,
                                    ),
                                    icon: Icon(
                                      Icons.search,
                                      color: Color(
                                        HiveManager.get("accentColorValue"),
                                      ),
                                    ),
                                    hintText: 'Search settings...',
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: null,
                                  controller: provider.controller,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  Settings.items.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: 300,
                    height: 85,
                    child: Hover(
                      color: Color(
                        HiveManager.get("accentColorValue"),
                      ).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ListTile(
                              dense: true,
                              title: Text(Settings.items[index].title,
                                  style: Theme.of(context).textTheme.bodyText1),
                              subtitle: Text(Settings.items[index].subtitle),
                              leading: Icon(
                                Settings.items[index].icon,
                                size: 35,
                                color: Color(
                                  HiveManager.get("accentColorValue"),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.pageIndex = index;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
