import 'dart:convert';
import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:flutter/services.dart';
import '../models/lesson_content.dart';

class CurriculumUnit {
  final int unitIndex;
  final String title;
  final GameTheme theme;
  final List<LessonContent> lessons;

  CurriculumUnit({
    required this.unitIndex,
    required this.title,
    required this.theme,
    required this.lessons,
  });
}

class CurriculumService {
  /// Retrieves a specific lesson content dynamically.
  Future<LessonContent?> getLessonContent(SubjectId subjectId, int unitIndex, int lessonIndex) async {
    final unitsList = await loadCurriculum(subjectId);
    if (unitIndex >= 0 && unitIndex < unitsList.length) {
      final unit = unitsList[unitIndex];
      if (lessonIndex >= 0 && lessonIndex < unit.lessons.length) {
        return unit.lessons[lessonIndex];
      }
    }
    return null;
  }

  /// Loads the curriculum from a local JSON file.
  Future<List<CurriculumUnit>> loadCurriculum(SubjectId subjectId) async {
    try {
      String jsonAsset;
      switch (subjectId) {
        case SubjectId.arabic:
          jsonAsset = 'assets/lessons/arabic_curriculum.json';
          break;
        case SubjectId.mathEn:
          jsonAsset = 'assets/lessons/math_en_curriculum.json';
          break;
        case SubjectId.english:
        jsonAsset = 'assets/lessons/english_curriculum.json';
          break;
      }

      final jsonString = await rootBundle.loadString(jsonAsset);
      final Map<String, dynamic> data = jsonDecode(jsonString);

      final subjectTypeRaw = data['subjectType'] as String? ?? 'English';
      final subjectType = _parseSubject(subjectTypeRaw);

      final curriculumRaw = (data['units'] ?? data['curriculum']) as List<dynamic>? ?? [];
      final List<CurriculumUnit> unitsList = [];

      for (var unitData in curriculumRaw) {
        final unitIndex = unitData['unit'] as int? ?? 1;
        final title = unitData['title'] as String? ?? 'Unit $unitIndex';
        final themeRaw = unitData['theme'] as String? ?? '';
        final theme = _parseTheme(themeRaw);

        final lessonsRaw = unitData['lessons'] as List<dynamic>? ?? [];
        final List<LessonContent> parsedLessons = [];

        for (var lessonData in lessonsRaw) {
          final gameTemplateRaw = lessonData['gameTemplate'] as String? ?? 'Selector';
          final topic = lessonData['topic'] as String? ?? 'Lesson';

          final questionObj = GameQuestion(
            question: lessonData['question'] as String? ?? '',
            questionIsImage: false,
            options: (lessonData['options'] as List<dynamic>? ?? [])
                .map((o) => GameOptionData.fromJson(o as Map<String, dynamic>))
                .toList(),
            pairs: (lessonData['pairs'] as List<dynamic>? ?? [])
                .map((p) => MatchPair.fromJson(p as Map<String, dynamic>))
                .toList(),
          );

          parsedLessons.add(LessonContent(
            lessonTitle: '$title - $topic',
            subjectType: subjectType,
            gameTemplate: _parseTemplate(gameTemplateRaw),
            theme: theme,
            questions: [questionObj],
          ));
        }

        unitsList.add(CurriculumUnit(
          unitIndex: unitIndex,
          title: title,
          theme: theme,
          lessons: parsedLessons,
        ));
      }

      return unitsList;
    } catch (e) {
      print('Error loading curriculum: $e');
      return [];
    }
  }

  static SubjectType _parseSubject(String raw) {
    switch (raw.toLowerCase()) {
      case 'arabic':
        return SubjectType.arabic;
      case 'math':
        return SubjectType.math;
      default:
        return SubjectType.english;
    }
  }

  static GameTheme _parseTheme(String raw) {
    switch (raw.toLowerCase()) {
      case 'jungle':
        return GameTheme.jungle;
      case 'space':
        return GameTheme.space;
      default:
        return GameTheme.beach;
    }
  }

  static GameTemplate _parseTemplate(String raw) {
    switch (raw.toLowerCase()) {
      case 'sorter':
        return GameTemplate.sorter;
      case 'sequence':
        return GameTemplate.sequence;
      case 'sequencer':
        return GameTemplate.sequencer;
      case 'matcher':
        return GameTemplate.matcher;
      case 'popper':
        return GameTemplate.popper;
      default:
        return GameTemplate.selector;
    }
  }
}
