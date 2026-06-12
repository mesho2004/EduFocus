import 'package:equatable/equatable.dart';
import '../../data/models/lesson_content.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class GameLoadEvent extends GameEvent {
  final LessonContent content;

  const GameLoadEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class GameOptionSelectedEvent extends GameEvent {
  final int optionIndex;

  const GameOptionSelectedEvent(this.optionIndex);

  @override
  List<Object?> get props => [optionIndex];
}

class GameSequenceTappedEvent extends GameEvent {
  final int optionIndex;

  const GameSequenceTappedEvent(this.optionIndex);

  @override
  List<Object?> get props => [optionIndex];
}

class GameSorterDroppedEvent extends GameEvent {
  final int itemIndex;
  final String bucketLabel;

  const GameSorterDroppedEvent({
    required this.itemIndex,
    required this.bucketLabel,
  });

  @override
  List<Object?> get props => [itemIndex, bucketLabel];
}

class GameNextQuestionEvent extends GameEvent {
  const GameNextQuestionEvent();
}

class GameResetEvent extends GameEvent {
  const GameResetEvent();
}

class GameWrongAttemptEvent extends GameEvent {
  final int itemIndex;

  const GameWrongAttemptEvent({this.itemIndex = -1});

  @override
  List<Object?> get props => [itemIndex];
}

class GameStepCompleteEvent extends GameEvent {
  const GameStepCompleteEvent();
}
