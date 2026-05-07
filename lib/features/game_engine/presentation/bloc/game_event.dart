import 'package:equatable/equatable.dart';
import '../../data/models/lesson_content.dart';

/// Base class for all Game Engine events.
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

// ─────────────────────────────────────────────
//  Load a lesson into the engine
// ─────────────────────────────────────────────

/// Inject a [LessonContent] to initialise or replace the current game.
class GameLoadEvent extends GameEvent {
  final LessonContent content;

  const GameLoadEvent(this.content);

  @override
  List<Object?> get props => [content];
}

// ─────────────────────────────────────────────
//  Player interactions
// ─────────────────────────────────────────────

/// Fired when the player selects an option card (Selector / Sorter game).
class GameOptionSelectedEvent extends GameEvent {
  final int optionIndex;

  const GameOptionSelectedEvent(this.optionIndex);

  @override
  List<Object?> get props => [optionIndex];
}

/// Fired when the player taps a token in the Sequence game.
class GameSequenceTappedEvent extends GameEvent {
  final int optionIndex;

  const GameSequenceTappedEvent(this.optionIndex);

  @override
  List<Object?> get props => [optionIndex];
}

/// Fired when the player drops an item onto a Sorter bucket.
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

// ─────────────────────────────────────────────
//  Navigation
// ─────────────────────────────────────────────

/// Advance to the next question after a reward is shown.
class GameNextQuestionEvent extends GameEvent {
  const GameNextQuestionEvent();
}

/// Restart the entire game from the first question.
class GameResetEvent extends GameEvent {
  const GameResetEvent();
}

// ─────────────────────────────────────────────
//  Multi-step game events (Matcher, Popper)
// ─────────────────────────────────────────────

/// Fired on a single wrong attempt in a multi-step game.
/// [itemIndex] ensures each emission is unique for Equatable.
class GameWrongAttemptEvent extends GameEvent {
  final int itemIndex;

  const GameWrongAttemptEvent({this.itemIndex = -1});

  @override
  List<Object?> get props => [itemIndex];
}

/// Fired when a multi-step game is fully completed (all pairs matched / all correct bubbles popped).
class GameStepCompleteEvent extends GameEvent {
  const GameStepCompleteEvent();
}
