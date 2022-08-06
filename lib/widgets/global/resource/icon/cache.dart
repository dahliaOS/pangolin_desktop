import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

class IconCache {
  final File file;
  final List<String> directories;
  final Uint8List data;
  bool isValid;

  IconCache._({
    required this.file,
    required this.directories,
    required this.data,
    this.isValid = false,
  });

  static Future<IconCache?> create(String dirName) async {
    final File info = File(p.join(dirName, "icon-theme.cache"));
    final FileStat infoStat = await info.stat();
    final FileStat dirStat = await Directory(dirName).stat();
    final DateTime infoLastMod = infoStat.modified;
    final DateTime dirLastMod = dirStat.modified;

    if (!await info.exists() || infoLastMod.isBefore(dirLastMod)) return null;

    final File file = File(info.absolute.path);

    final Uint8List data = await file.readAsBytes();

    if (_read16(data, 0) != 1) return null;

    final DateTime lastModified = await info.lastModified();
    final int dirListOffset = _read32(data, 8);
    final int dirListLen = _read32(data, dirListOffset);
    bool isValid = true;

    final List<String> directories = [];
    for (int i = 0; i < dirListLen; ++i) {
      final int offset = _read32(data, dirListOffset + 4 + 4 * i);

      final Directory dir =
          Directory(p.join(dirName, _readString(data, offset)));
      final FileStat dirStat = await dir.stat();
      if (!isValid ||
          offset > data.length ||
          lastModified.isBefore(dirStat.modified)) {
        isValid = false;
        break;
      }

      directories.add(_readString(data, offset));
    }

    return IconCache._(
      file: file,
      directories: directories,
      data: data,
      isValid: isValid,
    );
  }

  int read16(int offset) {
    final int value = _read16(data, offset);

    if (value == -1) {
      isValid = false;
      return 0;
    }

    return value;
  }

  int read32(int offset) {
    final int value = _read32(data, offset);

    if (value == -1) {
      isValid = false;
      return 0;
    }

    return value;
  }

  static int _read16(Uint8List data, int offset) {
    if (offset > data.length - 2 || (offset & 0x1) > 0) {
      return -1;
    }
    return (data[offset + 1] | data[offset] << 8).toUnsigned(16);
  }

  static int _read32(Uint8List data, int offset) {
    if (offset > data.length - 4 || (offset & 0x3) > 0) {
      return -1;
    }
    return (data[offset + 3] |
            data[offset + 2] << 8 |
            data[offset + 1] << 16 |
            data[offset] << 24)
        .toUnsigned(32);
  }

  static String _readString(Uint8List input, int offset) {
    return utf8.decode(
      input.sublist(
        offset,
        offset + input.sublist(offset).indexOf(0),
      ),
    );
  }

  int _iconNameHash(String key) {
    int index = 0;
    int p() => key.codeUnitAt(index);
    int h = p();

    for (index += 1; index < key.length; index++) {
      h = (h << 5) - h + p();
    }

    return h.toUnsigned(32);
  }

  List<String>? lookup(String name) {
    final List<String> ret = [];

    final int hash = _iconNameHash(name);

    final int hashOffset = read32(4);
    final int hashBucketCount = read32(hashOffset);

    final int bucketIndex = (hash % hashBucketCount).toUnsigned(32);
    int bucketOffset = read32(hashOffset + 4 + bucketIndex * 4);

    while (bucketOffset > 0 && bucketOffset <= data.length - 12) {
      final int nameOff = read32(bucketOffset + 4);
      if (nameOff < data.length && _readString(data, nameOff) == name) {
        final int dirListOffset = read32(8);
        final int dirListLen = read32(dirListOffset);

        final int listOffset = read32(bucketOffset + 8);
        final int listLen = read32(listOffset);

        for (int j = 0; j < listLen; ++j) {
          final int dirIndex = read16(listOffset + 4 + 8 * j);
          final int o = read32(dirListOffset + 4 + dirIndex * 4);

          if (!isValid || dirIndex >= dirListLen || o > data.length) {
            isValid = false;
            return ret;
          }

          ret.add(_readString(data, o));
        }
        return ret;
      }
      bucketOffset = read32(bucketOffset);
    }

    return null;
  }
}
