import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SettingsCard extends StatefulWidget {
  final Widget? leading;
  late Widget? content;
  late final Widget trailing;
  final String? title, subtitle;
  final List<Widget>? children;

  ///Default value for either the switch or the expansion state
  bool defaultValue;
  final SettingsCardType type;
  SettingsCard.withSwitch({
    Key? key,
    this.type = SettingsCardType.SWITCH,
    this.leading,
    this.subtitle,
    this.title,
    this.children,
    this.content = null,
    required this.defaultValue,
  }) : super(key: key);
  SettingsCard.withExpandableSwitch({
    Key? key,
    this.type = SettingsCardType.EXPANDABLESWITCH,
    this.leading,
    this.subtitle,
    this.title,
    this.children,
    required this.content,
    required this.defaultValue,
  }) : super(key: key);
  SettingsCard.withExpandable({
    Key? key,
    this.type = SettingsCardType.EXPANDABLE,
    this.leading,
    this.subtitle,
    this.title,
    this.children,
    required this.content,
    required this.defaultValue,
  }) : super(key: key);
  SettingsCard.withCustomTrailing({
    Key? key,
    this.type = SettingsCardType.CUSTOMTRAILING,
    this.leading,
    this.subtitle,
    this.title,
    this.children,
    this.content = null,
    required this.trailing,
    required this.defaultValue,
  }) : super(key: key);

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

enum SettingsCardType { SWITCH, EXPANDABLE, EXPANDABLESWITCH, CUSTOMTRAILING }

class _SettingsCardState extends State<SettingsCard>
    with TickerProviderStateMixin {
  //Initialise animation utilities
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    value: 0.9,
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  //Build widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Transform.scale(
        scale: 1.01,
        child: ScaleTransition(
          scale: _animation,
          child: MouseRegion(
            onEnter: (details) => _controller.animateTo(1),
            onExit: (details) => _controller.animateTo(0.9),
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              color: Color(0xff212121),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide.none,
              ),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8.0,
                    ),
                    leading: widget.leading ??
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                    title: Text(widget.title ?? "ERR: No title"),
                    subtitle: Text(widget.subtitle ?? "ERR: No subtitle"),
                    trailing: trailing,
                    onTap: () {
                      setState(() {
                        if (widget.type == SettingsCardType.SWITCH) {
                          widget.defaultValue = !widget.defaultValue;
                        }
                        if (widget.type == SettingsCardType.EXPANDABLESWITCH ||
                            widget.type == SettingsCardType.EXPANDABLE) {
                          widget.defaultValue = !widget.defaultValue;
                        }
                      });
                    },
                  ),
                  Offstage(
                    offstage: widget.type == SettingsCardType.SWITCH ||
                            widget.type == SettingsCardType.CUSTOMTRAILING
                        ? true
                        : !widget.defaultValue,
                    child: widget.content ?? Text("No content"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get trailing {
    if (widget.type == SettingsCardType.EXPANDABLESWITCH) {
      return Switch(
        onChanged: (val) {
          setState(() {
            widget.defaultValue = !widget.defaultValue;
          });
        },
        value: widget.defaultValue,
      );
    }
    if (widget.type == SettingsCardType.SWITCH) {
      return Switch(
        onChanged: (val) {
          setState(() {
            widget.defaultValue = !widget.defaultValue;
          });
        },
        value: widget.defaultValue,
      );
    }
    if (widget.type == SettingsCardType.EXPANDABLE) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Transform.rotate(
          angle: widget.defaultValue ? -math.pi / 2 : math.pi / 2,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
        ),
      );
    }
    if (widget.type == SettingsCardType.CUSTOMTRAILING) {
      return widget.trailing;
    }

    return SizedBox.shrink();
  }
}
