import 'package:yatl_gen/yatl_gen.dart';
import 'package:yatl/yatl.dart';

class GlobalLocaleStrings extends LocaleStrings {
  const GlobalLocaleStrings._(YatlCore core) : super(core);

  String get accountLocal {
    return core.translate("global.account.local");
  }

  String get accountUserAccounts {
    return core.translate("global.account.user_accounts");
  }

  String get on {
    return core.translate("global.on");
  }

  String get off {
    return core.translate("global.off");
  }

  String get settings {
    return core.translate("global.settings");
  }

  String get comingSoon {
    return core.translate("global.coming_soon");
  }

  String get save {
    return core.translate("global.save");
  }

  String get search {
    return core.translate("global.search");
  }
}

class AppsLocaleStrings extends LocaleStrings {
  const AppsLocaleStrings._(YatlCore core) : super(core);

  String get authenticator {
    return core.translate("apps.authenticator");
  }

  String get calculator {
    return core.translate("apps.calculator");
  }

  String get clock {
    return core.translate("apps.clock");
  }

  /// Do not actually translate this string, just write "Graft" as the translation
  String get containers {
    return core.translate("apps.containers");
  }

  String get disks {
    return core.translate("apps.disks");
  }

  String get files {
    return core.translate("apps.files");
  }

  String get media {
    return core.translate("apps.media");
  }

  String get music {
    return core.translate("apps.music");
  }

  String get notes {
    return core.translate("apps.notes");
  }

  String get notesmobile {
    return core.translate("apps.notesmobile");
  }

  String get messages {
    return core.translate("apps.messages");
  }

  String get rootterminal {
    return core.translate("apps.rootterminal");
  }

  String get settings {
    return core.translate("apps.settings");
  }

  String get systemlogs {
    return core.translate("apps.systemlogs");
  }

  String get taskmanager {
    return core.translate("apps.taskmanager");
  }

  String get terminal {
    return core.translate("apps.terminal");
  }

  String get themedemo {
    return core.translate("apps.themedemo");
  }

  String get welcome {
    return core.translate("apps.welcome");
  }

  String get help {
    return core.translate("apps.help");
  }

  String get web {
    return core.translate("apps.web");
  }

  String get authenticatorDescription {
    return core.translate("apps.authenticator_description");
  }

  String get calculatorDescription {
    return core.translate("apps.calculator_description");
  }

  String get clockDescription {
    return core.translate("apps.clock_description");
  }

  String get containersDescription {
    return core.translate("apps.containers_description");
  }

  String get disksDescription {
    return core.translate("apps.disks_description");
  }

  String get filesDescription {
    return core.translate("apps.files_description");
  }

  String get mediaDescription {
    return core.translate("apps.media_description");
  }

  String get musicDescription {
    return core.translate("apps.music_description");
  }

  String get notesDescription {
    return core.translate("apps.notes_description");
  }

  String get notesmobileDescription {
    return core.translate("apps.notesmobile_description");
  }

  String get messagesDescription {
    return core.translate("apps.messages_description");
  }

  String get rootterminalDescription {
    return core.translate("apps.rootterminal_description");
  }

  String get settingsDescription {
    return core.translate("apps.settings_description");
  }

  String get systemlogsDescription {
    return core.translate("apps.systemlogs_description");
  }

  String get taskmanagerDescription {
    return core.translate("apps.taskmanager_description");
  }

  String get terminalDescription {
    return core.translate("apps.terminal_description");
  }

  String get themedemoDescription {
    return core.translate("apps.themedemo_description");
  }

  String get welcomeDescription {
    return core.translate("apps.welcome_description");
  }

  String get helpDescription {
    return core.translate("apps.help_description");
  }

  String get webDescription {
    return core.translate("apps.web_description");
  }

  /// App store application name
  String get appStore {
    return core.translate("apps.app_store");
  }

  /// App Store application description
  String get appStoreDescription {
    return core.translate("apps.app_store_description");
  }
}

class MiscLocaleStrings extends LocaleStrings {
  const MiscLocaleStrings._(YatlCore core) : super(core);

  String get featurenotimplementedTitle {
    return core.translate("misc.featurenotimplemented_title");
  }

  String get featurenotimplementedValue {
    return core.translate("misc.featurenotimplemented_value");
  }
}

class OverviewOverlayLocaleStrings extends LocaleStrings {
  const OverviewOverlayLocaleStrings._(YatlCore core) : super(core);

  String get newDesktop {
    return core.translate("overviewOverlay.new_desktop");
  }
}

class PowerOverlayLocaleStrings extends LocaleStrings {
  const PowerOverlayLocaleStrings._(YatlCore core) : super(core);

  String get title {
    return core.translate("powerOverlay.title");
  }

  String get subtitle {
    return core.translate("powerOverlay.subtitle");
  }

  String get poweroff {
    return core.translate("powerOverlay.poweroff");
  }

  String get sleep {
    return core.translate("powerOverlay.sleep");
  }

  String get restart {
    return core.translate("powerOverlay.restart");
  }
}

class SearchOverlayLocaleStrings extends LocaleStrings {
  const SearchOverlayLocaleStrings._(YatlCore core) : super(core);

  String get hint {
    return core.translate("searchOverlay.hint");
  }

  String get results {
    return core.translate("searchOverlay.results");
  }

  String get recent {
    return core.translate("searchOverlay.recent");
  }

  String get app {
    return core.translate("searchOverlay.app");
  }
}

class LauncherOverlayLocaleStrings extends LocaleStrings {
  const LauncherOverlayLocaleStrings._(YatlCore core) : super(core);

  String get categoriesAllApplications {
    return core.translate("launcherOverlay.categories.all_applications");
  }

  String get categoriesInternet {
    return core.translate("launcherOverlay.categories.internet");
  }

  String get categoriesMedia {
    return core.translate("launcherOverlay.categories.media");
  }

  String get categoriesGaming {
    return core.translate("launcherOverlay.categories.gaming");
  }

  String get categoriesDevelopment {
    return core.translate("launcherOverlay.categories.development");
  }

  String get categoriesOffice {
    return core.translate("launcherOverlay.categories.office");
  }

  String get categoriesSystem {
    return core.translate("launcherOverlay.categories.system");
  }
}

class QuicksettingsOverlayLocaleStrings extends LocaleStrings {
  const QuicksettingsOverlayLocaleStrings._(YatlCore core) : super(core);

  String get quickControls {
    return core.translate("quicksettingsOverlay.quick_controls");
  }

  String get quickControlsNetworkTitle {
    return core.translate("quicksettingsOverlay.quick_controls.network.title");
  }

  String get quickControlsNetworkSubtitleConnected {
    return core.translate(
        "quicksettingsOverlay.quick_controls.network.subtitle_connected");
  }

  String get quickControlsNetworkSubtitleDisconnected {
    return core.translate(
        "quicksettingsOverlay.quick_controls.network.subtitle_disconnected");
  }

  String get quickControlsBluetoothTitle {
    return core
        .translate("quicksettingsOverlay.quick_controls.bluetooth.title");
  }

  String get quickControlsBlueoothSubtitleConnected {
    return core.translate(
        "quicksettingsOverlay.quick_controls.blueooth.subtitle_connected");
  }

  String get quickControlsBlueoothSubtitleDisconnected {
    return core.translate(
        "quicksettingsOverlay.quick_controls.blueooth.subtitle_disconnected");
  }

  String get quickControlsAirplaneModeTitle {
    return core
        .translate("quicksettingsOverlay.quick_controls.airplane_mode.title");
  }

  String get quickControlsLanguageTitle {
    return core.translate("quicksettingsOverlay.quick_controls.language.title");
  }

  String get quickControlsThemeTitle {
    return core.translate("quicksettingsOverlay.quick_controls.theme.title");
  }

  String get quickControlsDonotdisturbTitle {
    return core
        .translate("quicksettingsOverlay.quick_controls.donotdisturb.title");
  }

  String get shortcutsTitle {
    return core.translate("quicksettingsOverlay.shortcuts.title");
  }

  String get shortcutsNewEvent {
    return core.translate("quicksettingsOverlay.shortcuts.new_event");
  }

  String get shortcutsAlphaBuild {
    return core.translate("quicksettingsOverlay.shortcuts.alpha_build");
  }

  String get shortcutsEnergyMode {
    return core.translate("quicksettingsOverlay.shortcuts.energy_mode");
  }

  String get pagesNetworkTitle {
    return core.translate("quicksettingsOverlay.pages.network.title");
  }

  String get pagesThemeTitle {
    return core.translate("quicksettingsOverlay.pages.theme.title");
  }
}

class DesktopLocaleStrings extends LocaleStrings {
  const DesktopLocaleStrings._(YatlCore core) : super(core);

  String get wallpaperPickerGone {
    return core.translate("desktop.wallpaper_picker.gone");
  }

  String get wallpaperPickerUrlWallpaperHint {
    return core.translate("desktop.wallpaper_picker.url_wallpaper.hint");
  }

  String get wallpaperPickerUrlWallpaperLabel {
    return core.translate("desktop.wallpaper_picker.url_wallpaper.label");
  }

  String get wallpaperPickerBingWallpaperButton {
    return core.translate("desktop.wallpaper_picker.bing_wallpaper_button");
  }

  String get desktopContextMenuChangeWallpaper {
    return core.translate("desktop.desktop_context_menu.change_wallpaper");
  }

  String get desktopContextMenuSettings {
    return core.translate("desktop.desktop_context_menu.settings");
  }

  String get miscShowDesktop {
    return core.translate("desktop.misc.show_desktop");
  }
}

class SettingsLocaleStrings extends LocaleStrings {
  const SettingsLocaleStrings._(YatlCore core) : super(core);

  String get headersConnectivity {
    return core.translate("settings.headers.connectivity");
  }

  String get headersPersonalize {
    return core.translate("settings.headers.personalize");
  }

  String get headersDevice {
    return core.translate("settings.headers.device");
  }

  String get headersSystem {
    return core.translate("settings.headers.system");
  }

  String get pagesNetworkTitle {
    return core.translate("settings.pages.network.title");
  }

  String get pagesNetworkSubtitle {
    return core.translate("settings.pages.network.subtitle");
  }

  String get pagesNetworkWifi {
    return core.translate("settings.pages.network.wifi");
  }

  String get pagesNetworkWifiSwitchTileTitle {
    return core.translate("settings.pages.network.wifi_switch_tile.title");
  }

  String get pagesNetworkWifiSwitchTileSubtitleEnabled {
    return core
        .translate("settings.pages.network.wifi_switch_tile.subtitle_enabled");
  }

  String get pagesNetworkWifiSwitchTileSubtitleDisabled {
    return core
        .translate("settings.pages.network.wifi_switch_tile.subtitle_disabled");
  }

  String get pagesNetworkWifiPreferencesTileTitle {
    return core.translate("settings.pages.network.wifi_preferences_tile.title");
  }

  String get pagesNetworkWifiPreferencesTileSubtitle {
    return core
        .translate("settings.pages.network.wifi_preferences_tile.subtitle");
  }

  String get pagesNetworkWifiSavedNetworksTileTitle {
    return core
        .translate("settings.pages.network.wifi_saved_networks_tile.title");
  }

  String pagesNetworkWifiSavedNetworksTileSubtitle(Object arg0) {
    return core.translate(
      "settings.pages.network.wifi_saved_networks_tile.subtitle",
      arguments: [arg0.toString()],
    );
  }

  String get pagesNetworkWifiDataUsageTileTitle {
    return core.translate("settings.pages.network.wifi_data_usage_tile.title");
  }

  String get pagesNetworkWifiDataUsageTileSubtitle {
    return core
        .translate("settings.pages.network.wifi_data_usage_tile.subtitle");
  }

  String get pagesNetworkEthernet {
    return core.translate("settings.pages.network.ethernet");
  }

  String get pagesNetworkEthernetSwitchTileTitle {
    return core.translate("settings.pages.network.ethernet_switch_tile.title");
  }

  String get pagesNetworkEthernetSwitchTileSubtitleEnabled {
    return core.translate(
        "settings.pages.network.ethernet_switch_tile.subtitle_enabled");
  }

  String get pagesNetworkEthernetSwitchTileSubtitleDisabled {
    return core.translate(
        "settings.pages.network.ethernet_switch_tile.subtitle_disabled");
  }

  String get pagesNetworkEthernetDataUsageTileTitle {
    return core
        .translate("settings.pages.network.ethernet_data_usage_tile.title");
  }

  String get pagesNetworkEthernetDataUsageTileSubtitle {
    return core
        .translate("settings.pages.network.ethernet_data_usage_tile.subtitle");
  }

  String get pagesNetworkNetworkOptions {
    return core.translate("settings.pages.network.network_options");
  }

  String get pagesNetworkNetworkOptionsVpnTileTitle {
    return core
        .translate("settings.pages.network.network_options.vpn_tile.title");
  }

  String get pagesNetworkNetworkOptionsVpnTileSubtitle {
    return core
        .translate("settings.pages.network.network_options.vpn_tile.subtitle");
  }

  String get pagesNetworkNetworkOptionsVpnTileButton {
    return core
        .translate("settings.pages.network.network_options.vpn_tile.button");
  }

  String get pagesNetworkNetworkOptionsDnsTileTitle {
    return core
        .translate("settings.pages.network.network_options.dns_tile.title");
  }

  String get pagesNetworkNetworkOptionsDnsTileSubtitle {
    return core
        .translate("settings.pages.network.network_options.dns_tile.subtitle");
  }

  String get pagesNetworkNetworkOptionsDnsTileButton {
    return core
        .translate("settings.pages.network.network_options.dns_tile.button");
  }

  String get pagesConnectionsTitle {
    return core.translate("settings.pages.connections.title");
  }

  String get pagesConnectionsSubtitle {
    return core.translate("settings.pages.connections.subtitle");
  }

  String get pagesConnectionsBluetooth {
    return core.translate("settings.pages.connections.bluetooth");
  }

  String get pagesConnectionsBluetoothSwitchTileTitle {
    return core
        .translate("settings.pages.connections.bluetooth_switch_tile.title");
  }

  String get pagesConnectionsBluetoothSwitchTileSubtitleEnabled {
    return core.translate(
        "settings.pages.connections.bluetooth_switch_tile.subtitle_enabled");
  }

  String get pagesConnectionsBluetoothSwitchTileSubtitleDisabled {
    return core.translate(
        "settings.pages.connections.bluetooth_switch_tile.subtitle_disabled");
  }

  String get pagesConnectionsBluetoothFileTransferTileTitle {
    return core.translate(
        "settings.pages.connections.bluetooth_file_transfer_tile.title");
  }

  String get pagesConnectionsPhoneIntegration {
    return core.translate("settings.pages.connections.phone_integration");
  }

  String get pagesConnectionsPhoneIntegrationTileTitle {
    return core
        .translate("settings.pages.connections.phone_integration_tile.title");
  }

  String get pagesConnectionsPhoneIntegrationTileSubtitle {
    return core.translate(
        "settings.pages.connections.phone_integration_tile.subtitle");
  }

  String get pagesCustomizationTitle {
    return core.translate("settings.pages.customization.title");
  }

  String get pagesCustomizationSubtitle {
    return core.translate("settings.pages.customization.subtitle");
  }

  String get pagesCustomizationTheme {
    return core.translate("settings.pages.customization.theme");
  }

  String get pagesCustomizationThemeModeLight {
    return core.translate("settings.pages.customization.theme_mode_light");
  }

  String get pagesCustomizationThemeModeDark {
    return core.translate("settings.pages.customization.theme_mode_dark");
  }

  String get pagesCustomizationThemeColorOrange {
    return core.translate("settings.pages.customization.theme_color_orange");
  }

  String get pagesCustomizationThemeColorRed {
    return core.translate("settings.pages.customization.theme_color_red");
  }

  String get pagesCustomizationThemeColorGreen {
    return core.translate("settings.pages.customization.theme_color_green");
  }

  String get pagesCustomizationThemeColorBlue {
    return core.translate("settings.pages.customization.theme_color_blue");
  }

  String get pagesCustomizationThemeColorTeal {
    return core.translate("settings.pages.customization.theme_color_teal");
  }

  /// settings.pages.customization.theme_color_purple
  String get pagesCustomizationThemeColorPruple {
    return core.translate("settings.pages.customization.theme_color_pruple");
  }

  String get pagesCustomizationThemeColorAqua {
    return core.translate("settings.pages.customization.theme_color_aqua");
  }

  String get pagesCustomizationThemeColorGold {
    return core.translate("settings.pages.customization.theme_color_gold");
  }

  String get pagesCustomizationThemeColorAnthracite {
    return core
        .translate("settings.pages.customization.theme_color_anthracite");
  }

  String get pagesCustomizationTaskbarAlignment {
    return core.translate("settings.pages.customization.taskbar_alignment");
  }

  String get pagesCustomizationTaskbarAlignmentStart {
    return core
        .translate("settings.pages.customization.taskbar_alignment_start");
  }

  String get pagesCustomizationTaskbarAlignmentCenter {
    return core
        .translate("settings.pages.customization.taskbar_alignment_center");
  }

  String get pagesCustomizationWindowOptions {
    return core.translate("settings.pages.customization.window_options");
  }

  String pagesCustomizationWindowOptionsBorderRadiusTitle(Object arg0) {
    return core.translate(
      "settings.pages.customization.window_options_border_radius.title",
      arguments: [arg0.toString()],
    );
  }

  String get pagesCustomizationWindowOptionsBorderRadiusSubtitle {
    return core.translate(
        "settings.pages.customization.window_options_border_radius.subtitle");
  }

  String get pagesCustomizationWindowOptionsColoredTitlebarsTitle {
    return core.translate(
        "settings.pages.customization.window_options_colored_titlebars.title");
  }

  String get pagesCustomizationWindowOptionsColoredTitlebarsSubtitle {
    return core.translate(
        "settings.pages.customization.window_options_colored_titlebars.subtitle");
  }

  String get pagesCustomizationWindowOptionsTransparentColoredTitlebarsTitle {
    return core.translate(
        "settings.pages.customization.window_options_transparent_colored_titlebars.title");
  }

  String
      get pagesCustomizationWindowOptionsTransparentColoredTitlebarsSubtitle {
    return core.translate(
        "settings.pages.customization.window_options_transparent_colored_titlebars.subtitle");
  }

  String get pagesDisplayTitle {
    return core.translate("settings.pages.display.title");
  }

  String get pagesDisplaySubtitle {
    return core.translate("settings.pages.display.subtitle");
  }

  String get pagesSoundTitle {
    return core.translate("settings.pages.sound.title");
  }

  String get pagesSoundSubtitle {
    return core.translate("settings.pages.sound.subtitle");
  }

  String get pagesLocaleTitle {
    return core.translate("settings.pages.locale.title");
  }

  String get pagesLocaleSubtitle {
    return core.translate("settings.pages.locale.subtitle");
  }

  String get pagesNotificationsTitle {
    return core.translate("settings.pages.notifications.title");
  }

  String get pagesNotificationsSubtitle {
    return core.translate("settings.pages.notifications.subtitle");
  }

  String get pagesApplicationsTitle {
    return core.translate("settings.pages.applications.title");
  }

  String get pagesApplicationsSubtitle {
    return core.translate("settings.pages.applications.subtitle");
  }

  String get pagesDeveloperOptionsTitle {
    return core.translate("settings.pages.developer_options.title");
  }

  String get pagesDeveloperOptionsSubtitle {
    return core.translate("settings.pages.developer_options.subtitle");
  }

  String get pagesDeveloperOptionsDeveloperModeTileTitle {
    return core.translate(
        "settings.pages.developer_options.developer_mode_tile.title");
  }

  String get pagesDeveloperOptionsDeveloperModeTileSubtitle {
    return core.translate(
        "settings.pages.developer_options.developer_mode_tile.subtitle");
  }

  String get pagesAboutTitle {
    return core.translate("settings.pages.about.title");
  }

  String get pagesAboutSubtitle {
    return core.translate("settings.pages.about.subtitle");
  }

  String get pagesAboutSystemInformation {
    return core.translate("settings.pages.about.system_information");
  }

  String get pagesAboutSystemInformationEnvironment {
    return core
        .translate("settings.pages.about.system_information_environment");
  }

  String get pagesAboutSystemInformationArchitecture {
    return core
        .translate("settings.pages.about.system_information_architecture");
  }

  String get pagesAboutSystemInformationDesktop {
    return core.translate("settings.pages.about.system_information_desktop");
  }

  String get pagesAboutSoftwareUpdate {
    return core.translate("settings.pages.about.software_update");
  }

  String pagesAboutSoftwareUpdateTileTitle(Object arg0) {
    return core.translate(
      "settings.pages.about.software_update_tile.title",
      arguments: [arg0.toString()],
    );
  }

  String pagesAboutSoftwareUpdateTileSubtitle(Object arg0) {
    return core.translate(
      "settings.pages.about.software_update_tile.subtitle",
      arguments: [arg0.toString()],
    );
  }

  String get pagesAboutSoftwareUpdateTileButton {
    return core.translate("settings.pages.about.software_update_tile.button");
  }
}

class GeneratedLocaleStrings extends LocaleStrings {
  GeneratedLocaleStrings(YatlCore core) : super(core);

  late final GlobalLocaleStrings global = GlobalLocaleStrings._(core);

  late final AppsLocaleStrings apps = AppsLocaleStrings._(core);

  late final MiscLocaleStrings misc = MiscLocaleStrings._(core);

  late final OverviewOverlayLocaleStrings overviewOverlay =
      OverviewOverlayLocaleStrings._(core);

  late final PowerOverlayLocaleStrings powerOverlay =
      PowerOverlayLocaleStrings._(core);

  late final SearchOverlayLocaleStrings searchOverlay =
      SearchOverlayLocaleStrings._(core);

  late final LauncherOverlayLocaleStrings launcherOverlay =
      LauncherOverlayLocaleStrings._(core);

  late final QuicksettingsOverlayLocaleStrings quicksettingsOverlay =
      QuicksettingsOverlayLocaleStrings._(core);

  late final DesktopLocaleStrings desktop = DesktopLocaleStrings._(core);

  late final SettingsLocaleStrings settings = SettingsLocaleStrings._(core);
}
