import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/dap_index.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';

void wapInstall(url) async {
  Response response = await get(Uri.parse('https://packages.dahliaos.io/$url'));
  File file = File(url);
  file.writeAsBytes(response.bodyBytes);
}

ListTile webApp(String name, String description, String url) async {
  return ListTile(
    title: Text(name),
    subtitle: Text(description),
    trailing: ElevatedButton(
      child: Text('INSTALL'),
      onPressed: () {
        applications.removeWhere((app) => app.systemExecutable == true);
        await wapInstall(url);
      },
    ),
  );
}

Widget WebAppManager() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Web App Manager',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: WebAppManagerHomePage(),
  );
}

Widget WebAppManagerHomePage() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Web App Manager'),
    ),
    body: Center(
      child: ListView(children: [
        webApp(
            "Discord", "Chat, Talk & Hangout", "com.discordapp.discord.json"),
        webApp("Visual Studio Code", "Code editing. Redefined.",
            "dev.vscode.app.json"),
        webApp("Google", "Google Search", "com.google.search.json"),
        webApp("Townscaper", "City builder game",
            "com.oskarstalberg.townscaper.json"),
        webApp("dahliaOS Documentation", "dahliaOS Documentation",
            "io.dahliaos.documentation.json"),
        webApp("Minecraft Classic", "Minecraft Classic Online",
            "net.minecraft.classic.json"),
      ]),
    ),
  );
}
