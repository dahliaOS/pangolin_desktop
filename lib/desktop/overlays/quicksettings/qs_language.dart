import 'package:flutter/material.dart';
import 'package:pangolin/widgets/qs_appbar.dart';
import 'package:pangolin/internal/locales/locales.g.dart';
import 'package:easy_localization/easy_localization.dart';

class QsLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Language",
        onTap: () {},
        withSwitch: false,
      ),
      body: ListView.builder(
        itemCount: Locales.supported.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            Locales.supported[index].toString(),
          ),
          onTap: () {
            context.setLocale(Locales.supported[index]);
          },
        ),
      ),
    );
  }
}
