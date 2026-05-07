import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// "Tap in Order" game — player must tap tokens in the correct sequence.
/// Each token gets a number badge when tapped correctly.
class SequenceGame extends StatefulWidget {
  final GameInProgressState gameState;

  const SequenceGame({super.key, required this.gameState});

  @override
  State<SequenceGame> createState() => _SequenceGameState();
}

class _SequenceGameState extends State<SequenceGame> {
  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final options = question.options;
    final sequenceSoFar = widget.gameState.sequenceSoFar;
    final answered = widget.gameState is GameCorrectAnswerState ||
        widget.gameState is GameWrongAnswerState;

    return Column(
      children: [
        // ── Question ─────────────────────────────────────
        _SeqQuestionBanner(question: question),
        const SizedBox(height: 16),

        // ── Instruction ──────────────────────────────────
        Text(
          'Tap them in the right order! 👆',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 24),

        // ── Progress indicator ────────────────────────────
        _OrderProgressBar(
          current: sequenceSoFar.length,
          total: options.length,
        ),
        const SizedBox(height: 24),

        // ── Token grid ────────────────────────────────────
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(options.length, (i) {
                  final tapPosition = sequenceSoFar.indexOf(i);
                  final isTapped = tapPosition != -1;
                  return _SequenceToken(
                    option: options[i],
                    index: i,
                    tapPosition: isTapped ? tapPosition + 1 : null,
                    isWrong: answered &&
                        widget.gameState is GameWrongAnswerState &&
                        (widget.gameState as GameWrongAnswerState)
                                .answeredOptionIndex ==
                            i,
                    onTap: answered
                        ? null
                        : () {
                            context
                                .read<GameBloc>()
                                .add(GameSequenceTappedEvent(i));
                          },
                  );
                }),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Question Banner (Sequence)
// ─────────────────────────────────────────────

class _SeqQuestionBanner extends StatelessWidget {
  final GameQuestion question;

  const _SeqQuestionBanner({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07), blurRadius: 10),
        ],
      ),
      child: question.questionIsImage
          ? Image.asset(question.question,
              height: 100, fit: BoxFit.contain)
          : Text(
              question.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0f172a),
              ),
            ),
    );
  }
}

// ─────────────────────────────────────────────
//  Order Progress Bar
// ─────────────────────────────────────────────

class _OrderProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const _OrderProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (i) {
          final done = i < current;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 10,
              decoration: BoxDecoration(
                color: done
                    ? const Color(0xFF65B88D)
                    : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Sequence Token
// ─────────────────────────────────────────────

class _SequenceToken extends StatefulWidget {
  final GameOptionData option;
  final int index;
  final int? tapPosition; // null = not yet tapped
  final bool isWrong;
  final VoidCallback? onTap;

  const _SequenceToken({
    required this.option,
    required this.index,
    required this.tapPosition,
    required this.isWrong,
    this.onTap,
  });

  @override
  State<_SequenceToken> createState() => _SequenceTokenState();
}

class _SequenceTokenState extends State<_SequenceToken>
    with SingleTickerProviderStateMixin {
  late AnimationController _popController;
  late Animation<double> _popAnim;

  @override
  void initState() {
    super.initState();
    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _popAnim = CurvedAnimation(
        parent: _popController, curve: Curves.elasticOut);
  }

  @override
  void didUpdateWidget(_SequenceToken oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tapPosition == null && widget.tapPosition != null) {
      _popController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    super.dispose();
  }

  Color _borderColor() {
    if (widget.isWrong) return const Color(0xFFE55A54);
    if (widget.tapPosition != null) return const Color(0xFF65B88D);
    return Colors.white.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tapPosition == null ? widget.onTap : null,
      child: ScaleTransition(
        scale: widget.tapPosition != null
            ? _popAnim
            : const AlwaysStoppedAnimation(1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: widget.tapPosition != null
                ? const Color(0xFF65B88D).withOpacity(0.25)
                : widget.isWrong
                    ? const Color(0xFFE55A54).withOpacity(0.25)
                    : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _borderColor(), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Main label
              Center(
                child: Text(
                  widget.option.text ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0f172a),
                  ),
                ),
              ),
              // Tap-order badge
              if (widget.tapPosition != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFF65B88D),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${widget.tapPosition}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
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
}
