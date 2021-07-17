import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/settings/widgets/settings_card.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  final List<SettingsCard> cards;
  const SettingsPage({required this.title, required this.cards, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PreferenceProvider>(context, listen: false);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 48, top: 32),
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48, vertical: 88),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 500,
            child: SingleChildScrollView(
              child: Column(
                children: this.cards,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
