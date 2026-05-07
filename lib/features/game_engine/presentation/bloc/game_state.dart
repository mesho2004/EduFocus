import 'package:equatable/equatable.dart';
import '../../data/models/lesson_content.dart';

/// Base class for all Game Engine states.
abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

// ─────────────────────────────────────────────
//  Lifecycle states
// ─────────────────────────────────────────────

/// Nothing has been loaded yet.
class GameInitialState extends GameState {
  const GameInitialState();
}

// ─────────────────────────────────────────────
//  Playing states
// ─────────────────────────────────────────────

/// Shared payload carried by all "in-game" states.
class GameInProgressState extends GameState {
  final LessonContent content;
  final int questionIndex;
  final int score;

  /// For the Sequence game — list of option indices the player has tapped so far.
  final List<int> sequenceSoFar;

  const GameInProgressState({
    required this.content,
    required this.questionIndex,
    required this.score,
    this.sequenceSoFar = const [],
  });

  GameQuestion get currentQuestion =>
      content.questions[questionIndex];

  int get totalQuestions => content.questions.length;

  /// Returns a copy with modified fields.
  GameInProgressState copyWith({
    int? questionIndex,
    int? score,
    List<int>? sequenceSoFar,
  }) {
    return GameInProgressState(
      content: content,
      questionIndex: questionIndex ?? this.questionIndex,
      score: score ?? this.score,
      sequenceSoFar: sequenceSoFar ?? this.sequenceSoFar,
    );
  }

  @override
  List<Object?> get props => [content, questionIndex, score, sequenceSoFar];
}

/// The player chose the correct answer — triggers reward overlay.
class GameCorrectAnswerState extends GameInProgressState {
  final int answeredOptionIndex;

  const GameCorrectAnswerState({
    required super.content,
    required super.questionIndex,
    required super.score,
    required this.answeredOptionIndex,
  });

  @override
  List<Object?> get props => [...super.props, answeredOptionIndex];
}

/// The player chose the wrong answer — triggers shake animation.
class GameWrongAnswerState extends GameInProgressState {
  final int answeredOptionIndex;

  const GameWrongAnswerState({
    required super.content,
    required super.questionIndex,
    required super.score,
    required this.answeredOptionIndex,
  });

  @override
  List<Object?> get props => [...super.props, answeredOptionIndex];
}

// ─────────────────────────────────────────────
//  End state
// ─────────────────────────────────────────────

/// All questions answered — show the summary/celebration screen.
class GameCompletedState extends GameState {
  final LessonContent content;
  final int score;
  final int totalQuestions;

  const GameCompletedState({
    required this.content,
    required this.score,
    required this.totalQuestions,
  });

  int get stars {
    final ratio = score / totalQuestions;
    if (ratio >= 0.9) return 3;
    if (ratio >= 0.6) return 2;
    return 1;
  }

  @override
  List<Object?> get props => [content, score, totalQuestions];
}
