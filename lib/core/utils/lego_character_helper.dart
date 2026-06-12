import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LegoCharacterHelper {
  static final RegExp _base64RegExp = RegExp(
    r'xlink:href="data:image/png;base64,([^"]+)"',
  );

  static Uint8List? _handsBytes;

  static final Map<int, Uint8List> _headBytes = {};

  static final Map<int, Uint8List> _hairBytes = {};

  static final Map<int, Uint8List> _bodyBytes = {};

  static final Map<int, Uint8List> _legBytes = {};

  static final Map<int, Uint8List> _hatBytes = {};

  static Future<void> prefetch() async {
    if (_handsBytes == null) {
      final characterSvg = await rootBundle.loadString(
        'assets/images/Character.svg',
      );
      final matches = _base64RegExp
          .allMatches(characterSvg)
          .map((m) => m.group(1)!)
          .toList();
      if (matches.length >= 3) {
        _handsBytes = base64Decode(matches[2]);
      }
    }

    for (int i = 1; i <= 13; i++) {
      if (!_headBytes.containsKey(i)) {
        final headSvg = await rootBundle.loadString(
          'assets/images/character/head/Head$i.svg',
        );
        final match = _base64RegExp.firstMatch(headSvg);
        if (match != null) {
          _headBytes[i] = base64Decode(match.group(1)!);
        }
      }
    }

    for (int i = 1; i <= 7; i++) {
      if (!_hairBytes.containsKey(i)) {
        final hairSvg = await rootBundle.loadString(
          'assets/images/character/hair/Hair$i.svg',
        );
        final match = _base64RegExp.firstMatch(hairSvg);
        if (match != null) {
          _hairBytes[i] = base64Decode(match.group(1)!);
        }
      }
    }

    for (int i = 1; i <= 8; i++) {
      if (!_bodyBytes.containsKey(i)) {
        final bodySvg = await rootBundle.loadString(
          'assets/images/character/body/Body$i.svg',
        );
        final match = _base64RegExp.firstMatch(bodySvg);
        if (match != null) {
          _bodyBytes[i] = base64Decode(match.group(1)!);
        }
      }
    }

    for (int i = 1; i <= 9; i++) {
      if (!_legBytes.containsKey(i)) {
        final legSvg = await rootBundle.loadString(
          'assets/images/character/legs/Leg$i.svg',
        );
        final match = _base64RegExp.firstMatch(legSvg);
        if (match != null) {
          _legBytes[i] = base64Decode(match.group(1)!);
        }
      }
    }

    for (int i = 1; i <= 8; i++) {
      if (!_hatBytes.containsKey(i)) {
        final hatSvg = await rootBundle.loadString(
          'assets/images/character/hats/Hat$i.svg',
        );
        final match = _base64RegExp.firstMatch(hatSvg);
        if (match != null) {
          _hatBytes[i] = base64Decode(match.group(1)!);
        }
      }
    }
  }

  static Future<List<Uint8List>> getCharacterLayers({
    required int headIndex,
    required int hairIndex,
    required int bodyIndex,
    required int legIndex,
    required int hatIndex,
  }) async {
    await prefetch();
    final layers = <Uint8List>[];

    final legBytes = _legBytes[legIndex] ?? _legBytes[1]!;
    layers.add(legBytes);

    final bodyBytes = _bodyBytes[bodyIndex] ?? _bodyBytes[1]!;
    layers.add(bodyBytes);

    layers.add(_handsBytes ?? Uint8List(0));

    final headBytes = _headBytes[headIndex] ?? _headBytes[1]!;
    layers.add(headBytes);

    final hairBytes = _hairBytes[hairIndex] ?? _hairBytes[1]!;
    layers.add(hairBytes);

    if (hatIndex > 0) {
      final hatBytes = _hatBytes[hatIndex] ?? _hatBytes[1]!;
      layers.add(hatBytes);
    }

    return layers;
  }

  static Uint8List getHeadBytes(int index) =>
      _headBytes[index] ?? _headBytes[1]!;
  static Uint8List getHairBytes(int index) =>
      _hairBytes[index] ?? _hairBytes[1]!;
  static Uint8List getBodyBytes(int index) =>
      _bodyBytes[index] ?? _bodyBytes[1]!;
  static Uint8List getLegBytes(int index) => _legBytes[index] ?? _legBytes[1]!;
  static Uint8List getHatBytes(int index) => _hatBytes[index] ?? _hatBytes[1]!;

  static const String _keyHeadIndex = 'lego_head_index';
  static const String _keyHairIndex = 'lego_hair_index';
  static const String _keyBodyIndex = 'lego_body_index';
  static const String _keyLegIndex = 'lego_leg_index';
  static const String _keyHatIndex = 'lego_hat_index';

  static Future<Map<String, dynamic>> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'headIndex': prefs.getInt(_keyHeadIndex) ?? 1,
      'hairIndex': prefs.getInt(_keyHairIndex) ?? 1,
      'bodyIndex': prefs.getInt(_keyBodyIndex) ?? 1,
      'legIndex': prefs.getInt(_keyLegIndex) ?? 1,
      'hatIndex': prefs.getInt(_keyHatIndex) ?? 0,
    };
  }

  static Future<void> saveConfig({
    required int headIndex,
    required int hairIndex,
    required int bodyIndex,
    required int legIndex,
    required int hatIndex,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyHeadIndex, headIndex);
    await prefs.setInt(_keyHairIndex, hairIndex);
    await prefs.setInt(_keyBodyIndex, bodyIndex);
    await prefs.setInt(_keyLegIndex, legIndex);
    await prefs.setInt(_keyHatIndex, hatIndex);
  }
}
