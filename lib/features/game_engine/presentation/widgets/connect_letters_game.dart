import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ConnectLettersGame  (Type A)
//
// A two-column matching UI:
//   Left  column — word items with a missing letter placeholder (e.g. "C_t")
//   Right column — shuffled individual letter choices
//
// The player taps a left item first (highlights it blue), then taps the
// letter they believe fills the blank. If correct → the pair is highlighted
// green and locked. If wrong → brief red flash.
//
// JSON shape expected:
//   gameTemplate: "matcher"       ← reuse the existing matcher template
//   question.pairs: [
//     { "left": "C_t", "right": "a" },   // letter to fill
//     { "left": "D_g", "right": "o" },
//     ...
//   ]
// ─────────────────────────────────────────────────────────────────────────────
class ConnectLettersGame extends StatefulWidget {
  final GameInProgressState gameState;

  const ConnectLettersGame({
    super.key,
    required this.gameState,
  });

  @override
  State<ConnectLettersGame> createState() => _ConnectLettersGameState();
}

class _ConnectLettersGameState extends State<ConnectLettersGame> {
  int? _selectedLeft; // index of the currently selected word
  final Map<int, int> _matches = {}; // leftIndex → rightDisplayIndex
  late List<int> _shuffledRightIndices;
  bool _wrongFlash = false;

  static const _colors = [
    Color(0xFF4CAF50),
    Color(0xFF3B81B5),
    Color(0xFFE88A34),
    Color(0xFF8B59A7),
    Color(0xFF4CB1B8),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(ConnectLettersGame old) {
    super.didUpdateWidget(old);
    if (old.gameState.questionIndex != widget.gameState.questionIndex) {
      _init();
    }
  }

  void _init() {
    final pairs = widget.gameState.currentQuestion.pairs;
    _shuffledRightIndices =
        List.generate(pairs.length, (i) => i)..shuffle(Random());
    _matches.clear();
    _selectedLeft = null;
    _wrongFlash = false;
  }

  void _tapLeft(int index) {
    if (_matches.containsKey(index)) return; // already matched
    setState(() {
      _selectedLeft = index;
      _wrongFlash = false;
    });
  }

  void _tapRight(int displayIndex) {
    if (_selectedLeft == null) return;
    final originalRightIndex = _shuffledRightIndices[displayIndex];

    // Already matched right item?
    if (_matches.values.contains(displayIndex)) return;

    if (_selectedLeft == originalRightIndex) {
      // ✅ Correct match
      setState(() {
        _matches[_selectedLeft!] = displayIndex;
        _selectedLeft = null;
      });
      if (_matches.length == widget.gameState.currentQuestion.pairs.length) {
        context.read<GameBloc>().add(const GameStepCompleteEvent());
      }
    } else {
      // ❌ Wrong
      setState(() {
        _wrongFlash = true;
        _selectedLeft = null;
      });
      context
          .read<GameBloc>()
          .add(GameWrongAttemptEvent(itemIndex: displayIndex));
      Future.delayed(const Duration(milliseconds: 600),
          () {
        if (mounted) setState(() => _wrongFlash = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final pairs = question.pairs;

    return Column(
      children: [
        // ── Instruction ─────────────────────────────────
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            'Fill the Missing Letters',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E3A5F),
            ),
          ),
        ),
        const SizedBox(height: 6),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Tap a word, then tap the correct letter 👆',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF64748B).withValues(alpha: 0.85),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── Two columns ─────────────────────────────────
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: word items
                Expanded(
                  child: Column(
                    children: List.generate(pairs.length, (i) {
                      final isMatched = _matches.containsKey(i);
                      final isSelected = _selectedLeft == i;
                      final color = _colors[i % _colors.length];
                      // Show the completed word when matched
                      final displayText = isMatched
                          ? pairs[i].left.replaceFirst(
                              '_', pairs[i].right)
                          : pairs[i].left;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => _tapLeft(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 16),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? color.withValues(alpha: 0.12)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF3B81B5)
                                    : isMatched
                                        ? color
                                        : const Color(0xFFE2E8F0),
                                width: isSelected ? 2.5 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? const Color(0xFF3B81B5)
                                          .withValues(alpha: 0.2)
                                      : Colors.black.withValues(alpha: 0.05),
                                  blurRadius: isSelected ? 10 : 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    displayText,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: isMatched
                                          ? color
                                          : const Color(0xFF1E3A5F),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                if (isMatched)
                                  Icon(Icons.check_circle_rounded,
                                      color: color, size: 22),
                                if (isSelected)
                                  const Icon(Icons.arrow_forward_rounded,
                                      color: Color(0xFF3B81B5), size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(width: 14),

                // Right: letter tiles (shuffled)
                Expanded(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: List.generate(pairs.length, (displayIdx) {
                      final originalIdx = _shuffledRightIndices[displayIdx];
                      final isMatched = _matches.values.contains(displayIdx);
                      final matchedLeftIdx = _matches.entries
                          .where((e) => e.value == displayIdx)
                          .map((e) => e.key)
                          .firstOrNull;
                      final color = matchedLeftIdx != null
                          ? _colors[matchedLeftIdx % _colors.length]
                          : const Color(0xFF3B81B5);

                      return GestureDetector(
                        onTap: () => _tapRight(displayIdx),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isMatched
                                ? color.withValues(alpha: 0.15)
                                : _wrongFlash
                                    ? const Color(0xFFEF5350)
                                        .withValues(alpha: 0.1)
                                    : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isMatched
                                  ? color
                                  : _wrongFlash
                                      ? const Color(0xFFEF5350)
                                      : const Color(0xFFE2E8F0),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              pairs[originalIdx].right,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: isMatched
                                    ? color
                                    : const Color(0xFF1E3A5F),
                              ),
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
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
