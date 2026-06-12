import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

class ConnectLettersGame extends StatefulWidget {
  final GameInProgressState gameState;

  const ConnectLettersGame({super.key, required this.gameState});

  @override
  State<ConnectLettersGame> createState() => _ConnectLettersGameState();
}

class _ConnectLettersGameState extends State<ConnectLettersGame> {
  int? _selectedLeft;
  final Map<int, int> _matches = {};
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
    _shuffledRightIndices = List.generate(pairs.length, (i) => i)
      ..shuffle(Random());
    _matches.clear();
    _selectedLeft = null;
    _wrongFlash = false;
  }

  void _tapLeft(int index) {
    if (_matches.containsKey(index)) return;
    setState(() {
      _selectedLeft = index;
      _wrongFlash = false;
    });
  }

  void _tapRight(int displayIndex) {
    if (_selectedLeft == null) return;
    final originalRightIndex = _shuffledRightIndices[displayIndex];

    if (_matches.values.contains(displayIndex)) return;

    if (_selectedLeft == originalRightIndex) {
      setState(() {
        _matches[_selectedLeft!] = displayIndex;
        _selectedLeft = null;
      });
      if (_matches.length == widget.gameState.currentQuestion.pairs.length) {
        context.read<GameBloc>().add(const GameStepCompleteEvent());
      }
    } else {
      setState(() {
        _wrongFlash = true;
        _selectedLeft = null;
      });
      context.read<GameBloc>().add(
        GameWrongAttemptEvent(itemIndex: displayIndex),
      );
      Future.delayed(const Duration(milliseconds: 600), () {
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            'Fill the Missing Letters',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.colors.textPrimary,
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
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 14),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(pairs.length, (i) {
                      final isMatched = _matches.containsKey(i);
                      final isSelected = _selectedLeft == i;
                      final color = _colors[i % _colors.length];

                      final displayText = isMatched
                          ? pairs[i].left.replaceFirst('_', pairs[i].right)
                          : pairs[i].left;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => _tapLeft(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? color.withValues(alpha: 0.12)
                                  : context.colors.cardBackground,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? context.colors.primary
                                    : isMatched
                                    ? color
                                    : context.colors.border,
                                width: isSelected ? 2.5 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? context.colors.primary.withValues(
                                          alpha: 0.2,
                                        )
                                      : Colors.black.withValues(
                                          alpha: context.isDarkMode
                                              ? 0.2
                                              : 0.05,
                                        ),
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
                                          : context.colors.textPrimary,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                if (isMatched)
                                  Icon(
                                    Icons.check_circle_rounded,
                                    color: color,
                                    size: 22,
                                  ),
                                if (isSelected)
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: context.colors.primary,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(width: 14),

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
                          : context.colors.primary;

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
                                ? const Color(0xFFEF5350).withValues(alpha: 0.1)
                                : context.colors.cardBackground,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isMatched
                                  ? color
                                  : _wrongFlash
                                  ? const Color(0xFFEF5350)
                                  : context.colors.border,
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: context.isDarkMode ? 0.2 : 0.06,
                                ),
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
                                    : context.colors.textPrimary,
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
