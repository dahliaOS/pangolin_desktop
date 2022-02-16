// ignore_for_file: non_constant_identifier_names

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

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/utils/providers/icon_provider.dart';
import 'package:unicons/unicons.dart';

class IconsX {
  late BuildContext context;

  IconsX.of(this.context);

  IconData get wifi {
    final iconPack = IconProvider.of(context).iconPack;
    switch (iconPack) {
      case "material":
        return Icons.wifi;
      case "fluent":
        return FluentIcons.wifi_1_24_regular;
      case "unicons":
        return UniconsLine.wifi;
      default:
        return Icons.wifi;
    }
  }

  IconData get settings {
    final iconPack = IconProvider.of(context).iconPack;
    switch (iconPack) {
      case "material":
        return Icons.settings_outlined;
      case "fluent":
        return FluentIcons.settings_24_regular;
      case "unicons":
        return UniconsLine.setting;
      default:
        return Icons.settings;
    }
  }

  IconData get edit {
    final iconPack = IconProvider.of(context).iconPack;
    switch (iconPack) {
      case "material":
        return Icons.edit;
      case "fluent":
        return FluentIcons.edit_24_regular;
      case "unicons":
        return UniconsLine.edit;
      default:
        return Icons.edit;
    }
  }

  IconData get sign_out {
    final iconPack = IconProvider.of(context).iconPack;
    switch (iconPack) {
      case "material":
        return Icons.logout;
      case "fluent":
        return FluentIcons.panel_right_contract_24_regular;
      case "unicons":
        return UniconsLine.exit;
      default:
        return Icons.logout;
    }
  }

  IconData get power {
    final iconPack = IconProvider.of(context).iconPack;
    switch (iconPack) {
      case "material":
        return Icons.power_settings_new;
      case "fluent":
        return FluentIcons.power_24_regular;
      case "unicons":
        return UniconsLine.power;
      default:
        return Icons.power_settings_new;
    }
  }
}
