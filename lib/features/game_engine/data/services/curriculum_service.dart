import 'package:edufocus/core/data/curriculum_data.dart';
import '../models/lesson_content.dart';
import 'package:edufocus/core/di/di.dart';
import 'package:edufocus/core/network/api_services.dart';

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

  /// Loads the curriculum from the backend API.
  Future<List<CurriculumUnit>> loadCurriculum(SubjectId subjectId) async {
    try {
      String subjectTypeStr;
      switch (subjectId) {
        case SubjectId.arabic:
          subjectTypeStr = 'Arabic';
          break;
        case SubjectId.english:
          subjectTypeStr = 'English';
          break;
        case SubjectId.mathEn:
          subjectTypeStr = 'Math';
          break;
      }

      final apiService = getIt<ApiServices>();
      final curriculum = await apiService.getCurriculum(subjectTypeStr);

      final subjectType = _parseSubject(curriculum.subjectType);
      final List<CurriculumUnit> unitsList = [];

      for (var unit in curriculum.units) {
        final unitIndex = unit.id;
        final title = unit.title;
        final theme = _parseTheme(unit.theme);
        final List<LessonContent> parsedLessons = [];

        for (var i = 0; i < unit.lessons.length; i++) {
          final lesson = unit.lessons[i];
          final gameTemplate = _parseTemplate(lesson.gameTemplate);
          final topic = lesson.topic;

          final questionObj = GameQuestion(
            question: lesson.question,
            questionIsImage: lesson.questionIsImage,
            options: lesson.options
                .map((o) => GameOptionData(
                      text: o.text,
                      isCorrect: o.isCorrect ?? false,
                      category: o.category,
                      sequenceOrder: o.order,
                      imagePath: o.imagePath ?? o.imageHint,
                      audioPath: o.audioPath,
                    ))
                .toList(),
            pairs: (lesson.pairs ?? [])
                .map((p) => MatchPair(
                      left: p.left,
                      right: p.right,
                    ))
                .toList(),
          );

          parsedLessons.add(LessonContent(
            lessonTitle: '$title - $topic',
            subjectType: subjectType,
            gameTemplate: gameTemplate,
            theme: theme,
            questions: [questionObj],
            unitId: unitIndex,
            lessonIndex: i,
            grade: curriculum.grade,
            term: curriculum.term,
            rawSubjectType: curriculum.subjectType,
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
      print('Error loading curriculum from API: $e');
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
