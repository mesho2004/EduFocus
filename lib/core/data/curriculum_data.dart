import 'package:edufocus/features/game_engine/data/services/curriculum_service.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';

// ─────────────────────────────────────────────
//  Enums
// ─────────────────────────────────────────────

enum SubjectId { arabic, english, mathEn }

// ─────────────────────────────────────────────
//  Data Models
// ─────────────────────────────────────────────

class LessonData {
  final String id;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final int stars; // 0–3

  const LessonData({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.isActive = false,
    this.stars = 0,
  });
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
}

class SubjectData {
  final SubjectId id;
  final String title; // displayed title (may be Arabic)
  final String titleEn; // English subtitle / badge
  final String emoji;
  final Color color;
  final Color colorLight;
  final IconData icon;
  final List<UnitData> units;
  final bool isRtl; // true for Arabic-taught subjects

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
}

// ─────────────────────────────────────────────
//  Curriculum — Dynamic Data loader
// ─────────────────────────────────────────────

class CurriculumData {
  CurriculumData._();

  static List<SubjectData>? _cachedSubjects;

  static Future<List<SubjectData>> loadAllSubjects() async {
    if (_cachedSubjects != null) return _cachedSubjects!;

    final svc = CurriculumService();

    final arabicUnits = await svc.loadCurriculum(SubjectId.arabic);
    final arabicUi = _buildSubject(
      SubjectId.arabic,
      'Arabic',
      'Arabic',
      '📖',
      AppColors.brandPurple,
      const Color(0xFFF3E8FF),
      Icons.auto_stories_rounded,
      true,
      arabicUnits,
    );

    final englishUnits = await svc.loadCurriculum(SubjectId.english);
    final englishUi = _buildSubject(
      SubjectId.english,
      'English',
      'English',
      '🔤',
      AppColors.brandBlue,
      const Color(0xFFE0F2FE),
      Icons.translate_rounded,
      false,
      englishUnits,
    );

    final mathEnUnits = await svc.loadCurriculum(SubjectId.mathEn);
    final mathEnUi = _buildSubject(
      SubjectId.mathEn,
      'Math',
      'Math (EN)',
      '➕',
      AppColors.brandOrange,
      const Color(0xFFFFF7ED),
      Icons.functions_rounded,
      false,
      mathEnUnits,
    );

    _cachedSubjects = [arabicUi, englishUi, mathEnUi];
    return _cachedSubjects!;
  }

  static String _unitTitle(bool isRtl, int index) {
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

  static SubjectData _buildSubject(
    SubjectId id,
    String title,
    String titleEn,
    String emoji,
    Color color,
    Color colorLight,
    IconData icon,
    bool isRtl,
    List<CurriculumUnit> curUnits,
  ) {
    final unitsData = curUnits.map((u) {
      final lessonsData = List.generate(u.lessons.length, (i) {
        return LessonData(
          id: '${id.name}_u${u.unitIndex}_l$i',
          title: u.lessons[i].lessonTitle,
          isActive: true,
          isCompleted: false,
        );
      });
      return UnitData(
        id: '${id.name}_u${u.unitIndex}',
        title: _unitTitle(isRtl, u.unitIndex),
        subtitle: u.title,
        lessons: lessonsData,
        isUnlocked: true,
      );
    }).toList();

    return SubjectData(
      id: id,
      title: title,
      titleEn: titleEn,
      emoji: emoji,
      color: color,
      colorLight: colorLight,
      icon: icon,
      isRtl: isRtl,
      units: unitsData,
    );
  }
}
