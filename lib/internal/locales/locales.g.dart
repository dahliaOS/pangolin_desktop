import 'dart:ui';

class Locales {
  Locales._();

  static List<Locale> get supported => [
    Locale("de", "DE"),
    Locale("en", "GB"),
    Locale("en", "US"),
    Locale("fr", "FR"),
    Locale("hr", "HR"),
    Locale("id", "ID"),
    Locale("ja", "JP"),
    Locale("nl", "NL"),
    Locale("pt", "BR"),
    Locale("pt", "PT"),
    Locale("tr", "TR"),
    Locale("zh", "TW"),
  ];

  static Map<String, Map<String, String>> get data => {
    _$LocaleDeDE().locale: _$LocaleDeDE().data,
    _$LocaleEnGB().locale: _$LocaleEnGB().data,
    _$LocaleEnUS().locale: _$LocaleEnUS().data,
    _$LocaleFrFR().locale: _$LocaleFrFR().data,
    _$LocaleHrHR().locale: _$LocaleHrHR().data,
    _$LocaleIdID().locale: _$LocaleIdID().data,
    _$LocaleJaJP().locale: _$LocaleJaJP().data,
    _$LocaleNlNL().locale: _$LocaleNlNL().data,
    _$LocalePtBR().locale: _$LocalePtBR().data,
    _$LocalePtPT().locale: _$LocalePtPT().data,
    _$LocaleTrTR().locale: _$LocaleTrTR().data,
    _$LocaleZhTW().locale: _$LocaleZhTW().data,
  };
}

abstract class _$LocaleBase {
  String locale;
  Map<String, String> data;
}

class _$LocaleDeDE extends _$LocaleBase {
  @override
  String get locale => "de-DE";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Authenticator",
    "pangolin.app_calculator": "Rechner",
    "pangolin.app_clock": "Uhr",
    "pangolin.app_disks": "Festplattenverwaltung",
    "pangolin.app_files": "Dateien",
    "pangolin.app_media": "Medien",
    "pangolin.app_music": "Musik",
    "pangolin.app_notes": "Texteditor",
    "pangolin.app_notesmobile": "Notizen (Mobile)",
    "pangolin.app_messages": "Nachrichten",
    "pangolin.app_rootterminal": "Root Terminal",
    "pangolin.app_settings": "Einstellungen",
    "pangolin.app_systemlogs": "Systemprotokoll",
    "pangolin.app_taskmanager": "Task Manager",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Thema Vorschau",
    "pangolin.app_welcome": "Willkommen",
    "pangolin.app_help": "Hilfe",
    "pangolin.app_web": "Web Browser",
    "pangolin.app_developeroptions": "Entwickleroptionen",
    "pangolin.featurenotimplemented_title": "Funktion noch nicht Intigriert",
    "pangolin.featurenotimplemented_value": "Diese Funktion ist in ihrer Version von Pangolin noch nicht verfügbar. Bitte siehe https://reddit.com/r/dahliaos für Aktualisierungen und weiter Informationen.",
    "pangolin.launcher_card_information_title": "Informationen",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Treiber für Intigrierte Grafikkarte aktualisiert",
    "pangolin.launcher_card_music_title": "Musik - Spielt Gerade",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Sicherheit",
    "pangolin.launcher_card_security_value": "Dateisystemsperre ist AN",
    "pangolin.launcher_card_system_title": "System",
    "pangolin.launcher_card_system_value": "Willkommen bei dahliaOS!",
    "pangolin.launcher_search": "Suche Dateien, Apps, Internet...",
    "pangolin.qs_airplanemode": "Flugmodus",
    "pangolin.qs_autorotate": "Automatisch drehen",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Deutsch",
    "pangolin.qs_dnd": "Nicht stören",
    "pangolin.qs_flashlight": "Taschenlampe",
    "pangolin.qs_invertcolors": "Farben umkehren",
    "pangolin.qs_theme": "Thema",
    "pangolin.qs_wifi": "WLAN",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Es ist kalt, trage einen Mantel!",
  };
}


class _$LocaleEnGB extends _$LocaleBase {
  @override
  String get locale => "en-GB";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Authenticator",
    "pangolin.app_calculator": "Calculator",
    "pangolin.app_clock": "Clock",
    "pangolin.app_disks": "Disks",
    "pangolin.app_files": "Files",
    "pangolin.app_media": "Media",
    "pangolin.app_music": "Music",
    "pangolin.app_notes": "Text Editor",
    "pangolin.app_notesmobile": "Notes (Mobile)",
    "pangolin.app_messages": "Messages",
    "pangolin.app_rootterminal": "Root Terminal",
    "pangolin.app_settings": "Settings",
    "pangolin.app_systemlogs": "System Logs",
    "pangolin.app_taskmanager": "Task Manager",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Theme Demo",
    "pangolin.app_welcome": "Welcome",
    "pangolin.app_help": "Help",
    "pangolin.app_web": "Web Browser",
    "pangolin.app_developeroptions": "Developer Options",
    "pangolin.featurenotimplemented_title": "Feature not implemented",
    "pangolin.featurenotimplemented_value": "This feature is currently not available on your build of Pangolin, please see https://reddit.com/r/dahliaos to check for updates.",
    "pangolin.launcher_card_information_title": "Information",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Drivers for Integrated GPU updated",
    "pangolin.launcher_card_music_title": "Music - Now playing",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Security",
    "pangolin.launcher_card_security_value": "Filesystem lock is ON",
    "pangolin.launcher_card_system_title": "System",
    "pangolin.launcher_card_system_value": "Welcome to dahliaOS!",
    "pangolin.launcher_search": "Search your device, apps, web...",
    "pangolin.qs_airplanemode": "Airplane mode",
    "pangolin.qs_autorotate": "Auto rotate",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "British English",
    "pangolin.qs_dnd": "Do not disturb",
    "pangolin.qs_flashlight": "Flashlight",
    "pangolin.qs_invertcolors": "Invert colours",
    "pangolin.qs_theme": "Theme",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "It's cold outside, grab a coat!",
  };
}


class _$LocaleEnUS extends _$LocaleBase {
  @override
  String get locale => "en-US";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Authenticator",
    "pangolin.app_calculator": "Calculator",
    "pangolin.app_clock": "Clock",
    "pangolin.app_disks": "Disks",
    "pangolin.app_files": "Files",
    "pangolin.app_media": "Media",
    "pangolin.app_music": "Music",
    "pangolin.app_notes": "Text Editor",
    "pangolin.app_notesmobile": "Notes (Mobile)",
    "pangolin.app_messages": "Messages",
    "pangolin.app_rootterminal": "Root Terminal",
    "pangolin.app_settings": "Settings",
    "pangolin.app_systemlogs": "System Logs",
    "pangolin.app_taskmanager": "Task Manager",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Theme Demo",
    "pangolin.app_welcome": "Welcome",
    "pangolin.app_help": "Help",
    "pangolin.app_web": "Web Browser",
    "pangolin.app_developeroptions": "Developer Options",
    "pangolin.featurenotimplemented_title": "Feature not implemented",
    "pangolin.featurenotimplemented_value": "This feature is currently not available on your build of Pangolin, please see https://reddit.com/r/dahliaos to check for updates.",
    "pangolin.launcher_card_information_title": "Information",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Drivers for Integrated GPU updated",
    "pangolin.launcher_card_music_title": "Music - Now playing",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Security",
    "pangolin.launcher_card_security_value": "Filesystem lock is ON",
    "pangolin.launcher_card_system_title": "System",
    "pangolin.launcher_card_system_value": "Welcome to dahliaOS!",
    "pangolin.launcher_search": "Search your device, apps, web...",
    "pangolin.qs_airplanemode": "Airplane mode",
    "pangolin.qs_autorotate": "Auto rotate",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "English",
    "pangolin.qs_dnd": "Do not disturb",
    "pangolin.qs_flashlight": "Flashlight",
    "pangolin.qs_invertcolors": "Invert colors",
    "pangolin.qs_theme": "Theme",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "It's cold outside, grab a coat!",
  };
}


class _$LocaleFrFR extends _$LocaleBase {
  @override
  String get locale => "fr-FR";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Authentificateur",
    "pangolin.app_calculator": "Calculatrice",
    "pangolin.app_clock": "Horloge",
    "pangolin.app_disks": "Disques",
    "pangolin.app_files": "Fichiers",
    "pangolin.app_media": "Médias",
    "pangolin.app_music": "Musique",
    "pangolin.app_notes": "Éditeur de Texte",
    "pangolin.app_notesmobile": "Notes (Mobile)",
    "pangolin.app_messages": "Messages",
    "pangolin.app_rootterminal": "Terminal super-utilisateur",
    "pangolin.app_settings": "Paramètres",
    "pangolin.app_systemlogs": "Journaux système",
    "pangolin.app_taskmanager": "Gestionnaire de tâches",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Démo de thème",
    "pangolin.app_welcome": "Bienvenue",
    "pangolin.app_help": "Aide système",
    "pangolin.app_web": "Navigateur Web",
    "pangolin.app_developeroptions": "Options développeurs",
    "pangolin.featurenotimplemented_title": "Fonctionnalité non implémentée",
    "pangolin.featurenotimplemented_value": "Cette fonctionnalité n'est actuellement pas disponible sur votre version de Pangolin. S'il vous plaît, consultez https://reddit.com/r/dahliaos pour vérifier si des mises à jour sont disponibles.",
    "pangolin.launcher_card_information_title": "Information",
    "pangolin.launcher_card_kernel_title": "Noyau",
    "pangolin.launcher_card_kernel_value": "Pilotes pour le GPU intégré mis à jour",
    "pangolin.launcher_card_music_title": "Musique - En cours de lecture",
    "pangolin.launcher_card_music_value": "PNL - Onizuka",
    "pangolin.launcher_card_security_title": "Sécurité",
    "pangolin.launcher_card_security_value": "Verrouillage de système de fichiers est ON",
    "pangolin.launcher_card_system_title": "Système",
    "pangolin.launcher_card_system_value": "Bienvenue sur dahliaOS !",
    "pangolin.launcher_search": "Recherchez dans votre appareil, des applications, le web...",
    "pangolin.qs_airplanemode": "Mode Avion",
    "pangolin.qs_autorotate": "Rotation automatique",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Français",
    "pangolin.qs_dnd": "Ne pas déranger",
    "pangolin.qs_flashlight": "Lampe torche",
    "pangolin.qs_invertcolors": "Inverser les couleurs",
    "pangolin.qs_theme": "Thème",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Il fait froid dehors, prends un manteau !",
  };
}


class _$LocaleHrHR extends _$LocaleBase {
  @override
  String get locale => "hr-HR";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Autentifikator",
    "pangolin.app_calculator": "Kalkulator",
    "pangolin.app_clock": "Sat",
    "pangolin.app_disks": "Disk",
    "pangolin.app_files": "Datoteke",
    "pangolin.app_media": "Mediji",
    "pangolin.app_music": "Glazba",
    "pangolin.app_notes": "Uređivač teksta",
    "pangolin.app_notesmobile": "Bilješke (Mobilno)",
    "pangolin.app_messages": "Poruke",
    "pangolin.app_rootterminal": "Root Terminal",
    "pangolin.app_settings": "Postavke",
    "pangolin.app_systemlogs": "Zapisnici sustava",
    "pangolin.app_taskmanager": "Upravitelj zadataka",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Teme demo",
    "pangolin.app_welcome": "Dobrodošli",
    "pangolin.app_help": "Pomoć",
    "pangolin.app_web": "Web preglednik",
    "pangolin.app_developeroptions": "Razvojne opcije",
    "pangolin.featurenotimplemented_title": "Značajka nije implementirana",
    "pangolin.featurenotimplemented_value": "Ova značajka trenutno nije dostupna u vašoj verziji Pangolina. Molimo posjetite https://reddit.com/r/dahliaos kako biste provjerili ima li novijih ažuriranja.",
    "pangolin.launcher_card_information_title": "Informacije",
    "pangolin.launcher_card_kernel_title": "Jezgra",
    "pangolin.launcher_card_kernel_value": "Upravljački programi za integrirane grafičke kartice su ažurirani",
    "pangolin.launcher_card_music_title": "Glazba - Sada svira",
    "pangolin.launcher_card_music_value": "Dada - Prodavnica snova",
    "pangolin.launcher_card_security_title": "Sigurnost",
    "pangolin.launcher_card_security_value": "Zaključavanje sustava datoteka je uključeno",
    "pangolin.launcher_card_system_title": "Sustav",
    "pangolin.launcher_card_system_value": "Dobrodošli na dahliuOS!",
    "pangolin.launcher_search": "Pretražite svoj uređaj, aplikacije, web...",
    "pangolin.qs_airplanemode": "Zrakoplovni način",
    "pangolin.qs_autorotate": "Automatsko rotiranje",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Hrvatski",
    "pangolin.qs_dnd": "Ne ometajte",
    "pangolin.qs_flashlight": "Svjetiljka",
    "pangolin.qs_invertcolors": "Invertirane boje",
    "pangolin.qs_theme": "Tema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Hladno je vani, uzmi kaput!",
  };
}


class _$LocaleIdID extends _$LocaleBase {
  @override
  String get locale => "id-ID";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Otentikator",
    "pangolin.app_calculator": "Kalkulator",
    "pangolin.app_clock": "Jam",
    "pangolin.app_disks": "Penyimpanan",
    "pangolin.app_files": "Berkas",
    "pangolin.app_media": "Media",
    "pangolin.app_music": "Musik",
    "pangolin.app_notes": "Editor teks",
    "pangolin.app_notesmobile": "Catatan (mobile)",
    "pangolin.app_messages": "Pesan",
    "pangolin.app_rootterminal": "Root terminal",
    "pangolin.app_settings": "Pengaturan",
    "pangolin.app_systemlogs": "Log sistem",
    "pangolin.app_taskmanager": "Task Manager",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Demo Tema",
    "pangolin.app_welcome": "Selamat Datang",
    "pangolin.app_help": "Bantuan",
    "pangolin.app_web": "Browser",
    "pangolin.app_developeroptions": "Opsi pengembang",
    "pangolin.featurenotimplemented_title": "Fitur belum di implementasikan",
    "pangolin.featurenotimplemented_value": "Fitur ini saat ini belum tersedia di build Pangolin Kamu. Silahkan periksa https://reddit.com/r/dahliaos untuk perkembangan lebih lanjut.",
    "pangolin.launcher_card_information_title": "Informasi",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Driver untuk GPU Terintegrasi diperbarui",
    "pangolin.launcher_card_music_title": "Musik - Sekarang diputar",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Keamanan",
    "pangolin.launcher_card_security_value": "Kunci sistem file AKTIF",
    "pangolin.launcher_card_system_title": "Sistem",
    "pangolin.launcher_card_system_value": "Selamat datang di dahliaOS!",
    "pangolin.launcher_search": "Cari perangkat Anda, aplikasi, web...",
    "pangolin.qs_airplanemode": "Mode pesawat",
    "pangolin.qs_autorotate": "Rotasi otomatis",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "bahasa Indonesia",
    "pangolin.qs_dnd": "Jangan ganggu",
    "pangolin.qs_flashlight": "Senter",
    "pangolin.qs_invertcolors": "Balikkan warna",
    "pangolin.qs_theme": "Tema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Di luar dingin, ambil mantel!",
  };
}


class _$LocaleJaJP extends _$LocaleBase {
  @override
  String get locale => "ja-JP";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "認証",
    "pangolin.app_calculator": "電卓",
    "pangolin.app_clock": "時計",
    "pangolin.app_disks": "ディスク",
    "pangolin.app_files": "ファイル",
    "pangolin.app_media": "メディア",
    "pangolin.app_music": "音楽",
    "pangolin.app_notes": "テキストエディタ",
    "pangolin.app_notesmobile": "メモ(モバイル版)",
    "pangolin.app_messages": "メッセージ",
    "pangolin.app_rootterminal": "ルートターミナル",
    "pangolin.app_settings": "設定",
    "pangolin.app_systemlogs": "システムログ",
    "pangolin.app_taskmanager": "タスクマネージャ",
    "pangolin.app_terminal": "ターミナル",
    "pangolin.app_themedemo": "テーマのデモ",
    "pangolin.app_welcome": "ようこそ",
    "pangolin.app_help": "ヘルプ",
    "pangolin.app_web": "ウェブブラウザ",
    "pangolin.app_developeroptions": "開発者向けオプション",
    "pangolin.featurenotimplemented_title": "この機能は実装されていません",
    "pangolin.featurenotimplemented_value": "この機能は現在Pangolinのビルドでは利用できません。アップデートを確認するには、https://reddit.com/r/dahliaosをご覧ください。",
    "pangolin.launcher_card_information_title": "詳細",
    "pangolin.launcher_card_kernel_title": "カーネル",
    "pangolin.launcher_card_kernel_value": "統合GPUドライバが更新されました",
    "pangolin.launcher_card_music_title": "音楽 - 再生中",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "セキュリティ",
    "pangolin.launcher_card_security_value": "ファイルシステム保護はオンです",
    "pangolin.launcher_card_system_title": "システム",
    "pangolin.launcher_card_system_value": "dahliaOSへようこそ！",
    "pangolin.launcher_search": "デバイス、アプリ、ウェブを検索...",
    "pangolin.qs_airplanemode": "機内モード",
    "pangolin.qs_autorotate": "自動回転",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "にほんご",
    "pangolin.qs_dnd": "マナーモード",
    "pangolin.qs_flashlight": "ライト",
    "pangolin.qs_invertcolors": "色を反転",
    "pangolin.qs_theme": "テーマ",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "外は寒いので、コートを着ましょう。",
  };
}


class _$LocaleNlNL extends _$LocaleBase {
  @override
  String get locale => "nl-NL";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Authenticator",
    "pangolin.app_calculator": "Rekenmachine",
    "pangolin.app_clock": "Klok",
    "pangolin.app_disks": "Schijf",
    "pangolin.app_files": "Bestanden",
    "pangolin.app_media": "Media",
    "pangolin.app_music": "Muziek",
    "pangolin.app_notes": "Teksteditor",
    "pangolin.app_notesmobile": "Notities (Mobiel)",
    "pangolin.app_messages": "Berichten",
    "pangolin.app_rootterminal": "Root Terminal",
    "pangolin.app_settings": "Instellingen",
    "pangolin.app_systemlogs": "Systeemlogboeken",
    "pangolin.app_taskmanager": "Taakbeheer",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Thema Demo",
    "pangolin.app_welcome": "Welkom",
    "pangolin.app_help": "Helpen",
    "pangolin.app_web": "Web Browser",
    "pangolin.app_developeroptions": "Ontwikkelaarsopties",
    "pangolin.featurenotimplemented_title": "Functie niet geïmplementeerd",
    "pangolin.featurenotimplemented_value": "Deze Functie is nu niet geïmplementeerd op je build van Pangolin. ga naar https://reddit.com/r/dahliaos voor updates.",
    "pangolin.launcher_card_information_title": "Informatie",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Drivers Voor Geïntegreerd GPU Bijgewerkt",
    "pangolin.launcher_card_music_title": "Muziek - Nu Aan Het Spelen",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Veiligheid",
    "pangolin.launcher_card_security_value": "Bestandssysteem Is Versleuteld",
    "pangolin.launcher_card_system_title": "Systeem",
    "pangolin.launcher_card_system_value": "Welkom Bij dahliaOS!",
    "pangolin.launcher_search": "Zoek je apparaat, apps, internet...",
    "pangolin.qs_airplanemode": "Vliegtuig modus",
    "pangolin.qs_autorotate": "Automatisch draaien",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Nederlands",
    "pangolin.qs_dnd": "Niet storen",
    "pangolin.qs_flashlight": "Zaklamp",
    "pangolin.qs_invertcolors": "Kleuren omkeren",
    "pangolin.qs_theme": "Thema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Het is buiten koud, pak een jas!",
  };
}


class _$LocalePtBR extends _$LocaleBase {
  @override
  String get locale => "pt-BR";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Autenticador",
    "pangolin.app_calculator": "Calculadora",
    "pangolin.app_clock": "Relógio",
    "pangolin.app_disks": "Discos",
    "pangolin.app_files": "Arquivos",
    "pangolin.app_media": "Mídia",
    "pangolin.app_music": "Musica",
    "pangolin.app_notes": "Editor de texto",
    "pangolin.app_notesmobile": "Notas (Móvel)",
    "pangolin.app_messages": "Mensagens",
    "pangolin.app_rootterminal": "Terminal root",
    "pangolin.app_settings": "Configurações",
    "pangolin.app_systemlogs": "Registos do sistema",
    "pangolin.app_taskmanager": "Gestor de Tarefas",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Tema Demo",
    "pangolin.app_welcome": "Bem-vindo",
    "pangolin.app_help": "Ajuda",
    "pangolin.app_web": "Navegador de Internet",
    "pangolin.app_developeroptions": "Opções de programador",
    "pangolin.featurenotimplemented_title": "Recurso não implementado",
    "pangolin.featurenotimplemented_value": "Este recurso não está disponível na sua versão do Pangolin. favor consulte https://reddit.com/r/dahliaos para verificar se há atualizações.",
    "pangolin.launcher_card_information_title": "Informação",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Drivers para GPU integrado atualizados",
    "pangolin.launcher_card_music_title": "Música - Reproduzindo",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Segurança",
    "pangolin.launcher_card_security_value": "O bloqueio do sistema de arquivos está ATIVADO",
    "pangolin.launcher_card_system_title": "Sistema",
    "pangolin.launcher_card_system_value": "Bem-vindo ao dahliaOS!",
    "pangolin.launcher_search": "Busque por seu dispositivo, aplicativos, web...",
    "pangolin.qs_airplanemode": "Modo avião",
    "pangolin.qs_autorotate": "Rotação automática",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Português brasileiro",
    "pangolin.qs_dnd": "Não perturbe",
    "pangolin.qs_flashlight": "Lanterna",
    "pangolin.qs_invertcolors": "Cores invertidas",
    "pangolin.qs_theme": "Tema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Está frio lá fora, pegue um casaco!",
  };
}


class _$LocalePtPT extends _$LocaleBase {
  @override
  String get locale => "pt-PT";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Autenticador",
    "pangolin.app_calculator": "Calculadora",
    "pangolin.app_clock": "Relógio",
    "pangolin.app_disks": "Discos",
    "pangolin.app_files": "Ficheiros",
    "pangolin.app_media": "Média",
    "pangolin.app_music": "Música",
    "pangolin.app_notes": "Editor de texto",
    "pangolin.app_notesmobile": "Notas (Móvel)",
    "pangolin.app_messages": "Mensagens",
    "pangolin.app_rootterminal": "Terminal root",
    "pangolin.app_settings": "Definições",
    "pangolin.app_systemlogs": "Registos do sistema",
    "pangolin.app_taskmanager": "Gestor de Tarefas",
    "pangolin.app_terminal": "Terminal",
    "pangolin.app_themedemo": "Tema Demo",
    "pangolin.app_welcome": "Bem-vindo",
    "pangolin.app_help": "Ajuda",
    "pangolin.app_web": "Navegador de Internet",
    "pangolin.app_developeroptions": "Opções de programador",
    "pangolin.featurenotimplemented_title": "Funcionalidade não implementada",
    "pangolin.featurenotimplemented_value": "Esta funcionalidade não está disponível na sua versão do Pangolin. Por favor consulte o https://reddit.com/r/dahliaos para verificar se existem atualizações.",
    "pangolin.launcher_card_information_title": "Informação",
    "pangolin.launcher_card_kernel_title": "Kernel",
    "pangolin.launcher_card_kernel_value": "Drivers para GPU integrado atualizados",
    "pangolin.launcher_card_music_title": "Música - A reproduzir",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Segurança",
    "pangolin.launcher_card_security_value": "O bloqueio do sistema de ficheiros está ATIVADO",
    "pangolin.launcher_card_system_title": "Sistema",
    "pangolin.launcher_card_system_value": "Bem-vindo ao dahliaOS!",
    "pangolin.launcher_search": "Procure o seu dispositivo, aplicações, web...",
    "pangolin.qs_airplanemode": "Modo de avião",
    "pangolin.qs_autorotate": "Rotação automática",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Português",
    "pangolin.qs_dnd": "Não incomodar",
    "pangolin.qs_flashlight": "Lanterna",
    "pangolin.qs_invertcolors": "Cores invertidas",
    "pangolin.qs_theme": "Tema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Está frio lá fora, pegue um casaco!",
  };
}


class _$LocaleTrTR extends _$LocaleBase {
  @override
  String get locale => "tr-TR";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "Kimlik Doğrulayıcı",
    "pangolin.app_calculator": "Hesap Makinesi",
    "pangolin.app_clock": "Saat",
    "pangolin.app_disks": "Diskler",
    "pangolin.app_files": "Dosyalar",
    "pangolin.app_media": "Ortam",
    "pangolin.app_music": "Müzik",
    "pangolin.app_notes": "Metin Düzenleyici",
    "pangolin.app_notesmobile": "Notlar (Taşınabilir)",
    "pangolin.app_messages": "İletiler",
    "pangolin.app_rootterminal": "Kök Uçbirim",
    "pangolin.app_settings": "Ayarlar",
    "pangolin.app_systemlogs": "Sistem Günlükleri",
    "pangolin.app_taskmanager": "Görev Yöneticisi",
    "pangolin.app_terminal": "Uçbirim",
    "pangolin.app_themedemo": "Tema Demosu",
    "pangolin.app_welcome": "Hoş geldiniz",
    "pangolin.app_help": "Yardım",
    "pangolin.app_web": "Web Tarayıcısı",
    "pangolin.app_developeroptions": "Geliştirici Seçenekleri",
    "pangolin.featurenotimplemented_title": "Özellik henüz mevcut değil",
    "pangolin.featurenotimplemented_value": "Bu özellik şu anda kullandığınız yapıda mevcut değil, gelişmeler için lütfen https://reddit.com/r/dahliaos adresine bakın.",
    "pangolin.launcher_card_information_title": "Bilgi",
    "pangolin.launcher_card_kernel_title": "Çekirdek",
    "pangolin.launcher_card_kernel_value": "Dahili GPU sürücüleri güncellendi",
    "pangolin.launcher_card_music_title": "Müzik - Şimdi oynatılıyor",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "Güvenlik",
    "pangolin.launcher_card_security_value": "Dosya sistemi kilidi AÇIK",
    "pangolin.launcher_card_system_title": "Sistem",
    "pangolin.launcher_card_system_value": "dahliaOS'e hoş geldiniz!",
    "pangolin.launcher_search": "Aygıtınızda, uygulamalarınızda, web'de arama yapın...",
    "pangolin.qs_airplanemode": "Uçak kipi",
    "pangolin.qs_autorotate": "Kendiliğinden döndür",
    "pangolin.qs_bluetooth": "Bluetooth",
    "pangolin.qs_changelanguage": "Türk",
    "pangolin.qs_dnd": "Rahatsız etmeyin",
    "pangolin.qs_flashlight": "Fener",
    "pangolin.qs_invertcolors": "Renkleri ters çevir",
    "pangolin.qs_theme": "Tema",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "Dışarısı soğuk, üzerine bir mont al!",
  };
}


class _$LocaleZhTW extends _$LocaleBase {
  @override
  String get locale => "zh-TW";

  @override
  Map<String, String> get data => {
    "pangolin.app_authenticator": "認證者",
    "pangolin.app_calculator": "計算機",
    "pangolin.app_clock": "時鐘",
    "pangolin.app_disks": "磁碟",
    "pangolin.app_files": "檔案",
    "pangolin.app_media": "媒體",
    "pangolin.app_music": "音樂",
    "pangolin.app_notes": "文字編輯器",
    "pangolin.app_notesmobile": "筆記（手機版）",
    "pangolin.app_messages": "訊息",
    "pangolin.app_rootterminal": "終端機（Root權限）",
    "pangolin.app_settings": "設置",
    "pangolin.app_systemlogs": "系統日誌",
    "pangolin.app_taskmanager": "工作管理員",
    "pangolin.app_terminal": "終端機",
    "pangolin.app_themedemo": "佈景主題Demo",
    "pangolin.app_welcome": "歡迎",
    "pangolin.app_help": "救命",
    "pangolin.app_web": "網頁瀏覽器",
    "pangolin.app_developeroptions": "開發人員選項",
    "pangolin.featurenotimplemented_title": "功能尚未實作",
    "pangolin.featurenotimplemented_value": "此功能在您目前的Pangolin版本無法使用，請至https://reddit.com/r/dahliaos查看更新。",
    "pangolin.launcher_card_information_title": "信息",
    "pangolin.launcher_card_kernel_title": "核心",
    "pangolin.launcher_card_kernel_value": "內建顯示卡的驅動程式已更新",
    "pangolin.launcher_card_music_title": "音樂－播放中",
    "pangolin.launcher_card_music_value": "Vance Joy - Georgia",
    "pangolin.launcher_card_security_title": "安全",
    "pangolin.launcher_card_security_value": "檔案系統鎖目前為：開啟",
    "pangolin.launcher_card_system_title": "系統",
    "pangolin.launcher_card_system_value": "歡迎來到dahliaOS！",
    "pangolin.launcher_search": "搜尋您的裝置、應用程式、網頁⋯",
    "pangolin.qs_airplanemode": "飛航模式",
    "pangolin.qs_autorotate": "自動旋轉",
    "pangolin.qs_bluetooth": "藍芽",
    "pangolin.qs_changelanguage": "繁體中文",
    "pangolin.qs_dnd": "勿擾模式",
    "pangolin.qs_flashlight": "手電筒",
    "pangolin.qs_invertcolors": "反相顏色",
    "pangolin.qs_theme": "佈景主題",
    "pangolin.qs_wifi": "Wi-Fi",
    "pangolin.app_containers": "Graft",
    "pangolin.launcher_card_information_value": "外面很冷，記得穿外套！",
  };
}

