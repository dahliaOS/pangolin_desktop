/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:pangolin/components/overlays/quick_settings/widgets/qs_titlebar.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/global/quick_button.dart';

class QsAccountPage extends StatelessWidget {
  const QsAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: QsTitlebar(
        title: "User Accounts",
        trailing: [
          QuickActionButton(
            leading: Icon(
              Icons.help_outline_rounded,
              size: 20,
            ),
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
