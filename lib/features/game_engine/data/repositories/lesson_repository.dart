import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lesson_content.dart';

/// Provides static methods to load [LessonContent] from the assets/lessons/ folder.
///
/// This is the clean entry-point for injecting lessons into [GameEngineScreen].
class LessonRepository {
  LessonRepository._(); // static-only

  /// Loads the **English Unit 5 – Animals** lesson.
  static Future<LessonContent> loadEnglishUnit5() async {
    return _load('assets/lessons/english_unit5.json');
  }

  /// Loads the **Arabic Letter Alef** lesson.
  static Future<LessonContent> loadArabicAlef() async {
    return _load('assets/lessons/arabic_letter_alef.json');
  }

  /// Loads the **Math Addition** lesson.
  static Future<LessonContent> loadMathAddition() async {
    return _load('assets/lessons/math_addition.json');
  }

  /// Loads any lesson from an asset path.
  static Future<LessonContent> loadFromAsset(String assetPath) async {
    return _load(assetPath);
  }

  /// Parses a [LessonContent] directly from a JSON map — useful when lessons
  /// are fetched from a remote API.
  static LessonContent fromMap(Map<String, dynamic> json) {
    return LessonContent.fromJson(json);
  }

  // ─────────────────────────────────────────────
  //  Private
  // ─────────────────────────────────────────────

  static Future<LessonContent> _load(String path) async {
    final raw = await rootBundle.loadString(path);
    return LessonContent.fromJson(
        jsonDecode(raw) as Map<String, dynamic>);
  }
}
