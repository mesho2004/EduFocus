import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lesson_content.dart';

class LessonRepository {
  LessonRepository._();

  static Future<LessonContent> loadEnglishUnit5() async {
    return _load('assets/lessons/english_unit5.json');
  }

  static Future<LessonContent> loadArabicAlef() async {
    return _load('assets/lessons/arabic_letter_alef.json');
  }

  static Future<LessonContent> loadMathAddition() async {
    return _load('assets/lessons/math_addition.json');
  }

  static Future<LessonContent> loadFromAsset(String assetPath) async {
    return _load(assetPath);
  }

  static LessonContent fromMap(Map<String, dynamic> json) {
    return LessonContent.fromJson(json);
  }

  static Future<LessonContent> _load(String path) async {
    final raw = await rootBundle.loadString(path);
    return LessonContent.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
