import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/quick_button.dart';

class AppLauncherTile extends StatefulWidget {
  final Application application;

  const AppLauncherTile(
    this.application, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppLauncherTile> createState() => _AppLauncherTileState();
}

class _AppLauncherTileState extends State<AppLauncherTile> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() => _hover = true),
      onExit: (details) => setState(() => _hover = false),
      child: GestureDetector(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          dense: true,
          leading: Image.asset(
            "assets/icons/${widget.application.iconName}.png",
            height: 32,
          ),
          title: Text(widget.application.name ?? "Unknown"),
          subtitle: Text(
            widget.application.description ?? "Unknown",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Offstage(
              offstage: !_hover,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.push_pin_rounded),
                  ),
                  QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.settings_outlined),
                  ),
                  QuickActionButton(
                    size: 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.zero,
                    leading: Icon(Icons.more_vert_rounded),
                  ),
                ],
              )),
          onTap: () {
            widget.application.launch(context);
          },
        ),
      ),
    );
  }
}
