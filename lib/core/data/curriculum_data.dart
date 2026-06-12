import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/di/di.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:edufocus/features/subjects/models/curriculum_model.dart';

enum SubjectId { arabic, english, mathEn }

class LessonData {
  final String id;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final int stars;

  const LessonData({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.isActive = false,
    this.stars = 0,
  });

  LessonData copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    bool? isActive,
    int? stars,
  }) {
    return LessonData(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
      stars: stars ?? this.stars,
    );
  }
}

class UnitData {
  final String id;
  final String title;
  final String subtitle;
  final List<LessonData> lessons;
  final bool isUnlocked;

  const UnitData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
    this.isUnlocked = false,
  });

  int get completedLessons => lessons.where((l) => l.isCompleted).length;

  double get progress =>
      lessons.isEmpty ? 0 : completedLessons / lessons.length;

  UnitData copyWith({
    String? id,
    String? title,
    String? subtitle,
    List<LessonData>? lessons,
    bool? isUnlocked,
  }) {
    return UnitData(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessons: lessons ?? this.lessons,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

class SubjectData {
  final SubjectId id;
  final String title;
  final String titleEn;
  final String emoji;
  final Color color;
  final Color colorLight;
  final IconData icon;
  final List<UnitData> units;
  final bool isRtl;

  const SubjectData({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.color,
    required this.colorLight,
    required this.icon,
    required this.units,
    this.isRtl = false,
  });

  int get totalLessons => units.fold(0, (sum, u) => sum + u.lessons.length);

  int get completedLessons =>
      units.fold(0, (sum, u) => sum + u.completedLessons);

  double get overallProgress =>
      totalLessons == 0 ? 0 : completedLessons / totalLessons;

  String get progressLabel => '$completedLessons / $totalLessons دروس';

  SubjectData copyWith({
    SubjectId? id,
    String? title,
    String? titleEn,
    String? emoji,
    Color? color,
    Color? colorLight,
    IconData? icon,
    List<UnitData>? units,
    bool? isRtl,
  }) {
    return SubjectData(
      id: id ?? this.id,
      title: title ?? this.title,
      titleEn: titleEn ?? this.titleEn,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      colorLight: colorLight ?? this.colorLight,
      icon: icon ?? this.icon,
      units: units ?? this.units,
      isRtl: isRtl ?? this.isRtl,
    );
  }
}

class CurriculumData {
  CurriculumData._();

  static List<SubjectData>? _cachedSubjects;

  static Future<List<SubjectData>> loadAllSubjects() async {
    if (_cachedSubjects != null) return _cachedSubjects!;

    try {
      final apiService = getIt<ApiServices>();
      final List<CurriculumModel> curriculums = await apiService
          .getAllCurriculums();
      _cachedSubjects = parseCurriculums(curriculums, {});
      return _cachedSubjects!;
    } catch (e) {
      print('Error in loadAllSubjects: $e');
      return [];
    }
  }

  static List<SubjectData> parseCurriculums(
    List<CurriculumModel> curriculums,
    Set<String> completedKeys,
  ) {
    final List<SubjectData> subjects = [];
    for (var model in curriculums) {
      final subjectId = parseSubjectId(model.subjectType);
      if (subjectId == null) continue;

      String title = '';
      String titleEn = '';
      String emoji = '';
      Color color = Colors.blue;
      Color colorLight = Colors.blue.withOpacity(0.1);
      IconData icon = Icons.book;
      bool isRtl = false;

      switch (subjectId) {
        case SubjectId.arabic:
          title = 'Arabic';
          titleEn = 'Arabic';
          emoji = '📖';
          color = AppColors.brandPurple;
          colorLight = const Color(0xFFF3E8FF);
          icon = Icons.auto_stories_rounded;
          isRtl = true;
          break;
        case SubjectId.english:
          title = 'English';
          titleEn = 'English';
          emoji = '🔤';
          color = AppColors.brandBlue;
          colorLight = const Color(0xFFE0F2FE);
          icon = Icons.translate_rounded;
          isRtl = false;
          break;
        case SubjectId.mathEn:
          title = 'Math';
          titleEn = 'Math (EN)';
          emoji = '➕';
          color = AppColors.brandOrange;
          colorLight = const Color(0xFFFFF7ED);
          icon = Icons.functions_rounded;
          isRtl = false;
          break;
      }

      final unitsData = model.units.map((u) {
        final lessonsData = List.generate(u.lessons.length, (i) {
          final lesson = u.lessons[i];
          final lessonKey = '${subjectId.name}_u${u.id}_l$i';
          final isCompleted = completedKeys.contains(lessonKey);
          return LessonData(
            id: lessonKey,
            title: '${u.title} - ${lesson.topic}',
            isActive: true,
            isCompleted: isCompleted,
            stars: isCompleted ? 3 : 0,
          );
        });
        return UnitData(
          id: '${subjectId.name}_u${u.id}',
          title: unitTitle(isRtl, u.id),
          subtitle: u.title,
          lessons: lessonsData,
          isUnlocked: true,
        );
      }).toList();

      subjects.add(
        SubjectData(
          id: subjectId,
          title: title,
          titleEn: titleEn,
          emoji: emoji,
          color: color,
          colorLight: colorLight,
          icon: icon,
          isRtl: isRtl,
          units: unitsData,
        ),
      );
    }
    return subjects;
  }

  static SubjectId? parseSubjectId(String type) {
    switch (type.toLowerCase()) {
      case 'arabic':
        return SubjectId.arabic;
      case 'english':
        return SubjectId.english;
      case 'math':
      case 'math_en':
      case 'mathen':
        return SubjectId.mathEn;
      default:
        return null;
    }
  }

  static String unitTitle(bool isRtl, int index) {
    if (!isRtl) return 'Unit $index';
    const arabicOrdinals = [
      'الأولى',
      'الثانية',
      'الثالثة',
      'الرابعة',
      'الخامسة',
      'السادسة',
      'السابعة',
      'الثامنة',
      'التاسعة',
      'العاشرة',
      'الحادية عشر',
      'الثانية عشر',
      'الثالثة عشر',
    ];
    if (index >= 1 && index <= arabicOrdinals.length) {
      return 'الوحدة ${arabicOrdinals[index - 1]}';
    }
    return 'الوحدة $index';
  }
}
