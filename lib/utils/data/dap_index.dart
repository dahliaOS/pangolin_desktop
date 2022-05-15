import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';
import 'package:pangolin/utils/data/package_model.dart';

String applicationPath = '${Platform.environment['HOME']!}/Applications/data/';

void indexApplications() {
//remove every web app from the list of applications

  final List<String> packages =
      Process.runSync('ls', [applicationPath]).stdout.toString().split('\n');
  print(packages);
  for (final String package in packages) {
    if (package.endsWith('.json')) {
      Process.run('cat', ['$applicationPath$package']).then(
        (result) {
          final String rawData = result.stdout.toString();
          print(rawData);
          final Map<String, dynamic> json =
              jsonDecode(rawData) as Map<String, dynamic>;
          final manifest = PackageManifest.fromJson(json);

          applications.add(
            Application(
              app: appInfoPage(
                "${manifest.package.first.realName} - Web Application",
                Color(
                  int.parse(
                    manifest.package.first.accentColor.substring(1, 7),
                    radix: 16,
                  ),
                ).withOpacity(1),
                manifest,
              ),
              packageName: manifest.package.first.id,
              name: manifest.package.first.realName,
              iconName:
                  '${applicationPath}icons/${manifest.package.first.id}${manifest.package.first.iconURL.substring(manifest.package.first.iconURL.length - 4)}',
              color: Color.alphaBlend(
                Colors.black.withOpacity(0.2),
                Color(
                  int.parse(
                    manifest.package.first.accentColor.substring(1, 7),
                    radix: 16,
                  ),
                ).withOpacity(1),
              ),
              description: manifest.package.first.description,
              category: ApplicationCategory.internet,
              runtimeFlags: [
                '--no-sandbox',
                '--accent=${manifest.package.first.accentColor}',
                '--title=${manifest.package.first.realName}',
                '--windowbar=${manifest.package.first.titleBarColor}',
                '--bg=${manifest.package.first.backgroundColor}',
                '--mode=${manifest.package.first.themeMode}',
                '--source=${manifest.package.first.url}',
                '--icon=${applicationPath}icons/${manifest.package.first.id}${manifest.package.first.iconURL.substring(manifest.package.first.iconURL.length - 4)}'
              ],
              systemExecutable: true,
              supportsWeb: false,
            ),
          );
        },
      );
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
              : Colors.black,
        ),
      ),
      backgroundColor: accentColor,
    ),
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(
                  File(
                    '${applicationPath}icons/${manifest.package.first.id}${manifest.package.first.iconURL.substring(manifest.package.first.iconURL.length - 4)}',
                  ),
                  height: 64,
                ),
                Container(
                  height: 16,
                ),
                Text(
                  manifest.package.first.realName,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(manifest.package.first.version),
                Container(
                  height: 16,
                ),
                const Text(
                  "Warning: You are running dahliaOS as root. Web runtime sandboxing is disabled.",
                ),
                Container(
                  height: 16,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accentColor),
                  ),
                  onPressed: () {
                    Process.run(
                      'io.dahliaos.web_runtime.dap',
                      [
                        '--no-sandbox',
                        '--accent=${manifest.package.first.accentColor}',
                        '--title=${manifest.package.first.realName}',
                        '--windowbar=${manifest.package.first.titleBarColor}',
                        '--bg=${manifest.package.first.backgroundColor}',
                        '--mode=${manifest.package.first.themeMode}',
                        '--source=${manifest.package.first.url}',
                        '--icon=${applicationPath}icons/${manifest.package.first.id}${manifest.package.first.iconURL.substring(manifest.package.first.iconURL.length - 4)}'
                      ],
                    );
                  },
                  icon: const Icon(Icons.autorenew),
                  label: Text(
                    'RESTART ${manifest.package.first.realName.toUpperCase()}',
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                child: ListView(
                  children: <Widget>[
                    manifestItem('ID', manifest.package.first.id),
                    manifestItem('Alt Name', manifest.package.first.altName),
                    manifestItem('Real Name', manifest.package.first.realName),
                    manifestItem('Version', manifest.package.first.version),
                    manifestItem(
                      'Description',
                      manifest.package.first.description,
                    ),
                    manifestItem('URL', manifest.package.first.url),
                    manifestItem('IconURL', manifest.package.first.iconURL),
                    manifestItem(
                      'AccentColor',
                      manifest.package.first.accentColor,
                    ),
                    manifestItem(
                      'TitlebarColor',
                      manifest.package.first.titleBarColor,
                    ),
                    manifestItem('ThemeMode', manifest.package.first.themeMode),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
