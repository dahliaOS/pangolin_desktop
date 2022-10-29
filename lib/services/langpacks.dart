import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:intl/locale.dart';
import 'package:pangolin/services/service.dart';
import 'package:path/path.dart' as p;

abstract class LangPacksService extends Service<LangPacksService> {
  LangPacksService();

  factory LangPacksService.fallback() = _StraightThroughLangPacksService;

  static LangPacksService get current {
    return ServiceManager.getService<LangPacksService>()!;
  }

  static LangPacksService build() {
    if (!Platform.isLinux) return _StraightThroughLangPacksService();

    return _LinuxLangPacksService();
  }

  FutureOr<void> warmup(String domain);
  FutureOr<String> lookup(String domain, String key, [Locale? locale]);
  String cacheLookup(String domain, String key, [Locale? locale]);
}

class _LinuxLangPacksService extends LangPacksService {
  static const _MessageCatalogParser parser = _MessageCatalogParser();

  final List<_MessageBundle> bundles = [];
  final Map<String, _CachedMessageBundle> cache = {};

  @override
  Future<String> lookup(String domain, String key, [Locale? locale]) async {
    if (!cache.containsKey(domain)) {
      await warmup(domain);
    }

    return cacheLookup(domain, key, locale);
  }

  @override
  Future<void> warmup(String domain) async {
    final filteredBundles =
        bundles.where((e) => e.domains.contains(domain)).toList();

    final catalogs = <Locale, _MessageCatalog>{};

    for (final bundle in filteredBundles) {
      final domainFile =
          File(p.join(bundle.directory.path, 'LC_MESSAGES', '$domain.mo'));
      final bytes = await domainFile.readAsBytes();

      final catalog = parser.parse(bytes);

      if (catalog == null) continue;

      catalogs[bundle.locale] = catalog;
    }

    cache[domain] = _CachedMessageBundle(catalogs);
  }

  @override
  String cacheLookup(String domain, String key, [Locale? locale]) {
    final cacheBundle = cache[domain];

    if (cacheBundle == null) return key;

    locale ??= Locale.parse('en_US');

    final compatibleLocaleKey =
        cacheBundle.catalogs.keys.firstWhereOrNull(
      (e) => e.isCompatibleWith(locale!),
    );

    if (compatibleLocaleKey == null) return key;

    final catalog = cacheBundle.catalogs[compatibleLocaleKey];

    if (catalog == null) return key;

    return catalog[key] ?? key;
  }

  @override
  Future<void> start() async {
    await _populateFor('/usr/share/locale-langpack');
  }

  Future<void> _populateFor(String path) async {
    final entities =
        await Directory(path).list().toList();

    for (final entity in entities) {
      if (entity is! Directory) continue;

      final localeStr = p.basenameWithoutExtension(entity.path);
      final locale = Locale.tryParse(localeStr);

      if (locale == null) continue;

      final children =
          await Directory(p.join(entity.path, 'LC_MESSAGES')).list().toList();
      final domains =
          children.map((e) => p.basenameWithoutExtension(e.path)).toList();

      bundles.add(_MessageBundle(locale, entity, domains));
    }
  }

  @override
  FutureOr<void> stop() {
    cache.clear();
    bundles.clear();
  }
}

class _StraightThroughLangPacksService extends LangPacksService {
  @override
  String lookup(String domain, String key, [Locale? locale]) {
    return key;
  }

  @override
  String cacheLookup(String domain, String key, [Locale? locale]) {
    return key;
  }

  @override
  FutureOr<void> warmup(String domain) {
    // noop
  }

  @override
  FutureOr<void> start() {
    // noop
  }

  @override
  FutureOr<void> stop() {
    // noop
  }
}

class _MessageBundle {

  const _MessageBundle(this.locale, this.directory, this.domains);
  final Locale locale;
  final Directory directory;
  final List<String> domains;
}

class _CachedMessageBundle {

  const _CachedMessageBundle(this.catalogs);
  final Map<Locale, _MessageCatalog> catalogs;
}

// https://www.gnu.org/software/gettext/manual/gettext.html#MO-Files
// This was NOT easy to find, keeping it here for any lost soul that is trying
// to parse a .mo file, good luck
class _MessageCatalogParser {
  const _MessageCatalogParser();

  _MessageCatalog? parse(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    final Endian endian;

    switch (data.getUint32(0)) {
      case 0x950412de:
        endian = Endian.big;
        break;
      case 0xde120495:
        endian = Endian.little;
        break;
      default:
        return null;
    }

    final nstrings = data.getUint32(8, endian);
    final stringTableOffset = data.getUint32(12, endian);
    final translationsTableOffset = data.getUint32(16, endian);

    final translations = <_MsgId, _MsgStr>{};

    for (var i = 0; i < nstrings; i++) {
      final strLen = data.getUint32(stringTableOffset + i * 8, endian);
      final strOffset =
          data.getUint32(stringTableOffset + i * 8 + 4, endian);
      final trnLen =
          data.getUint32(translationsTableOffset + i * 8, endian);
      final trnOffset =
          data.getUint32(translationsTableOffset + i * 8 + 4, endian);

      var strCurrOffset = 0;
      final origStrings = <List<int>>[];
      for (var i = 0; i < strLen; i++) {
        if (strCurrOffset >= origStrings.length) {
          origStrings.add([]);
        }
        final char = data.getUint8(strOffset + i);

        if (char == 0) {
          strCurrOffset++;
          continue;
        }
        origStrings[strCurrOffset].add(char);
      }

      var trnCurrOffset = 0;
      final trnStrings = <List<int>>[];
      for (var i = 0; i < trnLen; i++) {
        if (trnCurrOffset >= trnStrings.length) {
          trnStrings.add([]);
        }
        final char = data.getUint8(trnOffset + i);

        if (char == 0) {
          trnCurrOffset++;
          continue;
        }
        trnStrings[trnCurrOffset].add(char);
      }

      if (origStrings.length != trnStrings.length) continue;

      final plurals = origStrings.length > 1
          ? origStrings.sublist(1).map((e) => e.toUtf8()).toList()
          : null;

      final msgId = _MsgId(origStrings[0].toUtf8(), plurals);
      final msgStr =
          _MsgStr(trnStrings.map((e) => e.toUtf8()).toList());

      translations[msgId] = msgStr;
    }

    return _MessageCatalog(translations);
  }
}

class _MessageCatalog {

  const _MessageCatalog(this.translations);
  final Map<_MsgId, _MsgStr> translations;

  String? operator [](String key) {
    String? result;

    translations.forEach((id, str) {
      if (key == id.id) {
        result = str[0];
        return;
      }

      if (id.plurals != null && id.plurals!.contains(key)) {
        final indexOf = id.plurals!.indexOf(key);

        result = str[indexOf + 1];
        return;
      }
    });

    return result;
  }
}

class _MsgId {

  const _MsgId(this.id, [this.plurals]);
  final String id;
  final List<String>? plurals;
}

class _MsgStr {

  const _MsgStr(this.strings);
  final List<String> strings;

  String operator [](int index) {
    return strings[index];
  }
}

extension _BufferToString on List<int> {
  String toUtf8() {
    return utf8.decode(this);
  }
}

extension _LocaleIsCompatible on Locale {
  bool isCompatibleWith(Locale other) {
    final everythingMatches = scriptCode == other.scriptCode &&
        countryCode == other.countryCode &&
        languageCode == other.languageCode;

    final countryAndLangMatches =
        countryCode == other.countryCode && languageCode == other.languageCode;

    final scriptAndLangMatches =
        scriptCode == other.scriptCode && languageCode == other.languageCode;

    final langMatches = languageCode == other.languageCode;

    return everythingMatches ||
        countryAndLangMatches ||
        scriptAndLangMatches ||
        langMatches;
  }
}
