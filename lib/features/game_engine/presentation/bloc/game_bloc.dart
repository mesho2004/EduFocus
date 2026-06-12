import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameInitialState()) {
    on<GameLoadEvent>(_onLoad);
    on<GameOptionSelectedEvent>(_onOptionSelected);
    on<GameSequenceTappedEvent>(_onSequenceTapped);
    on<GameSorterDroppedEvent>(_onSorterDropped);
    on<GameNextQuestionEvent>(_onNextQuestion);
    on<GameResetEvent>(_onReset);
    on<GameWrongAttemptEvent>(_onWrongAttempt);
    on<GameStepCompleteEvent>(_onStepComplete);
  }

  void _onLoad(GameLoadEvent event, Emitter<GameState> emit) {
    emit(
      GameInProgressState(content: event.content, questionIndex: 0, score: 0),
    );
  }

  void _onOptionSelected(
    GameOptionSelectedEvent event,
    Emitter<GameState> emit,
  ) {
    final current = _requireInProgress();
    if (current == null) return;

    final option = current.currentQuestion.options[event.optionIndex];

    if (option.isCorrect) {
      emit(
        GameCorrectAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score + 1,
          answeredOptionIndex: event.optionIndex,
        ),
      );
    } else {
      emit(
        GameWrongAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score,
          answeredOptionIndex: event.optionIndex,
        ),
      );
    }
  }

  void _onSequenceTapped(
    GameSequenceTappedEvent event,
    Emitter<GameState> emit,
  ) {
    final current = _requireInProgress();
    if (current == null) return;

    if (current.sequenceSoFar.contains(event.optionIndex)) return;

    final updatedSequence = [...current.sequenceSoFar, event.optionIndex];
    final options = current.currentQuestion.options;

    final ordered = List<int>.generate(options.length, (i) => i)
      ..sort(
        (a, b) => (options[a].sequenceOrder ?? 0).compareTo(
          options[b].sequenceOrder ?? 0,
        ),
      );

    final expectedIndex = ordered[current.sequenceSoFar.length];
    if (event.optionIndex != expectedIndex) {
      emit(
        GameWrongAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score,
          answeredOptionIndex: event.optionIndex,
        ),
      );

      emit(current.copyWith(sequenceSoFar: []));
      return;
    }

    if (updatedSequence.length == options.length) {
      emit(
        GameCorrectAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score + 1,
          answeredOptionIndex: event.optionIndex,
        ),
      );
    } else {
      emit(current.copyWith(sequenceSoFar: updatedSequence));
    }
  }

  void _onSorterDropped(GameSorterDroppedEvent event, Emitter<GameState> emit) {
    final current = _requireInProgress();
    if (current == null) return;

    final option = current.currentQuestion.options[event.itemIndex];

    bool isCorrect = false;
    if (option.category != null) {
      isCorrect = (option.category == event.bucketLabel);
    } else {
      isCorrect =
          (option.isCorrect && event.bucketLabel == '✅ Correct') ||
          (!option.isCorrect && event.bucketLabel == '❌ Wrong');
    }

    if (isCorrect) {
      emit(
        GameCorrectAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score + 1,
          answeredOptionIndex: event.itemIndex,
        ),
      );
    } else {
      emit(
        GameWrongAnswerState(
          content: current.content,
          questionIndex: current.questionIndex,
          score: current.score,
          answeredOptionIndex: event.itemIndex,
        ),
      );
    }
  }

  void _onNextQuestion(GameNextQuestionEvent event, Emitter<GameState> emit) {
    final current = _requireInProgress();
    if (current == null) return;

    final nextIndex = current.questionIndex + 1;

    if (nextIndex >= current.content.questions.length) {
      emit(
        GameCompletedState(
          content: current.content,
          score: current.score,
          totalQuestions: current.content.questions.length,
        ),
      );
    } else {
      emit(current.copyWith(questionIndex: nextIndex, sequenceSoFar: []));
    }
  }

  void _onReset(GameResetEvent event, Emitter<GameState> emit) {
    final current = _requireInProgress();
    final content =
        current?.content ??
        (state is GameCompletedState
            ? (state as GameCompletedState).content
            : null);

    if (content != null) {
      emit(GameInProgressState(content: content, questionIndex: 0, score: 0));
    } else {
      emit(const GameInitialState());
    }
  }

  GameInProgressState? _requireInProgress() {
    if (state is GameInProgressState) return state as GameInProgressState;
    if (state is GameCorrectAnswerState) return state as GameCorrectAnswerState;
    if (state is GameWrongAnswerState) return state as GameWrongAnswerState;
    return null;
  }

  void _onWrongAttempt(GameWrongAttemptEvent event, Emitter<GameState> emit) {
    final current = _requireInProgress();
    if (current == null) return;

    emit(
      GameWrongAnswerState(
        content: current.content,
        questionIndex: current.questionIndex,
        score: current.score,
        answeredOptionIndex: event.itemIndex,
      ),
    );
  }

  void _onStepComplete(GameStepCompleteEvent event, Emitter<GameState> emit) {
    final current = _requireInProgress();
    if (current == null) return;

    emit(
      GameCorrectAnswerState(
        content: current.content,
        questionIndex: current.questionIndex,
        score: current.score + 1,
        answeredOptionIndex: 0,
      ),
    );
  }
}
