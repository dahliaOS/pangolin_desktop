import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

class IconCache {

  IconCache._({
    required this.file,
    required this.directories,
    required this.data,
    this.isValid = false,
  });
  final File file;
  final List<String> directories;
  final Uint8List data;
  bool isValid;

  static Future<IconCache?> create(String dirName) async {
    final info = File(p.join(dirName, 'icon-theme.cache'));
    final infoStat = await info.stat();
    final dirStat = await Directory(dirName).stat();
    final infoLastMod = infoStat.modified;
    final dirLastMod = dirStat.modified;

    if (!await info.exists() || infoLastMod.isBefore(dirLastMod)) return null;

    final file = File(info.absolute.path);

    final data = await file.readAsBytes();

    if (_read16(data, 0) != 1) return null;

    final lastModified = await info.lastModified();
    final dirListOffset = _read32(data, 8);
    final dirListLen = _read32(data, dirListOffset);
    var isValid = true;

    final directories = <String>[];
    for (var i = 0; i < dirListLen; ++i) {
      final offset = _read32(data, dirListOffset + 4 + 4 * i);

      final dir =
          Directory(p.join(dirName, _readString(data, offset)));
      final dirStat = await dir.stat();
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
    final value = _read16(data, offset);

    if (value == -1) {
      isValid = false;
      return 0;
    }

    return value;
  }

  int read32(int offset) {
    final value = _read32(data, offset);

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
    var index = 0;
    int p() => key.codeUnitAt(index);
    var h = p();

    for (index += 1; index < key.length; index++) {
      h = (h << 5) - h + p();
    }

    return h.toUnsigned(32);
  }

  List<String>? lookup(String name) {
    final ret = <String>[];

    final hash = _iconNameHash(name);

    final hashOffset = read32(4);
    final hashBucketCount = read32(hashOffset);

    final bucketIndex = (hash % hashBucketCount).toUnsigned(32);
    var bucketOffset = read32(hashOffset + 4 + bucketIndex * 4);

    while (bucketOffset > 0 && bucketOffset <= data.length - 12) {
      final nameOff = read32(bucketOffset + 4);
      if (nameOff < data.length && _readString(data, nameOff) == name) {
        final dirListOffset = read32(8);
        final dirListLen = read32(dirListOffset);

        final listOffset = read32(bucketOffset + 8);
        final listLen = read32(listOffset);

        for (var j = 0; j < listLen; ++j) {
          final dirIndex = read16(listOffset + 4 + 8 * j);
          final o = read32(dirListOffset + 4 + dirIndex * 4);

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
