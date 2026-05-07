import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// Popper game — floating bubbles drift across the screen.
/// Tap the correct bubbles to pop them; wrong taps show a shake.
class PopperGame extends StatefulWidget {
  final GameInProgressState gameState;
  final FlutterTts? tts;
  final Offset? eyeTrackingData;

  const PopperGame({
    super.key,
    required this.gameState,
    this.tts,
    this.eyeTrackingData,
  });

  @override
  State<PopperGame> createState() => _PopperGameState();
}

class _PopperGameState extends State<PopperGame> {
  static const double _bubbleSize = 90;
  static const _bubbleColors = [
    Color(0xFFE55A54),
    Color(0xFF3B81B5),
    Color(0xFF65B88D),
    Color(0xFFF3C344),
    Color(0xFF8B59A7),
    Color(0xFFE88A34),
    Color(0xFF4CB1B8),
  ];

  late List<_BubbleData> _bubbles;
  final Set<int> _poppedIndices = {};
  final Set<int> _poppingIndices = {}; // Animating pop
  int? _wrongShakeIndex;
  Timer? _moveTimer;
  double _maxWidth = 300;
  double _maxHeight = 400;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _initBubbles();
    _startMovement();
  }

  @override
  void didUpdateWidget(PopperGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameState.questionIndex !=
        widget.gameState.questionIndex) {
      _moveTimer?.cancel();
      _poppedIndices.clear();
      _poppingIndices.clear();
      _wrongShakeIndex = null;
      _completed = false;
      _initBubbles();
      _startMovement();
    }
  }

  void _initBubbles() {
    final random = Random();
    final options = widget.gameState.currentQuestion.options;
    _bubbles = List.generate(options.length, (i) {
      return _BubbleData(
        x: 30 + random.nextDouble() * 200,
        y: 30 + random.nextDouble() * 200,
        dx: (random.nextDouble() - 0.5) * 1.8,
        dy: (random.nextDouble() - 0.5) * 1.8,
      );
    });
  }

  void _startMovement() {
    _moveTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!mounted) {
        _moveTimer?.cancel();
        return;
      }
      setState(() {
        for (int i = 0; i < _bubbles.length; i++) {
          if (_poppedIndices.contains(i) || _poppingIndices.contains(i)) {
            continue;
          }
          _bubbles[i].x += _bubbles[i].dx;
          _bubbles[i].y += _bubbles[i].dy;

          // Bounce off edges
          if (_bubbles[i].x < 0) {
            _bubbles[i].x = 0;
            _bubbles[i].dx = _bubbles[i].dx.abs();
          }
          if (_bubbles[i].x > _maxWidth - _bubbleSize) {
            _bubbles[i].x = _maxWidth - _bubbleSize;
            _bubbles[i].dx = -_bubbles[i].dx.abs();
          }
          if (_bubbles[i].y < 0) {
            _bubbles[i].y = 0;
            _bubbles[i].dy = _bubbles[i].dy.abs();
          }
          if (_bubbles[i].y > _maxHeight - _bubbleSize) {
            _bubbles[i].y = _maxHeight - _bubbleSize;
            _bubbles[i].dy = -_bubbles[i].dy.abs();
          }
        }
      });
    });
  }

  void _handleTap(int index) {
    if (_poppedIndices.contains(index) ||
        _poppingIndices.contains(index) ||
        _completed) {
      return;
    }

    final option = widget.gameState.currentQuestion.options[index];
    if (option.isCorrect) {
      // Pop it!
      setState(() => _poppingIndices.add(index));
      Future.delayed(const Duration(milliseconds: 350), () {
        if (!mounted) return;
        setState(() {
          _poppingIndices.remove(index);
          _poppedIndices.add(index);
        });
        _checkCompletion();
      });
    } else {
      // Wrong — shake
      setState(() => _wrongShakeIndex = index);
      context
          .read<GameBloc>()
          .add(GameWrongAttemptEvent(itemIndex: index));
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _wrongShakeIndex = null);
      });
    }
  }

  void _checkCompletion() {
    if (_completed) return;
    final options = widget.gameState.currentQuestion.options;
    final correctCount = options.where((o) => o.isCorrect).length;
    final poppedCorrect =
        _poppedIndices.where((i) => options[i].isCorrect).length;
    if (poppedCorrect >= correctCount) {
      _completed = true;
      _moveTimer?.cancel();
      context.read<GameBloc>().add(const GameStepCompleteEvent());
    }
  }

  @override
  void dispose() {
    _moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final options = question.options;

    return Column(
      children: [
        // ── Question banner ─────────────────────────────
        _PopperQuestionBanner(question: question),
        const SizedBox(height: 12),

        Text(
          'Pop the correct bubbles! 🫧',
          style: TextStyle(
            color: const Color(0xFF64748B).withValues(alpha: 0.85),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // ── Bubble area ─────────────────────────────────
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              _maxWidth = constraints.maxWidth;
              _maxHeight = constraints.maxHeight;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < options.length; i++)
                    if (!_poppedIndices.contains(i))
                      Positioned(
                        left: _bubbles[i].x,
                        top: _bubbles[i].y,
                        child: _buildBubble(i, options[i]),
                      ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBubble(int index, GameOptionData option) {
    final isPopping = _poppingIndices.contains(index);
    final isShaking = _wrongShakeIndex == index;
    final color = _bubbleColors[index % _bubbleColors.length];

    Widget bubble = GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        width: _bubbleSize,
        height: _bubbleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.95),
              color.withOpacity(0.6),
            ],
            center: const Alignment(-0.3, -0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isShaking
                ? const Color(0xFFE55A54)
                : Colors.white.withOpacity(0.3),
            width: isShaking ? 3 : 1.5,
          ),
        ),
        child: Center(
          child: Text(
            option.text ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
        ),
      ),
    );

    // Pop animation
    bubble = TweenAnimationBuilder<double>(
      tween: Tween(end: isPopping ? 0.0 : 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInBack,
      builder: (_, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: bubble,
    );

    // Shake animation
    if (isShaking) {
      bubble = TweenAnimationBuilder<double>(
        key: ValueKey('shake_$index'),
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 400),
        builder: (_, t, child) {
          final offset = sin(t * pi * 4) * 6 * (1 - t);
          return Transform.translate(
            offset: Offset(offset, 0),
            child: child,
          );
        },
        child: bubble,
      );
    }

    return bubble;
  }
}

// ─────────────────────────────────────────────
//  Bubble data
// ─────────────────────────────────────────────

class _BubbleData {
  double x;
  double y;
  double dx;
  double dy;

  _BubbleData({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}

// ─────────────────────────────────────────────
//  Question Banner (Popper)
// ─────────────────────────────────────────────

class _PopperQuestionBanner extends StatelessWidget {
  final GameQuestion question;
  const _PopperQuestionBanner({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Text(
        question.question,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1E3A5F), height: 1.4),
      ),
    );
  }
}
