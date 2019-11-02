import 'package:flutter/material.dart';

class HeaderSwitchTile extends StatelessWidget {
  const HeaderSwitchTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.trailingTitle,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.isThreeLine = false,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  final Widget leading;

  final Widget title;

  final Widget subtitle;

  final Widget trailing;

  final Widget trailingTitle;

  final Color backgroundColor;

  final Color selectedBackgroundColor;

  final bool isThreeLine;

  final bool enabled;

  final GestureTapCallback onTap;

  final GestureLongPressCallback onLongPress;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            color: selected ? selectedBackgroundColor : backgroundColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              onTap: onTap,
              onLongPress: onLongPress,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  trailingTitle,
                  SizedBox(width: 10,),
                  trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}