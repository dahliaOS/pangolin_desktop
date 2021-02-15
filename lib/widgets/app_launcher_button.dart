import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/app_list.dart';
import 'package:pangolin/utils/wm_api.dart';
import 'package:provider/provider.dart';
import 'package:utopia_wm/wm.dart';

class AppLauncherButton extends StatelessWidget {
  final String packageName;
  const AppLauncherButton(this.packageName);
  @override
  Widget build(BuildContext context) {
    final Application application = getApp(packageName) ?? fallbackApp;
    return Container(
      margin: EdgeInsets.all(24),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          onTap: () {
            WmAPI.of(context).popOverlayEntry(
                Provider.of<DismissibleOverlayEntry>(context, listen: false));
            WmAPI.of(context).openApp(packageName);
          },
          focusColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/${application.iconName}.png"),
              SizedBox(
                height: 8,
              ),
              Text(
                application.name ?? "",
                style: TextStyle(fontSize: 17, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
