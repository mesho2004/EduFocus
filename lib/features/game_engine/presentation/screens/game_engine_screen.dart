import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import '../widgets/connect_letters_game.dart';
import '../widgets/feedback_bar.dart';
import '../widgets/reward_overlay.dart';
import '../widgets/selector_game.dart';
import '../widgets/sorter_game.dart';
import '../widgets/sequence_game.dart';
import '../widgets/sequencer_game.dart';
import '../widgets/matcher_game.dart';
import '../widgets/popper_game.dart';

import 'package:edufocus/core/bloc/curriculum_cubit.dart';

// ─────────────────────────────────────────────────────────────────────────────
// GameEngineScreen  –  Universal game shell
// ─────────────────────────────────────────────────────────────────────────────
class GameEngineScreen extends StatefulWidget {
  final LessonContent? lesson;

  const GameEngineScreen({super.key, this.lesson});

  @override
  State<GameEngineScreen> createState() => _GameEngineScreenState();
}

class _GameEngineScreenState extends State<GameEngineScreen> {
  final FlutterTts _tts = FlutterTts();
  bool _ttsReady = false;
  final GlobalKey<RewardOverlayState> _rewardKey =
      GlobalKey<RewardOverlayState>();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.awaitSpeakCompletion(true);
    setState(() => _ttsReady = true);
  }

  Future<void> _speak(String text, String lang) async {
    if (!_ttsReady) return;
    await _tts.setLanguage(lang);
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.1);
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  //  Build
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final LessonContent? injectedLesson =
        widget.lesson ??
        (ModalRoute.of(context)?.settings.arguments as LessonContent?);

    return BlocProvider(
      create: (_) {
        final bloc = GameBloc();
        if (injectedLesson != null) bloc.add(GameLoadEvent(injectedLesson));
        return bloc;
      },
      child: BlocConsumer<GameBloc, GameState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final lesson = _lessonFromState(state) ?? injectedLesson;
          if (lesson == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Directionality(
            textDirection: lesson.isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: context.colors.background,
              body: SafeArea(
                child: Stack(
                  children: [
                    // ── Subtle decorative blobs ───────────────────────
                    _BackgroundBlobs(),

                    // ── Main column ───────────────────────────────────
                    Column(
                      children: [
                        // Top bar
                        _TopBar(
                          state: state,
                          lesson: lesson,
                          onBack: () => Navigator.pop(context),
                        ),

                        // Game body
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, anim) => FadeTransition(
                              opacity: anim,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.04),
                                  end: Offset.zero,
                                ).animate(anim),
                                child: child,
                              ),
                            ),
                            child: _buildGameBody(state),
                          ),
                        ),

                        // Feedback bar (slides in after answer)
                        if (state is GameCorrectAnswerState ||
                            state is GameWrongAnswerState)
                          FeedbackBar(
                            key: ValueKey(
                              'fb_${(state as GameInProgressState).questionIndex}_${state is GameCorrectAnswerState}',
                            ),
                            isCorrect: state is GameCorrectAnswerState,
                            correctAnswerText: state is GameWrongAnswerState
                                ? _correctAnswerLabel(state)
                                : null,
                            onNext: () {
                              context.read<GameBloc>().add(
                                const GameNextQuestionEvent(),
                              );
                            },
                          ),
                      ],
                    ),

                    // ── Reward confetti overlay ───────────────────────
                    if (state is GameCorrectAnswerState ||
                        state is GameCompletedState)
                      RewardOverlay(key: _rewardKey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Game body switcher
  // ─────────────────────────────────────────────

  Widget _buildGameBody(GameState state) {
    if (state is GameCompletedState) {
      return _CompletedPanel(state: state);
    }

    if (state is GameInProgressState) {
      switch (state.content.gameTemplate) {
        case GameTemplate.selector:
          return SelectorGame(
            key: ValueKey('sel_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.sorter:
          return SorterGame(
            key: ValueKey('sort_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.sequence:
          return SequenceGame(
            key: ValueKey('seq_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.sequencer:
          return SequencerGame(
            key: ValueKey('seqr_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.matcher:
          return MatcherGame(
            key: ValueKey('match_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.popper:
          return PopperGame(
            key: ValueKey('pop_${state.questionIndex}'),
            gameState: state,
          );
        case GameTemplate.connectLetters:
          return ConnectLettersGame(
            key: ValueKey('conn_${state.questionIndex}'),
            gameState: state,
          );
      }
    }

    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF3B81B5)),
    );
  }

  // ─────────────────────────────────────────────
  //  Listener
  // ─────────────────────────────────────────────

  void _onStateChanged(BuildContext context, GameState state) {
    final lesson = _lessonFromState(state);

    if (state is GameCorrectAnswerState) {
      _rewardKey.currentState?.trigger();
      _speak(
        _praiseInLang(lesson?.ttsLanguage ?? 'en-US'),
        lesson?.ttsLanguage ?? 'en-US',
      );
    } else if (state is GameWrongAnswerState) {
      _speak(
        _tryAgainInLang(lesson?.ttsLanguage ?? 'en-US'),
        lesson?.ttsLanguage ?? 'en-US',
      );
    } else if (state is GameInProgressState &&
        state is! GameCorrectAnswerState &&
        state is! GameWrongAnswerState) {
      _speak(state.currentQuestion.question, lesson?.ttsLanguage ?? 'en-US');
    } else if (state is GameCompletedState) {
      _rewardKey.currentState?.trigger();
      _speak(
        _completedInLang(lesson?.ttsLanguage ?? 'en-US', state.stars),
        lesson?.ttsLanguage ?? 'en-US',
      );
      if (lesson != null &&
          lesson.rawSubjectType != null &&
          lesson.unitId != null &&
          lesson.lessonIndex != null) {
        context.read<CurriculumCubit>().completeLesson(
          subjectType: lesson.rawSubjectType!,
          unitId: lesson.unitId!,
          lessonIndex: lesson.lessonIndex!,
        );
      }
    }
  }

  // ─────────────────────────────────────────────
  //  Helpers
  // ─────────────────────────────────────────────

  LessonContent? _lessonFromState(GameState state) {
    if (state is GameInProgressState) return state.content;
    if (state is GameCompletedState) return state.content;
    return null;
  }

  String _correctAnswerLabel(GameWrongAnswerState state) {
    final correct = state.currentQuestion.options.where((o) => o.isCorrect);
    if (correct.isEmpty) return '';
    return correct
        .map((o) => o.text ?? '')
        .where((t) => t.isNotEmpty)
        .join(', ');
  }

  String _praiseInLang(String lang) =>
      lang.startsWith('ar') ? 'أحسنت! إجابة صحيحة!' : 'Excellent! Well done!';

  String _tryAgainInLang(String lang) =>
      lang.startsWith('ar') ? 'حاول مرة أخرى!' : 'Try again! You can do it!';

  String _completedInLang(String lang, int stars) {
    if (lang.startsWith('ar')) {
      return 'رائع! أنهيت الدرس وحصلت على $stars نجوم!';
    }
    return 'Amazing! You finished the lesson with $stars stars!';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _BackgroundBlobs  –  soft decorative pastel circles
// ─────────────────────────────────────────────────────────────────────────────
class _BackgroundBlobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.isDarkMode) return const SizedBox.shrink();
    final size = MediaQuery.sizeOf(context);
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: _blob(180, const Color(0xFFB3E5FC)),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: _blob(220, const Color(0xFFC8E6C9)),
          ),
          Positioned(
            top: size.height * 0.38,
            right: -40,
            child: _blob(130, const Color(0xFFFFE0B2)),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.45),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _TopBar  –  back button + progress bar + score badge
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final GameState state;
  final LessonContent lesson;
  final VoidCallback onBack;

  const _TopBar({
    required this.state,
    required this.lesson,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    int currentQ = 0;
    int totalQ = 1;
    int score = 0;

    if (state is GameInProgressState) {
      final s = state as GameInProgressState;
      currentQ = s.questionIndex;
      totalQ = s.totalQuestions;
      score = s.score;
    } else if (state is GameCompletedState) {
      final s = state as GameCompletedState;
      currentQ = s.totalQuestions;
      totalQ = s.totalQuestions;
      score = s.score;
    }

    final progress = totalQ > 0 ? currentQ / totalQ : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          _CircleIconBtn(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack,
            color: const Color(0xFF3B81B5),
          ),
          const SizedBox(width: 12),

          // Progress bar (pill)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.lessonTitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Stack(
                  children: [
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                          ),
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4CAF50,
                              ).withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Score badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3C344),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF3C344).withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Text(
                  '$score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _CircleIconBtn
// ─────────────────────────────────────────────────────────────────────────────
class _CircleIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _CircleIconBtn({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _CompletedPanel  –  trophy screen with stars
// ─────────────────────────────────────────────────────────────────────────────
class _CompletedPanel extends StatelessWidget {
  final GameCompletedState state;

  const _CompletedPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final stars = state.stars;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: context.colors.cardBackground,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 12),
              Text(
                'Lesson Complete!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Score: ${state.score} / ${state.totalQuestions}',
                style: TextStyle(
                  fontSize: 16,
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.star_rounded,
                      size: 52,
                      color: i < stars
                          ? const Color(0xFFF3C344)
                          : const Color(0xFFE2E8F0),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              _GreenButton(
                label: '🔄  Play Again',
                onTap: () =>
                    context.read<GameBloc>().add(const GameResetEvent()),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Back to Lessons →',
                  style: TextStyle(
                    color: Color(0xFF3B81B5),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GreenButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
