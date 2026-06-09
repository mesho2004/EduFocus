class CompleteLessonModel {
  final String message;
  final int coinsAdded;
  final int totalCoins;
  final OverallProgressModel overallProgress;
  final SubjectProgressModel subjectProgress;
  final UnitProgressModel unitProgress;
  final CompletedLessonModel completedLesson;

  CompleteLessonModel({
    required this.message,
    required this.coinsAdded,
    required this.totalCoins,
    required this.overallProgress,
    required this.subjectProgress,
    required this.unitProgress,
    required this.completedLesson,
  });

  factory CompleteLessonModel.fromJson(Map<String, dynamic> json) {
    return CompleteLessonModel(
      message: json['message'] as String,
      coinsAdded: json['coins_added'] as int,
      totalCoins: json['total_coins'] as int,
      overallProgress: OverallProgressModel.fromJson(
        json['overall_progress'] as Map<String, dynamic>,
      ),
      subjectProgress: SubjectProgressModel.fromJson(
        json['subject_progress'] as Map<String, dynamic>,
      ),
      unitProgress: UnitProgressModel.fromJson(
        json['unit_progress'] as Map<String, dynamic>,
      ),
      completedLesson: CompletedLessonModel.fromJson(
        json['completed_lesson'] as Map<String, dynamic>,
      ),
    );
  }
}

class OverallProgressModel {
  final double overallProgress;
  final int completedLessons;
  final int totalLessons;

  OverallProgressModel({
    required this.overallProgress,
    required this.completedLessons,
    required this.totalLessons,
  });

  factory OverallProgressModel.fromJson(Map<String, dynamic> json) {
    return OverallProgressModel(
      overallProgress: (json['overall_progress'] as num).toDouble(),
      completedLessons: json['completed_lessons'] as int,
      totalLessons: json['total_lessons'] as int,
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

  SubjectProgressModel({
    required this.subjectType,
    required this.grade,
    required this.term,
    required this.totalLessons,
    required this.completedLessons,
    required this.progress,
  });

  factory SubjectProgressModel.fromJson(Map<String, dynamic> json) {
    return SubjectProgressModel(
      subjectType: json['subjectType'] as String,
      grade: json['grade'] as int,
      term: json['term'] as int,
      totalLessons: json['total_lessons'] as int,
      completedLessons: json['completed_lessons'] as int,
      progress: (json['progress'] as num).toDouble(),
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
      unitId: json['unit_id'] as int,
      unitTitle: json['unit_title'] as String,
      totalLessons: json['total_lessons'] as int,
      completedLessons: json['completed_lessons'] as int,
      progress: (json['progress'] as num).toDouble(),
    );
  }
}

class CompletedLessonModel {
  final String subjectType;
  final int grade;
  final int term;
  final int unitId;
  final String unitTitle;
  final int lessonIndex;
  final String lessonType;
  final String lessonTopic;

  CompletedLessonModel({
    required this.subjectType,
    required this.grade,
    required this.term,
    required this.unitId,
    required this.unitTitle,
    required this.lessonIndex,
    required this.lessonType,
    required this.lessonTopic,
  });

  factory CompletedLessonModel.fromJson(Map<String, dynamic> json) {
    return CompletedLessonModel(
      subjectType: json['subjectType'] as String,
      grade: json['grade'] as int,
      term: json['term'] as int,
      unitId: json['unit_id'] as int,
      unitTitle: json['unit_title'] as String,
      lessonIndex: json['lesson_index'] as int,
      lessonType: json['lesson_type'] as String,
      lessonTopic: json['lesson_topic'] as String,
    );
  }
}
