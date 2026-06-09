import 'package:equatable/equatable.dart';
import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/subjects/models/progress_model.dart';
import 'package:edufocus/features/auth/models/child_model.dart';

abstract class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object?> get props => [];
}

class CurriculumInitial extends CurriculumState {}

class CurriculumLoading extends CurriculumState {}

class CurriculumLoaded extends CurriculumState {
  final List<SubjectData> subjects;
  final ProgressModel? progressModel;
  final ChildModel? childProfile;

  const CurriculumLoaded(this.subjects, {this.progressModel, this.childProfile});

  @override
  List<Object?> get props => [subjects, progressModel, childProfile];
}

class CurriculumError extends CurriculumState {
  final String message;

  const CurriculumError(this.message);

  @override
  List<Object?> get props => [message];
}
