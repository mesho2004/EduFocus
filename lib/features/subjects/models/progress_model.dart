class ProgressModel {
  final double overallProgress;
  final int completedLessons;
  final int totalLessons;
  final int coins;
  final int streakDays;
  final List<SubjectProgressModel> subjects;

  ProgressModel({
    required this.overallProgress,
    required this.completedLessons,
    required this.totalLessons,
    required this.coins,
    required this.streakDays,
    required this.subjects,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      overallProgress: double.tryParse((json['overall_progress'] ?? json['overallProgress'])?.toString() ?? '') ?? 0.0,
      completedLessons: int.tryParse((json['completed_lessons'] ?? json['completedLessons'])?.toString() ?? '') ?? 0,
      totalLessons: int.tryParse((json['total_lessons'] ?? json['totalLessons'])?.toString() ?? '') ?? 0,
      coins: int.tryParse(json['coins']?.toString() ?? '') ?? 0,
      streakDays: int.tryParse((json['streak_days'] ?? json['streakDays'])?.toString() ?? '') ?? 0,
      subjects: json['subjects'] is List
          ? (json['subjects'] as List)
              .map((e) => SubjectProgressModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  ProgressModel copyWith({
    double? overallProgress,
    int? completedLessons,
    int? totalLessons,
    int? coins,
    int? streakDays,
    List<SubjectProgressModel>? subjects,
  }) {
    return ProgressModel(
      overallProgress: overallProgress ?? this.overallProgress,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      coins: coins ?? this.coins,
      streakDays: streakDays ?? this.streakDays,
      subjects: subjects ?? this.subjects,
    );
  }
}

class SubjectProgressModel {
  final String subjectType;
  final int grade;
  final int term;
  final int totalLessons;
  final int completedLessons;
  final double progress;
  final List<UnitProgressModel> units;

  SubjectProgressModel({
    required this.subjectType,
    required this.grade,
    required this.term,
    required this.totalLessons,
    required this.completedLessons,
    required this.progress,
    required this.units,
  });

  factory SubjectProgressModel.fromJson(Map<String, dynamic> json) {
    return SubjectProgressModel(
      subjectType: (json['subject_type'] ?? json['subjectType'] ?? '').toString(),
      grade: int.tryParse(json['grade']?.toString() ?? '') ?? 0,
      term: int.tryParse(json['term']?.toString() ?? '') ?? 0,
      totalLessons: int.tryParse((json['total_lessons'] ?? json['totalLessons'])?.toString() ?? '') ?? 0,
      completedLessons: int.tryParse((json['completed_lessons'] ?? json['completedLessons'])?.toString() ?? '') ?? 0,
      progress: double.tryParse((json['progress'] ?? json['overall_progress'])?.toString() ?? '') ?? 0.0,
      units: json['units'] is List
          ? (json['units'] as List)
              .map((e) => UnitProgressModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

class UnitProgressModel {
  final int unitId;
  final String unitTitle;
  final int totalLessons;
  final int completedLessons;
  final double progress;

  UnitProgressModel({
    required this.unitId,
    required this.unitTitle,
    required this.totalLessons,
    required this.completedLessons,
    required this.progress,
  });

  factory UnitProgressModel.fromJson(Map<String, dynamic> json) {
    return UnitProgressModel(
      unitId: int.tryParse((json['unit_id'] ?? json['unitId'])?.toString() ?? '') ?? 0,
      unitTitle: (json['unit_title'] ?? json['unitTitle'] ?? '').toString(),
      totalLessons: int.tryParse((json['total_lessons'] ?? json['totalLessons'])?.toString() ?? '') ?? 0,
      completedLessons: int.tryParse((json['completed_lessons'] ?? json['completedLessons'])?.toString() ?? '') ?? 0,
      progress: double.tryParse(json['progress']?.toString() ?? '') ?? 0.0,
    );
  }
}