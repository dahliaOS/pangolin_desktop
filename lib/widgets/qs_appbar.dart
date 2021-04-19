import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool? value;
  VoidCallback onTap;
  bool? withSwitch;

  QsAppBar(
      {required this.title,
      this.value = false,
      required this.onTap,
      this.withSwitch = true});

  @override
  _QsAppBarState createState() => _QsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(48);
}

class _QsAppBarState extends State<QsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          toolbarHeight: widget.preferredSize.height,
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          elevation: 0,
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            widget.withSwitch!
                ? Switch(
                    value: widget.value!,
                    onChanged: (val) {
                      widget.onTap();
                      setState(() {});
                    })
                : SizedBox.shrink(),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        Positioned.fill(
          left: 64,
          right: 64,
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              widget.onTap();
              setState(() {});
            },
          ),
        )
      ],
    );
  }
}
