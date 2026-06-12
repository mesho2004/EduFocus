int? _toInt(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  if (val is double) return val.toInt();
  if (val is String) return int.tryParse(val);
  return null;
}

double? _toDouble(dynamic val) {
  if (val == null) return null;
  if (val is num) return val.toDouble();
  if (val is String) return double.tryParse(val);
  return null;
}

class CompleteLessonModel {
  String? message;
  int? coinsAdded;
  int? starsAdded;
  int? totalCoins;
  int? totalStars;
  OverallProgress? overallProgress;
  SubjectProgress? subjectProgress;
  UnitProgress? unitProgress;
  CompletedLesson? completedLesson;

  CompleteLessonModel({
    this.message,
    this.coinsAdded,
    this.starsAdded,
    this.totalCoins,
    this.totalStars,
    this.overallProgress,
    this.subjectProgress,
    this.unitProgress,
    this.completedLesson,
  });

  CompleteLessonModel.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    coinsAdded = _toInt(json['coins_added']);
    starsAdded = _toInt(json['stars_added']);
    totalCoins = _toInt(json['total_coins'] ?? json['coins']);
    totalStars = _toInt(json['total_stars']);
    overallProgress =
        json['overall_progress'] != null && json['overall_progress'] is Map
        ? OverallProgress.fromJson(
            Map<String, dynamic>.from(json['overall_progress'] as Map),
          )
        : (json['overall_progress'] != null && json['overall_progress'] is num
              ? OverallProgress(
                  overallProgress: _toDouble(json['overall_progress']),
                )
              : null);
    subjectProgress =
        json['subject_progress'] != null && json['subject_progress'] is Map
        ? SubjectProgress.fromJson(
            Map<String, dynamic>.from(json['subject_progress'] as Map),
          )
        : null;
    unitProgress = json['unit_progress'] != null && json['unit_progress'] is Map
        ? UnitProgress.fromJson(
            Map<String, dynamic>.from(json['unit_progress'] as Map),
          )
        : null;
    completedLesson =
        json['completed_lesson'] != null && json['completed_lesson'] is Map
        ? CompletedLesson.fromJson(
            Map<String, dynamic>.from(json['completed_lesson'] as Map),
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['coins_added'] = coinsAdded;
    data['stars_added'] = starsAdded;
    data['total_coins'] = totalCoins;
    data['total_stars'] = totalStars;
    if (overallProgress != null) {
      data['overall_progress'] = overallProgress!.toJson();
    }
    if (subjectProgress != null) {
      data['subject_progress'] = subjectProgress!.toJson();
    }
    if (unitProgress != null) {
      data['unit_progress'] = unitProgress!.toJson();
    }
    if (completedLesson != null) {
      data['completed_lesson'] = completedLesson!.toJson();
    }
    return data;
  }
}

class OverallProgress {
  double? overallProgress;
  int? completedLessons;
  int? totalLessons;

  OverallProgress({
    this.overallProgress,
    this.completedLessons,
    this.totalLessons,
  });

  OverallProgress.fromJson(Map<String, dynamic> json) {
    overallProgress = _toDouble(json['overall_progress']);
    completedLessons = _toInt(json['completed_lessons']);
    totalLessons = _toInt(json['total_lessons']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overall_progress'] = overallProgress;
    data['completed_lessons'] = completedLessons;
    data['total_lessons'] = totalLessons;
    return data;
  }
}

class SubjectProgress {
  String? subjectType;
  int? grade;
  int? term;
  int? totalLessons;
  int? completedLessons;
  double? progress;

  SubjectProgress({
    this.subjectType,
    this.grade,
    this.term,
    this.totalLessons,
    this.completedLessons,
    this.progress,
  });

  SubjectProgress.fromJson(Map<String, dynamic> json) {
    subjectType =
        json['subjectType']?.toString() ?? json['subject_type']?.toString();
    grade = _toInt(json['grade']);
    term = _toInt(json['term']);
    totalLessons = _toInt(json['total_lessons']);
    completedLessons = _toInt(json['completed_lessons']);
    progress = _toDouble(json['progress']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectType'] = subjectType;
    data['grade'] = grade;
    data['term'] = term;
    data['total_lessons'] = totalLessons;
    data['completed_lessons'] = completedLessons;
    data['progress'] = progress;
    return data;
  }
}

class UnitProgress {
  int? unitId;
  String? unitTitle;
  int? totalLessons;
  int? completedLessons;
  double? progress;

  UnitProgress({
    this.unitId,
    this.unitTitle,
    this.totalLessons,
    this.completedLessons,
    this.progress,
  });

  UnitProgress.fromJson(Map<String, dynamic> json) {
    unitId = _toInt(json['unit_id'] ?? json['unitId']);
    unitTitle = json['unit_title']?.toString() ?? json['unitTitle']?.toString();
    totalLessons = _toInt(json['total_lessons']);
    completedLessons = _toInt(json['completed_lessons']);
    progress = _toDouble(json['progress']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = unitId;
    data['unit_title'] = unitTitle;
    data['total_lessons'] = totalLessons;
    data['completed_lessons'] = completedLessons;
    data['progress'] = progress;
    return data;
  }
}

class CompletedLesson {
  String? subjectType;
  int? grade;
  int? term;
  int? unitId;
  String? unitTitle;
  int? lessonNumber;
  String? lessonType;
  String? lessonTitle;
  String? lessonTopic;

  CompletedLesson({
    this.subjectType,
    this.grade,
    this.term,
    this.unitId,
    this.unitTitle,
    this.lessonNumber,
    this.lessonType,
    this.lessonTitle,
    this.lessonTopic,
  });

  CompletedLesson.fromJson(Map<String, dynamic> json) {
    subjectType =
        json['subjectType']?.toString() ?? json['subject_type']?.toString();
    grade = _toInt(json['grade']);
    term = _toInt(json['term']);
    unitId = _toInt(json['unit_id'] ?? json['unitId']);
    unitTitle = json['unit_title']?.toString() ?? json['unitTitle']?.toString();
    lessonNumber = _toInt(
      json['lesson_number'] ?? json['lesson_index'] ?? json['lessonIndex'],
    );
    lessonType =
        json['lesson_type']?.toString() ?? json['lessonType']?.toString();
    lessonTitle = json['lesson_title']?.toString();
    lessonTopic =
        json['lesson_topic']?.toString() ?? json['lessonTopic']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectType'] = subjectType;
    data['grade'] = grade;
    data['term'] = term;
    data['unit_id'] = unitId;
    data['unit_title'] = unitTitle;
    data['lesson_number'] = lessonNumber;
    data['lesson_type'] = lessonType;
    data['lesson_title'] = lessonTitle;
    data['lesson_topic'] = lessonTopic;
    return data;
  }
}
