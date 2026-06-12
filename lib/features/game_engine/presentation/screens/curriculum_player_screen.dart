import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/lesson_content.dart';
import '../../data/services/curriculum_service.dart';
import '../bloc/curriculum_session_cubit.dart';
import '../bloc/curriculum_session_state.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../widgets/dynamic_background.dart';
import '../widgets/selector_game.dart';
import '../widgets/sorter_game.dart';
import '../widgets/sequence_game.dart';
import '../widgets/sequencer_game.dart';
import '../widgets/matcher_game.dart';
import '../widgets/popper_game.dart';
import '../widgets/connect_letters_game.dart';
import 'package:edufocus/core/data/curriculum_data.dart';
import '../../../../core/bloc/stars_cubit.dart';
import '../../../../core/bloc/curriculum_cubit.dart';

class CurriculumPlayerScreen extends StatelessWidget {
  const CurriculumPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectId =
        ModalRoute.of(context)?.settings.arguments as SubjectId? ??
        SubjectId.english;

    return BlocProvider(
      create: (context) =>
          CurriculumSessionCubit(curriculumService: CurriculumService())
            ..loadCurriculum(subjectId),
      child: const _CurriculumPlayerView(),
    );
  }
}

class _CurriculumPlayerView extends StatefulWidget {
  const _CurriculumPlayerView();

  @override
  State<_CurriculumPlayerView> createState() => _CurriculumPlayerViewState();
}

class _CurriculumPlayerViewState extends State<_CurriculumPlayerView> {
  final FlutterTts _tts = FlutterTts();
  bool _ttsReady = false;

  Offset? _eyeTrackingData;

  bool _isAdvancing = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.awaitSpeakCompletion(true);
    setState(() => _ttsReady = true);
  }

  Future<void> _speak(String text, {String langCode = 'en-US'}) async {
    if (!_ttsReady) return;
    await _tts.setLanguage(langCode);
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.1);
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: BlocConsumer<CurriculumSessionCubit, CurriculumSessionState>(
        listener: (context, sessionState) {
          if (sessionState is CurriculumUnitCompleted) {
            _speak(
              'Great job! You finished ${sessionState.completedUnit.title}!',
            );
          }
        },
        builder: (context, sessionState) {
          if (sessionState is CurriculumSessionLoading ||
              sessionState is CurriculumSessionInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (sessionState is CurriculumSessionError) {
            return Center(
              child: Text(
                sessionState.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (sessionState is CurriculumAllUnitsCompleted) {
            return Center(
              child: Text(
                'All Units Conquered! Score: ${sessionState.totalScore}',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            );
          }

          if (sessionState is CurriculumUnitCompleted) {
            return _buildUnitCompletedScreen(context, sessionState);
          }

          if (sessionState is CurriculumSessionLoaded) {
            return _buildLessonScreen(context, sessionState);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLessonScreen(
    BuildContext context,
    CurriculumSessionLoaded sessionState,
  ) {
    final lesson = sessionState.currentLesson;
    final theme = lesson.theme;

    return Directionality(
      textDirection: lesson.isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: DynamicBackground(
        theme: theme,
        child: SafeArea(
          child: Column(
            children: [
              _CurriculumTopBar(sessionState: sessionState),
              const SizedBox(height: 8),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastOutSlowIn,
                                ),
                              ),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },

                  child: KeyedSubtree(
                    key: ValueKey(
                      '${sessionState.currentUnitIndex}_${sessionState.currentLessonIndex}',
                    ),
                    child: BlocProvider(
                      create: (_) => GameBloc()..add(GameLoadEvent(lesson)),
                      child: BlocConsumer<GameBloc, GameState>(
                        listener: (context, gameState) {
                          if (gameState is GameCorrectAnswerState &&
                              !_isAdvancing) {
                            _isAdvancing = true;

                            _speak(
                              'Excellent! Well done!',
                              langCode: lesson.ttsLanguage,
                            );

                            Future.delayed(
                              const Duration(milliseconds: 1500),
                              () {
                                if (mounted) {
                                  _isAdvancing = false;
                                  if (lesson.rawSubjectType != null &&
                                      lesson.unitId != null &&
                                      lesson.lessonIndex != null) {
                                    context
                                        .read<CurriculumCubit>()
                                        .completeLesson(
                                          subjectType: lesson.rawSubjectType!,
                                          unitId: lesson.unitId!,
                                          lessonIndex: lesson.lessonIndex!,
                                          grade: lesson.grade,
                                          term: lesson.term,
                                        );
                                  }
                                  context
                                      .read<CurriculumSessionCubit>()
                                      .nextLesson();
                                }
                              },
                            );
                          } else if (gameState is GameWrongAnswerState) {
                            _speak('Try again!', langCode: lesson.ttsLanguage);
                          } else if (gameState is GameInProgressState &&
                              gameState is! GameCorrectAnswerState &&
                              gameState is! GameWrongAnswerState) {
                            _speak(
                              gameState.currentQuestion.question,
                              langCode: lesson.ttsLanguage,
                            );
                          }
                        },
                        builder: (context, gameState) {
                          if (gameState is GameInProgressState) {
                            return _buildTemplate(lesson, gameState);
                          }

                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplate(LessonContent lesson, GameInProgressState gameState) {
    switch (lesson.gameTemplate) {
      case GameTemplate.selector:
        return SelectorGame(
          gameState: gameState,
          tts: _tts,
          eyeTrackingData: _eyeTrackingData,
        );
      case GameTemplate.sorter:
        return SorterGame(
          gameState: gameState,
          tts: _tts,
          eyeTrackingData: _eyeTrackingData,
        );
      case GameTemplate.sequence:
        return SequenceGame(gameState: gameState);
      case GameTemplate.sequencer:
        return SequencerGame(
          gameState: gameState,
          tts: _tts,
          eyeTrackingData: _eyeTrackingData,
        );
      case GameTemplate.matcher:
        return MatcherGame(
          gameState: gameState,
          tts: _tts,
          eyeTrackingData: _eyeTrackingData,
        );
      case GameTemplate.popper:
        return PopperGame(
          gameState: gameState,
          tts: _tts,
          eyeTrackingData: _eyeTrackingData,
        );
      case GameTemplate.connectLetters:
        return ConnectLettersGame(gameState: gameState);
    }
  }

  Widget _buildUnitCompletedScreen(
    BuildContext context,
    CurriculumUnitCompleted sessionState,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_touohxv0.json',
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.emoji_events_rounded,
                    color: Color(0xFFF3C344),
                    size: 150,
                  ),
                ),
              ),
            ),
            Text(
              '${sessionState.completedUnit.title} Completed!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Amazing progress!\nTotal Score: ${sessionState.score}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: () {
                context.read<CurriculumSessionCubit>().continueToNextUnit();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF65B88D),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF65B88D).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next Unit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CurriculumTopBar extends StatelessWidget {
  final CurriculumSessionLoaded sessionState;

  const _CurriculumTopBar({required this.sessionState});

  @override
  Widget build(BuildContext context) {
    final unit = sessionState.currentUnit;
    final totalL = unit.lessons.length;
    final currentL = sessionState.currentLessonIndex + 1;
    final progress = totalL > 0 ? currentL / totalL : 0.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unit.title,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      sessionState.currentLesson.lessonTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3C344),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text('🪙', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    BlocBuilder<StarsCubit, int>(
                      builder: (context, stars) {
                        return Text(
                          '$stars',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Lesson $currentL / $totalL',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF65B88D),
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
