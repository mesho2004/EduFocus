import 'package:equatable/equatable.dart';
import '../../data/services/curriculum_service.dart';
import '../../data/models/lesson_content.dart';

abstract class CurriculumSessionState extends Equatable {
  const CurriculumSessionState();

  @override
  List<Object?> get props => [];
}

class CurriculumSessionInitial extends CurriculumSessionState {}

class CurriculumSessionLoading extends CurriculumSessionState {}

class CurriculumSessionLoaded extends CurriculumSessionState {
  final List<CurriculumUnit> curriculum;
  final int currentUnitIndex;
  final int currentLessonIndex;
  final int score;

  const CurriculumSessionLoaded({
    required this.curriculum,
    required this.currentUnitIndex,
    required this.currentLessonIndex,
    this.score = 0,
  });

  CurriculumUnit get currentUnit => curriculum[currentUnitIndex];
  LessonContent get currentLesson => currentUnit.lessons[currentLessonIndex];

  bool get isLastLessonInUnit =>
      currentLessonIndex == currentUnit.lessons.length - 1;
  bool get isLastUnit => currentUnitIndex == curriculum.length - 1;

  @override
  List<Object?> get props => [
    curriculum,
    currentUnitIndex,
    currentLessonIndex,
    score,
  ];

  CurriculumSessionLoaded copyWith({
    List<CurriculumUnit>? curriculum,
    int? currentUnitIndex,
    int? currentLessonIndex,
    int? score,
  }) {
    return CurriculumSessionLoaded(
      curriculum: curriculum ?? this.curriculum,
      currentUnitIndex: currentUnitIndex ?? this.currentUnitIndex,
      currentLessonIndex: currentLessonIndex ?? this.currentLessonIndex,
      score: score ?? this.score,
    );
  }
}

class CurriculumUnitCompleted extends CurriculumSessionState {
  final CurriculumUnit completedUnit;
  final int score;

  const CurriculumUnitCompleted({
    required this.completedUnit,
    required this.score,
  });

  @override
  List<Object?> get props => [completedUnit, score];
}

class CurriculumAllUnitsCompleted extends CurriculumSessionState {
  final int totalScore;

  const CurriculumAllUnitsCompleted({required this.totalScore});

  @override
  List<Object?> get props => [totalScore];
}

class CurriculumSessionError extends CurriculumSessionState {
  final String message;

  const CurriculumSessionError(this.message);

  @override
  List<Object?> get props => [message];
}
