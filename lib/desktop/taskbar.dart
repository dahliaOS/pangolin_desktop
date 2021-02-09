import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Taskbar extends StatelessWidget {
  final List<Widget>? leading, trailing;
  Taskbar({@required this.leading, @required this.trailing});

  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 48,
      child: BoxContainer(
          height: 48,
          color: _data.darkMode
              ? Colors.black.withOpacity(_data.themeOpacity)
              : Colors.white.withOpacity(_data.themeOpacity),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: leading ?? [SizedBox.shrink()],
              ),
              Row(
                children: trailing ?? [SizedBox.shrink()],
              )
            ],
          )

          /*Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<WindowHierarchyState>(context, listen: false)
                      .pushWindowEntry(WindowEntry.withDefaultToolbar(
                          content: Example(), packageName: "test"));
                },
                child: Icon(Icons.brightness_5_outlined),
              ),
            )
          ],
        ),*/
          ),
    );
  }
}
