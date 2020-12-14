import 'package:flutter/material.dart';

class GraftManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(
            width: 300,
            height: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Management",
                  style: TextStyle(letterSpacing: 1.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text("Start"),
                      ),
                    ),
                    FlatButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {},
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text("Restart"),
                      ),
                    ),
                    FlatButton(
                      color: Colors.red[600],
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
                Text(
                  "System",
                  style: TextStyle(letterSpacing: 1.0),
                ),
                SizedBox(
                  width: 300,
                  height: 180,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.memory,
                            size: 28,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AbsorbPointer(
                              child: TextFormField(
                                initialValue: "2048MB",
                                //autofocus: true,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    labelText: "Memory",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    enabled: true,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .accentColor))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.storage_outlined,
                              size: 22,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AbsorbPointer(
                              child: TextFormField(
                                initialValue: "160GB",
                                //autofocus: true,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    labelText: "Storage",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    enabled: true,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .accentColor))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        title: Text("Hardware Acceleration"),
                        onChanged: (bool value) {},
                        value: true,
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
