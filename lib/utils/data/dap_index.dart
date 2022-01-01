import 'dart:io';
import 'package:args/args.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package_model.dart';
import 'dart:async';
import 'dart:convert';
import 'app_list.dart';

var applicationPath = Platform.environment['HOME']! + '/Applications/data/';

void indexApplications() {
  var packages = Process.runSync('ls', ['${applicationPath}'])
      .stdout
      .toString()
      .split('\n');

  for (var package in packages) {
    if (package.endsWith('.json')) {
      Process.run('cat', ['${applicationPath}${package}']).then((result) {
        String rawData = result.stdout.toString();
        final json = jsonDecode(rawData);
        final manifest = PackageManifest.fromJson(json);

        applications.add(Application(
          app: appInfoPage(
              manifest.package[0].realName.toString() + " - Web Application",
              Color(int.parse(manifest.package[0].accentColor.substring(1, 7),
                      radix: 16) +
                  0xFF000000),
              manifest),
          packageName: manifest.package[0].id.toString(),
          name: manifest.package[0].realName.toString(),
          iconName: applicationPath +
              'icons/' +
              manifest.package[0].id.toString() +
              manifest.package[0].iconURL
                  .toString()
                  .substring(manifest.package[0].iconURL.toString().length - 4),
          color: Color.alphaBlend(
              Colors.black.withOpacity(0.2),
              Color(int.parse(manifest.package[0].accentColor.substring(1, 7),
                      radix: 16) +
                  0xFF000000)),
          description: manifest.package[0].description.toString(),
          runtimeFlags: [
            '--accent=' + manifest.package[0].accentColor.toString(),
            '--title=' + manifest.package[0].realName.toString(),
            '--windowbar=' + manifest.package[0].titleBarColor.toString(),
            '--bg=' + manifest.package[0].backgroundColor.toString(),
            '--mode=' + manifest.package[0].themeMode.toString(),
            '--source=' + manifest.package[0].url.toString(),
            '--icon=${applicationPath + 'icons/' + manifest.package[0].id.toString() + manifest.package[0].iconURL.toString().substring(manifest.package[0].iconURL.toString().length - 4)}'
          ],
          systemExecutable: true,
          supportsWeb: false,
        ));
      });
    }
  }
}

Widget appInfoPage(String title, Color accentColor, PackageManifest manifest) {
  ListTile manifestItem(String key, String value) {
    return ListTile(
      title: Text(key),
      subtitle: Text(value),
    );
  }

  return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
              color: (accentColor.computeLuminance() < 0.5)
                  ? Colors.white
                  : Colors.black),
        ),
        backgroundColor: accentColor,
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          child: Expanded(
              child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                Image.file(
                  File(
                      '${applicationPath + 'icons/' + manifest.package[0].id.toString() + manifest.package[0].iconURL.toString().substring(manifest.package[0].iconURL.toString().length - 4)}'),
                  height: 64,
                ),
                Container(
                  height: 16,
                ),
                Text(manifest.package[0].realName.toString(),
                    style: TextStyle(fontSize: 24)),
                Text(manifest.package[0].version.toString()),
                Container(
                  height: 16,
                ),
                RaisedButton.icon(
                    onPressed: () {
                      Process.run(
                        'web_runtime',
                        [
                          '--accent=' +
                              manifest.package[0].accentColor.toString(),
                          '--title=' + manifest.package[0].realName.toString(),
                          '--windowbar=' +
                              manifest.package[0].titleBarColor.toString(),
                          '--bg=' +
                              manifest.package[0].backgroundColor.toString(),
                          '--mode=' + manifest.package[0].themeMode.toString(),
                          '--source=' + manifest.package[0].url.toString(),
                          '--icon=${applicationPath + 'icons/' + manifest.package[0].id.toString() + manifest.package[0].iconURL.toString().substring(manifest.package[0].iconURL.toString().length - 4)}'
                        ],
                      );
                    },
                    icon: Icon(Icons.autorenew),
                    color: accentColor,
                    label: Text('RESTART ' +
                        manifest.package[0].realName.toString().toUpperCase())),
              ]))),
        ),
        Expanded(
          child: Container(
              child: Center(
                  child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                color: Colors.grey.withOpacity(0.2),
                child: ListView(children: <Widget>[
                  manifestItem('ID', manifest.package[0].id.toString()),
                  manifestItem(
                      'Alt Name', manifest.package[0].altName.toString()),
                  manifestItem(
                      'Real Name', manifest.package[0].realName.toString()),
                  manifestItem(
                      'Version', manifest.package[0].version.toString()),
                  manifestItem('Description',
                      manifest.package[0].description.toString()),
                  manifestItem('URL', manifest.package[0].url.toString()),
                  manifestItem(
                      'IconURL', manifest.package[0].iconURL.toString()),
                  manifestItem('AccentColor',
                      manifest.package[0].accentColor.toString()),
                  manifestItem('TitlebarColor',
                      manifest.package[0].titleBarColor.toString()),
                  manifestItem(
                      'ThemeMode', manifest.package[0].themeMode.toString())
                ])),
          ))),
        ),
      ]));
}
