import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'package:edufocus/core/themes/app_theme.dart';

/// Matcher game — two columns of items; tap left then right to match pairs.
/// Lines are drawn between matched pairs using [CustomPaint].
class MatcherGame extends StatefulWidget {
  final GameInProgressState gameState;
  final FlutterTts? tts;
  final Offset? eyeTrackingData;

  const MatcherGame({
    super.key,
    required this.gameState,
    this.tts,
    this.eyeTrackingData,
  });

  @override
  State<MatcherGame> createState() => _MatcherGameState();
}

class _MatcherGameState extends State<MatcherGame> {
  int? _selectedLeftIndex;
  final Set<int> _matchedPairIndices = {};
  late List<int> _shuffledRightIndices;
  List<_MatchLineData> _lines = [];
  bool _wrongFlash = false;

  // Keys to compute line positions
  final GlobalKey _stackKey = GlobalKey();
  late List<GlobalKey> _leftKeys;
  late List<GlobalKey> _rightKeys;

  static const _pairColors = [
    Color(0xFF65B88D),
    Color(0xFF5B9BD5),
    Color(0xFFF3C344),
    Color(0xFF8B59A7),
    Color(0xFFE88A34),
    Color(0xFF4CB1B8),
  ];

  @override
  void initState() {
    super.initState();
    _initPairs();
  }

  @override
  void didUpdateWidget(MatcherGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameState.questionIndex !=
        widget.gameState.questionIndex) {
      _initPairs();
    }
  }

  void _initPairs() {
    final pairs = widget.gameState.currentQuestion.pairs;
    _shuffledRightIndices = List<int>.generate(pairs.length, (i) => i)
      ..shuffle(Random());
    _matchedPairIndices.clear();
    _lines.clear();
    _selectedLeftIndex = null;
    _wrongFlash = false;
    _leftKeys = List.generate(pairs.length, (_) => GlobalKey());
    _rightKeys = List.generate(pairs.length, (_) => GlobalKey());
  }

  void _handleLeftTap(int index) {
    if (_matchedPairIndices.contains(index)) return;
    setState(() {
      _selectedLeftIndex = index;
      _wrongFlash = false;
    });
  }

  void _handleRightTap(int rightDisplayIndex) {
    if (_selectedLeftIndex == null) return;
    final rightOriginalIndex = _shuffledRightIndices[rightDisplayIndex];

    if (_matchedPairIndices.contains(rightOriginalIndex)) return;

    if (_selectedLeftIndex == rightOriginalIndex) {
      // ✅ Match!
      setState(() {
        _matchedPairIndices.add(rightOriginalIndex);
        _selectedLeftIndex = null;
      });
      _updateLinePositions();
      _checkCompletion();
    } else {
      // ❌ Wrong
      setState(() {
        _wrongFlash = true;
        _selectedLeftIndex = null;
      });
      context
          .read<GameBloc>()
          .add(GameWrongAttemptEvent(itemIndex: rightDisplayIndex));
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) setState(() => _wrongFlash = false);
      });
    }
  }

  void _updateLinePositions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final stackRB =
          _stackKey.currentContext?.findRenderObject() as RenderBox?;
      if (stackRB == null) return;

      final newLines = <_MatchLineData>[];
      for (final pairIdx in _matchedPairIndices) {
        final rightDispIdx = _shuffledRightIndices.indexOf(pairIdx);
        final leftRB =
            _leftKeys[pairIdx].currentContext?.findRenderObject() as RenderBox?;
        final rightRB = _rightKeys[rightDispIdx].currentContext
            ?.findRenderObject() as RenderBox?;

        if (leftRB != null && rightRB != null) {
          final isRtl = Directionality.of(context) == TextDirection.rtl;

          final from = leftRB.localToGlobal(
            Offset(isRtl ? 0 : leftRB.size.width, leftRB.size.height / 2),
            ancestor: stackRB,
          );
          final to = rightRB.localToGlobal(
            Offset(isRtl ? rightRB.size.width : 0, rightRB.size.height / 2),
            ancestor: stackRB,
          );
          newLines.add(_MatchLineData(
            from: from,
            to: to,
            color: _pairColors[pairIdx % _pairColors.length],
          ));
        }

      }

      if (mounted) setState(() => _lines = newLines);
    });
  }

  void _checkCompletion() {
    final pairs = widget.gameState.currentQuestion.pairs;
    if (_matchedPairIndices.length == pairs.length) {
      context.read<GameBloc>().add(const GameStepCompleteEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final pairs = question.pairs;

    return Column(
      children: [
        // ── Question banner ─────────────────────────────
        _MatcherQuestionBanner(question: question),
        const SizedBox(height: 8),

        Text(
          'Tap left, then tap the matching right item!',
          style: TextStyle(
            color: const Color(0xFF64748B).withValues(alpha: 0.85),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // ── Columns with lines ──────────────────────────
        Expanded(
          child: Stack(
            key: _stackKey,
            children: [
              // Lines layer
              CustomPaint(
                size: Size.infinite,
                painter: _MatchLinePainter(lines: _lines),
              ),

              // Columns
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column
                    Expanded(
                      child: Column(
                        children: List.generate(pairs.length, (i) {
                          final isMatched = _matchedPairIndices.contains(i);
                          final isSelected = _selectedLeftIndex == i;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => _handleLeftTap(i),
                              child: Container(
                                key: _leftKeys[i],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                decoration: BoxDecoration(
                                  color: isMatched
                                      ? _pairColors[i % _pairColors.length]
                                          .withOpacity(0.25)
                                      : context.colors.cardBackground,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF3B81B5)
                                        : isMatched
                                            ? _pairColors[
                                                i % _pairColors.length]
                                            : context.colors.border,
                                    width: isSelected ? 3 : 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pairs[i].left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: isMatched
                                              ? _pairColors[
                                                  i % _pairColors.length]
                                              : context.colors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (isMatched)
                                      Icon(Icons.check_circle_rounded,
                                          color: _pairColors[
                                              i % _pairColors.length],
                                          size: 22),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(width: 40),

                    // Right column
                    Expanded(
                      child: Column(
                        children: List.generate(pairs.length, (displayIdx) {
                          final originalIdx =
                              _shuffledRightIndices[displayIdx];
                          final isMatched =
                              _matchedPairIndices.contains(originalIdx);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => _handleRightTap(displayIdx),
                              child: Container(
                                key: _rightKeys[displayIdx],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                decoration: BoxDecoration(
                                  color: isMatched
                                      ? _pairColors[
                                              originalIdx % _pairColors.length]
                                          .withOpacity(0.25)
                                      : _wrongFlash
                                          ? const Color(0xFFE55A54)
                                              .withOpacity(0.15)
                                          : context.colors.cardBackground,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isMatched
                                        ? _pairColors[
                                            originalIdx % _pairColors.length]
                                        : _wrongFlash
                                            ? const Color(0xFFE55A54)
                                            : context.colors.border,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pairs[originalIdx].right,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: isMatched
                                              ? _pairColors[originalIdx %
                                                  _pairColors.length]
                                              : context.colors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (isMatched)
                                      Icon(Icons.check_circle_rounded,
                                          color: _pairColors[
                                              originalIdx %
                                                  _pairColors.length],
                                          size: 22),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Line data & painter
// ─────────────────────────────────────────────

class _MatchLineData {
  final Offset from;
  final Offset to;
  final Color color;
  const _MatchLineData({
    required this.from,
    required this.to,
    required this.color,
  });
}

class _MatchLinePainter extends CustomPainter {
  final List<_MatchLineData> lines;
  _MatchLinePainter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      final paint = Paint()
        ..color = line.color
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawLine(line.from, line.to, paint);
    }
  }

  @override
  bool shouldRepaint(_MatchLinePainter old) =>
      old.lines.length != lines.length;
}

// ─────────────────────────────────────────────
//  Question Banner (Matcher)
// ─────────────────────────────────────────────

class _MatcherQuestionBanner extends StatelessWidget {
  final GameQuestion question;
  const _MatcherQuestionBanner({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Text(
        question.question,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: context.colors.textPrimary, height: 1.4),
      ),
    );
  }
}
