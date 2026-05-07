import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/data/curriculum_data.dart';
import '../../data/services/curriculum_service.dart';
import 'curriculum_session_state.dart';

class CurriculumSessionCubit extends Cubit<CurriculumSessionState> {
  final CurriculumService _curriculumService;

  CurriculumSessionCubit({
    required CurriculumService curriculumService,
  })  : _curriculumService = curriculumService,
        super(CurriculumSessionInitial());

  List<CurriculumUnit> _cachedCurriculum = [];

  Future<void> loadCurriculum(SubjectId subjectId) async {
    emit(CurriculumSessionLoading());
    try {
      final units = await _curriculumService.loadCurriculum(subjectId);
      if (units.isEmpty) {
        emit(const CurriculumSessionError('Failed to load curriculum or it is empty.'));
        return;
      }
      _cachedCurriculum = units;
      emit(CurriculumSessionLoaded(
        curriculum: units,
        currentUnitIndex: 0,
        currentLessonIndex: 0,
        score: 0,
      ));
    } catch (e) {
      emit(CurriculumSessionError(e.toString()));
    }
  }

  void nextLesson({int scoreIncrement = 1}) {
    if (state is CurriculumSessionLoaded) {
      final currentState = state as CurriculumSessionLoaded;
      final newScore = currentState.score + scoreIncrement;

      if (currentState.isLastLessonInUnit) {
        // Unit complete
        emit(CurriculumUnitCompleted(
          completedUnit: currentState.currentUnit,
          score: newScore,
        ));
      } else {
        // Next lesson in the same unit
        emit(currentState.copyWith(
          currentLessonIndex: currentState.currentLessonIndex + 1,
          score: newScore,
        ));
      }
    }
  }

  void continueToNextUnit() {
    if (state is CurriculumUnitCompleted) {
      final completedState = state as CurriculumUnitCompleted;
      final completedUnitIndex = _cachedCurriculum.indexOf(completedState.completedUnit);

      if (completedUnitIndex == _cachedCurriculum.length - 1) {
        // All units finished
        emit(CurriculumAllUnitsCompleted(totalScore: completedState.score));
      } else {
        // Proceed to next unit
        emit(CurriculumSessionLoaded(
          curriculum: _cachedCurriculum,
          currentUnitIndex: completedUnitIndex + 1,
          currentLessonIndex: 0,
          score: completedState.score,
        ));
      }
    }
  }

  void replayCurrentUnit() {
    if (state is CurriculumUnitCompleted) {
      final completedState = state as CurriculumUnitCompleted;
      final unitIndex = _cachedCurriculum.indexOf(completedState.completedUnit);
      
      emit(CurriculumSessionLoaded(
        curriculum: _cachedCurriculum,
        currentUnitIndex: unitIndex,
        currentLessonIndex: 0,
        score: completedState.score, // Or reset to 0 based on rules
      ));
    }
  }
}
