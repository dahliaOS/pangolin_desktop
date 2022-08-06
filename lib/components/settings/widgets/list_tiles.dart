import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExpandableSwitchListTile extends StatelessWidget {
  final Widget? content;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ExpandableSwitchListTile({
    super.key,
    this.content,
    this.title,
    this.subtitle,
    this.leading,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: title ?? const Text("Expandable List Tile"),
          subtitle:
              subtitle ?? const Text("Description of an Expandable List Tile"),
          secondary: leading,
          value: value,
          onChanged: onChanged,
        ),
        Offstage(
          offstage: !value,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: content ??
                const FlutterLogo(
                  curve: Curves.easeInOutExpo,
                  duration: Duration(milliseconds: 500),
                  size: 48,
                ),
          ),
        )
      ],
    );
  }
}

class ExpandableListTile extends StatefulWidget {
  final Widget? content;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final bool value;
  const ExpandableListTile({
    super.key,
    this.content,
    this.title,
    this.subtitle,
    this.leading,
    required this.value,
  });

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant ExpandableListTile oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: widget.title ?? const Text("Expandable List Tile"),
          subtitle: widget.subtitle,
          leading: widget.leading,
          dense: true,
          trailing: Transform.rotate(
            angle: _value ? math.pi / 2 : -math.pi / 2,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.chevron_left),
            ),
          ),
          onTap: () {
            setState(() {
              _value = !_value;
            });
          },
        ),
        Offstage(
          offstage: !_value,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: widget.content ??
                const FlutterLogo(
                  curve: Curves.easeInOutExpo,
                  duration: Duration(milliseconds: 500),
                  size: 48,
                ),
          ),
        )
      ],
    );
  }
}

class RouterListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;

  final String? route;

  const RouterListTile({
    super.key,
    this.onTap,
    this.onLongPress,
    this.title,
    this.subtitle,
    this.leading,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ??
          () {
            //TODO implement router navigation
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Not implemented yet"),
              ),
            );
          },
      onLongPress: onLongPress,
      title: title ?? const Text("Router List Tile"),
      subtitle: subtitle ?? const Text("Description of a Router List Tile"),
      leading: leading,
      trailing: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}
