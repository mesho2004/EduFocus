import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/features/subjects/models/progress_model.dart';
import 'package:edufocus/features/auth/data/models/child_model.dart';
import 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  final ApiServices _apiServices;
  final FlutterSecureStorage _secureStorage;
  final StarsCubit _starsCubit;

  CurriculumCubit({
    required ApiServices apiServices,
    required StarsCubit starsCubit,
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(),
  }) : _apiServices = apiServices,
       _starsCubit = starsCubit,
       _secureStorage = secureStorage,
       super(CurriculumInitial());

  Future<void> loadCurriculum() async {
    emit(CurriculumLoading());
    try {
      final curriculums = await _apiServices.getAllCurriculums();
      final token = await _secureStorage.read(key: 'auth_token');
      print('=== loadCurriculum DEBUG ===');
      print('Token present: ${token != null}');
      print('Curriculums fetched: ${curriculums.length}');

      ProgressModel? progressModel;
      ChildModel? childProfile;
      if (token != null) {
        try {
          progressModel = await _apiServices.getMyProgress(token);
          print('✅ getMyProgress SUCCESS');
          print('   coins: ${progressModel.coins}');
          print('   completedLessons: ${progressModel.completedLessons}');
          print('   totalLessons: ${progressModel.totalLessons}');
          print('   subjects count: ${progressModel.subjects.length}');
          for (final sp in progressModel.subjects) {
            print(
              '   Subject: ${sp.subjectType}, completed: ${sp.completedLessons}, units: ${sp.units.length}',
            );
            for (final up in sp.units) {
              print(
                '     Unit ${up.unitId}: completed ${up.completedLessons}/${up.totalLessons}',
              );
            }
          }
          _starsCubit.setStars(progressModel.coins);
        } catch (e, stackTrace) {
          print('❌ Failed to load my progress from API: $e');
          print('   Stack trace: $stackTrace');
        }

        try {
          childProfile = await _apiServices.getChildProfile(token);
        } catch (e) {
          print('Failed to load child profile from API: $e');
        }
      } else {
        print('⚠️ No auth token found — skipping progress fetch');
      }

      final completedJson = await _secureStorage.read(key: 'completed_lessons');
      final Set<String> completedKeys = completedJson != null
          ? Set<String>.from(jsonDecode(completedJson))
          : {};
      print('Local completedKeys (${completedKeys.length}): $completedKeys');

      var subjects = CurriculumData.parseCurriculums(
        curriculums,
        completedKeys,
      );

      if (progressModel != null) {
        print('Merging API progress into subjects...');
        subjects = _mergeProgress(subjects, progressModel);

        for (final s in subjects) {
          final completed = s.units.fold<int>(
            0,
            (sum, u) => sum + u.completedLessons,
          );
          print('   After merge — ${s.id.name}: $completed completed');
        }
      } else {
        print('⚠️ progressModel is null — no API progress to merge');
      }

      print('=== loadCurriculum DONE ===');

      emit(
        CurriculumLoaded(
          subjects,
          progressModel: progressModel,
          childProfile: childProfile,
        ),
      );
    } catch (e, stackTrace) {
      print('❌ loadCurriculum FAILED: $e');
      print('   Stack trace: $stackTrace');
      emit(CurriculumError(e.toString()));
    }
  }

  Future<void> completeLesson({
    required String subjectType,
    required int unitId,
    required int lessonIndex,
    int? grade,
    int? term,
  }) async {
    final token = await _secureStorage.read(key: 'auth_token');

    if (token != null) {
      try {
        final completeLessonModel = await _apiServices.completeLesson(
          subjectType: subjectType,
          unitId: unitId,
          lessonIndex: lessonIndex + 1,
          grade: grade ?? 1,
          term: term ?? 2,
          token: token,
        );
        if (completeLessonModel.totalCoins != null) {
          _starsCubit.setStars(completeLessonModel.totalCoins!);
        }
      } catch (e) {
        print('API completeLesson failed: $e');
      }
    }

    try {
      final completedJson = await _secureStorage.read(key: 'completed_lessons');
      final Set<String> completedKeys = completedJson != null
          ? Set<String>.from(jsonDecode(completedJson))
          : {};

      final subjectId = CurriculumData.parseSubjectId(subjectType);
      if (subjectId != null) {
        final key = '${subjectId.name}_u${unitId}_l$lessonIndex';
        completedKeys.add(key);

        await _secureStorage.write(
          key: 'completed_lessons',
          value: jsonEncode(completedKeys.toList()),
        );

        if (state is CurriculumLoaded) {
          final loaded = state as CurriculumLoaded;
          final currentSubjects = loaded.subjects;
          final currentProgress = loaded.progressModel;
          final updatedSubjects = _updateSubjectLessonCompleted(
            currentSubjects,
            subjectId,
            unitId,
            lessonIndex,
          );

          final totalLessons = updatedSubjects.fold<int>(
            0,
            (s, sub) => s + sub.totalLessons,
          );
          final completedLessons = updatedSubjects.fold<int>(
            0,
            (s, sub) => s + sub.completedLessons,
          );
          final overallProgress = totalLessons == 0
              ? 0.0
              : completedLessons / totalLessons;

          final updatedProgress = currentProgress?.copyWith(
            overallProgress: overallProgress,
            completedLessons: completedLessons,
            totalLessons: totalLessons,
            coins: _starsCubit.state,
          );

          emit(
            CurriculumLoaded(
              updatedSubjects,
              progressModel: updatedProgress,
              childProfile: loaded.childProfile,
            ),
          );
        }
      }
    } catch (e) {
      print('Local persistence of completeLesson failed: $e');
    }
  }

  List<SubjectData> _mergeProgress(
    List<SubjectData> subjects,
    ProgressModel progressModel,
  ) {
    return subjects.map((subject) {
      final subjectProg = progressModel.subjects.firstWhereOrNull(
        (sp) => CurriculumData.parseSubjectId(sp.subjectType) == subject.id,
      );

      if (subjectProg == null) return subject;

      final updatedUnits = subject.units.map((unit) {
        final parts = unit.id.split('_u');
        final unitId = parts.length > 1 ? int.tryParse(parts[1]) : null;

        final unitProg = subjectProg.units.firstWhereOrNull(
          (up) => up.unitId == unitId,
        );

        if (unitProg == null) return unit;

        final updatedLessons = List<LessonData>.generate(unit.lessons.length, (
          i,
        ) {
          final lesson = unit.lessons[i];
          final isCompleted =
              lesson.isCompleted || i < unitProg.completedLessons;
          return lesson.copyWith(
            isCompleted: isCompleted,
            stars: isCompleted ? 3 : 0,
          );
        });

        return unit.copyWith(lessons: updatedLessons);
      }).toList();

      return subject.copyWith(units: updatedUnits);
    }).toList();
  }

  List<SubjectData> _updateSubjectLessonCompleted(
    List<SubjectData> subjects,
    SubjectId subjectId,
    int unitId,
    int lessonIndex,
  ) {
    return subjects.map((subject) {
      if (subject.id != subjectId) return subject;

      final updatedUnits = subject.units.map((unit) {
        final expectedUnitId = '${subjectId.name}_u$unitId';
        if (unit.id != expectedUnitId) return unit;

        final updatedLessons = List<LessonData>.generate(unit.lessons.length, (
          i,
        ) {
          final lesson = unit.lessons[i];
          if (i == lessonIndex) {
            return lesson.copyWith(isCompleted: true, stars: 3);
          }
          return lesson;
        });

        return unit.copyWith(lessons: updatedLessons);
      }).toList();

      return subject.copyWith(units: updatedUnits);
    }).toList();
  }

  Future<void> updateChildProfile({
    required String name,
    required int age,
  }) async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token != null) {
      try {
        final updatedChild = await _apiServices.updateChildProfile(
          name: name,
          age: age,
          token: token,
        );
        if (state is CurriculumLoaded) {
          final loaded = state as CurriculumLoaded;
          emit(
            CurriculumLoaded(
              loaded.subjects,
              progressModel: loaded.progressModel,
              childProfile: updatedChild,
            ),
          );
        }
      } catch (e) {
        print('Failed to update child profile: $e');
        rethrow;
      }
    }
  }

  void clearCurriculum() {
    emit(CurriculumInitial());
  }
}
