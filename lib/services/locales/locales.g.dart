// @dart=2.12

import 'dart:ui';

// ignore_for_file: avoid_escaping_inner_quotes
class Locales {
  Locales._();

  static List<Locale> get supported => [
        const Locale("en", "US"),
      ];

  static Map<String, Map<String, String>> get data => {
        _$LocaleEnUS().locale: _$LocaleEnUS().data,
      };

  static Map<String, int> get stringData => {
        _$LocaleEnUS().locale: _$LocaleEnUS().translatedStrings,
      };
}

abstract class _$LocaleBase {
  String? locale;
  Map<String, String>? data;
  int? translatedStrings;
}

class _$LocaleEnUS extends _$LocaleBase {
  @override
  String get locale => "en-US";

  @override
  Map<String, String> get data => {
        "global.account.local": "Local Account",
        "global.account.user_accounts": "User Accounts",
        "global.on": "On",
        "global.off": "Off",
        "global.settings": "Settings",
        "global.coming_soon": "Coming Soon",
        "global.save": "Save",
        "global.search": "Search",
        "apps.authenticator": "Authenticator",
        "apps.calculator": "Calculator",
        "apps.clock": "Clock",
        "apps.containers": "Graft",
        "apps.disks": "Disks",
        "apps.files": "Files",
        "apps.media": "Media",
        "apps.music": "Music",
        "apps.notes": "Text Editor",
        "apps.notesmobile": "Notes (Mobile)",
        "apps.messages": "Messages",
        "apps.rootterminal": "Root Terminal",
        "apps.settings": "Settings",
        "apps.systemlogs": "System Logs",
        "apps.taskmanager": "Task Manager",
        "apps.terminal": "Terminal",
        "apps.themedemo": "Theme Demo",
        "apps.welcome": "Welcome",
        "apps.help": "Help",
        "apps.web": "Web Browser",
        "apps.authenticator_description": "Two Factor Authorization",
        "apps.calculator_description":
            "Addition, Subtraction, Multiplication, and Division",
        "apps.clock_description":
            "Manage Time, Alarms, Stopwatches and World Clocks",
        "apps.containers_description": "Manage your System Containers",
        "apps.disks_description": "Manage Disks and Partitions",
        "apps.files_description": "Browse Files and Folders",
        "apps.media_description": "Browse and watch Photos and Videos",
        "apps.music_description": "Listen to local Music",
        "apps.notes_description": "Edit local Text Files",
        "apps.notesmobile_description": "Notes (Mobile)",
        "apps.messages_description": "Messages",
        "apps.rootterminal_description": "Run Commands as Superuser",
        "apps.settings_description": "Adjust System Settings",
        "apps.systemlogs_description": "Read System Logs",
        "apps.taskmanager_description": "Manage currently running Applications",
        "apps.terminal_description": "Access the Commandline",
        "apps.themedemo_description": "Internal demonstration for app theming",
        "apps.welcome_description": "Welcome Application",
        "apps.help_description": "F.A.Q. and Support",
        "apps.web_description": "Browse the Web",
        "misc.featurenotimplemented_title": "Feature not implemented",
        "misc.featurenotimplemented_value":
            "This feature is currently not available on your build of Pangolin, please see dahliaOS.io to check for updates.",
        "overviewOverlay.new_desktop": "New Desktop",
        "powerOverlay.title": "Power Menu",
        "powerOverlay.subtitle": "Choose what you want to do",
        "powerOverlay.poweroff": "Power off",
        "powerOverlay.sleep": "Sleep",
        "powerOverlay.restart": "Restart",
        "searchOverlay.hint": "Search Device, Apps and Web",
        "searchOverlay.results": "Results",
        "searchOverlay.recent": "Recent",
        "searchOverlay.app": "App",
        "launcherOverlay.categories.all_applications": "All Applications",
        "launcherOverlay.categories.internet": "Internet",
        "launcherOverlay.categories.media": "Media",
        "launcherOverlay.categories.gaming": "gaming",
        "launcherOverlay.categories.development": "Development",
        "launcherOverlay.categories.office": "Office",
        "launcherOverlay.categories.system": "System",
        "quicksettingsOverlay.quick_controls": "Quick Controls",
        "quicksettingsOverlay.quick_controls.network.title": "Network",
        "quicksettingsOverlay.quick_controls.network.subtitle_connected":
            "connected",
        "quicksettingsOverlay.quick_controls.network.subtitle_disconnected":
            "disconnected",
        "quicksettingsOverlay.quick_controls.bluetooth.title": "Bluetooth",
        "quicksettingsOverlay.quick_controls.blueooth.subtitle_connected":
            "connected",
        "quicksettingsOverlay.quick_controls.blueooth.subtitle_disconnected":
            "disconnected",
        "quicksettingsOverlay.quick_controls.airplane_mode.title":
            "Airplane mode",
        "quicksettingsOverlay.quick_controls.language.title": "Language",
        "quicksettingsOverlay.quick_controls.theme.title": "Theme",
        "quicksettingsOverlay.quick_controls.donotdisturb.title":
            "Do not disturb",
        "quicksettingsOverlay.shortcuts.title": "Shortcuts",
        "quicksettingsOverlay.shortcuts.new_event": "New Event",
        "quicksettingsOverlay.shortcuts.alpha_build": "Alpha Build",
        "quicksettingsOverlay.shortcuts.energy_mode":
            "Energy Mode: Performance",
        "quicksettingsOverlay.pages.network.title": "Network Settings",
        "quicksettingsOverlay.pages.theme.title": "Theme Settings",
        "desktop.wallpaper_picker.gone": "Error\nImage does not exist anymore",
        "desktop.wallpaper_picker.url_wallpaper.hint": "Set wallpaper from URL",
        "desktop.wallpaper_picker.url_wallpaper.label": "Wallpaper URL",
        "desktop.wallpaper_picker.bing_wallpaper_button": "Use Bing Wallpaper",
        "desktop.desktop_context_menu.change_wallpaper": "Change Wallpaper",
        "desktop.desktop_context_menu.settings": "Settings",
        "desktop.misc.show_desktop": "Show Desktop",
        "settings.headers.connectivity": "Connectivity",
        "settings.headers.personalize": "Personalize",
        "settings.headers.device": "Device & applications",
        "settings.headers.system": "System",
        "settings.pages.network.title": "Network & internet",
        "settings.pages.network.subtitle": "Wi-Fi, ethernet, data usage",
        "settings.pages.network.wifi": "Wi-Fi",
        "settings.pages.network.wifi_switch_tile.title": "Wi-Fi",
        "settings.pages.network.wifi_switch_tile.subtitle_enabled":
            "Wi-Fi is enabled",
        "settings.pages.network.wifi_switch_tile.subtitle_disabled":
            "Wi-Fi is disbaled",
        "settings.pages.network.wifi_preferences_tile.title":
            "Wi-Fi perferences",
        "settings.pages.network.wifi_preferences_tile.subtitle":
            "Smart Wi-Fi connection, scanning options",
        "settings.pages.network.wifi_saved_networks_tile.title":
            "Saved networks",
        "settings.pages.network.wifi_saved_networks_tile.subtitle":
            "{} networks",
        "settings.pages.network.wifi_data_usage_tile.title": "Wi-Fi data usage",
        "settings.pages.network.wifi_data_usage_tile.subtitle":
            "Data usage for this month",
        "settings.pages.network.ethernet": "Ethernet",
        "settings.pages.network.ethernet_switch_tile.title": "Ethernet",
        "settings.pages.network.ethernet_switch_tile.subtitle_enabled":
            "Ethernet is enabled",
        "settings.pages.network.ethernet_switch_tile.subtitle_disabled":
            "Ethernet is disbaled",
        "settings.pages.network.ethernet_data_usage_tile.title":
            "Wi-Fi data usage",
        "settings.pages.network.ethernet_data_usage_tile.subtitle":
            "Data usage for this month",
        "settings.pages.network.network_options": "Network options",
        "settings.pages.network.network_options.vpn_tile.title":
            "Virtual Private Network (VPN)",
        "settings.pages.network.network_options.vpn_tile.subtitle": "None",
        "settings.pages.network.network_options.vpn_tile.button": "VPN options",
        "settings.pages.network.network_options.dns_tile.title": "Private DNS",
        "settings.pages.network.network_options.dns_tile.subtitle": "Automatic",
        "settings.pages.network.network_options.dns_tile.button": "DNS options",
        "settings.pages.connections.title": "Connected devices",
        "settings.pages.connections.subtitle":
            "Bluetooth, printer, USB devices",
        "settings.pages.connections.bluetooth": "Bluetooth",
        "settings.pages.connections.bluetooth_switch_tile.title": "Bluetooth",
        "settings.pages.connections.bluetooth_switch_tile.subtitle_enabled":
            "Bluetooth is enabled",
        "settings.pages.connections.bluetooth_switch_tile.subtitle_disabled":
            "Bluetooth is disbaled",
        "settings.pages.connections.bluetooth_file_transfer_tile.title":
            "Files received via Bluetooth",
        "settings.pages.connections.phone_integration": "Phone integration",
        "settings.pages.connections.phone_integration_tile.title":
            "Phone integration",
        "settings.pages.connections.phone_integration_tile.subtitle":
            "Phone integration is disabled",
        "settings.pages.customization.title": "Customization",
        "settings.pages.customization.subtitle": "Personalize your experience",
        "settings.pages.customization.theme": "Theme",
        "settings.pages.customization.theme_mode_light": "Light",
        "settings.pages.customization.theme_mode_dark": "Dark",
        "settings.pages.customization.theme_color_orange": "Orange",
        "settings.pages.customization.theme_color_red": "Red",
        "settings.pages.customization.theme_color_green": "Green",
        "settings.pages.customization.theme_color_blue": "Blue",
        "settings.pages.customization.theme_color_teal": "Teal",
        "settings.pages.customization.theme_color_pruple": "Pruple",
        "settings.pages.customization.theme_color_aqua": "Aqua",
        "settings.pages.customization.theme_color_gold": "Gold",
        "settings.pages.customization.theme_color_anthracite": "Anthracite",
        "settings.pages.customization.taskbar_alignment": "Taskbar alignment",
        "settings.pages.customization.taskbar_alignment_start": "Start",
        "settings.pages.customization.taskbar_alignment_center": "Center",
        "settings.pages.customization.window_options": "Window options",
        "settings.pages.customization.window_options_border_radius.title":
            "Window border radius - {}",
        "settings.pages.customization.window_options_border_radius.subtitle":
            "Change the window border radius",
        "settings.pages.customization.window_options_colored_titlebars.title":
            "Colored titlebars",
        "settings.pages.customization.window_options_colored_titlebars.subtitle":
            "Use colored titlebars for the windows",
        "settings.pages.display.title": "Display",
        "settings.pages.display.subtitle":
            "Resolution, screen timeout, scaling",
        "settings.pages.sound.title": "Sound",
        "settings.pages.sound.subtitle":
            "Volume, Do Not Disturb, startup sound",
        "settings.pages.locale.title": "Locale",
        "settings.pages.locale.subtitle":
            "Language, time and date, keyboard layout",
        "settings.pages.notifications.title": "Notifications",
        "settings.pages.notifications.subtitle":
            "Notification sound, app selection",
        "settings.pages.applications.title": "Applications",
        "settings.pages.applications.subtitle": "Installed apps, default apps",
        "settings.pages.developer_options.title": "Developer options",
        "settings.pages.developer_options.subtitle":
            "Feature flags, advanced options",
        "settings.pages.developer_options.developer_mode_tile.title":
            "Developer mode",
        "settings.pages.developer_options.developer_mode_tile.subtitle":
            "Activate advanced debugging features",
        "settings.pages.about.title": "About device",
        "settings.pages.about.subtitle": "System version, device information",
        "settings.pages.about.system_information": "System information",
        "settings.pages.about.system_information_environment": "Environment",
        "settings.pages.about.system_information_architecture": "Architecture",
        "settings.pages.about.system_information_desktop": "Desktop",
        "settings.pages.about.software_update": "Software update",
        "settings.pages.about.software_update_tile.title":
            "dahliaOS is up to date - {}",
        "settings.pages.about.software_update_tile.subtitle":
            "Last checked: {}",
        "settings.pages.about.software_update_tile.button": "Check for updates",
      };

  @override
  int get translatedStrings => 176;
}
