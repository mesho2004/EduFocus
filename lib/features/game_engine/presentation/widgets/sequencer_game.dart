import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// Sequencer game — empty slots at the top, scrambled items at the bottom.
/// Tap an item to place it into the next available slot.
/// Uses [GameSequenceTappedEvent] for order validation via the GameBloc.
class SequencerGame extends StatefulWidget {
  final GameInProgressState gameState;
  final FlutterTts? tts;
  final Offset? eyeTrackingData;

  const SequencerGame({
    super.key,
    required this.gameState,
    this.tts,
    this.eyeTrackingData,
  });

  @override
  State<SequencerGame> createState() => _SequencerGameState();
}

class _SequencerGameState extends State<SequencerGame> {
  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final options = question.options;
    final placed = widget.gameState.sequenceSoFar;

    return Column(
      children: [
        // ── Question banner ─────────────────────────────
        _QuestionBanner(question: question),
        const SizedBox(height: 24),

        // ── Slots row ───────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(options.length, (slotIndex) {
              final isFilled = slotIndex < placed.length;
              final optionData = isFilled ? options[placed[slotIndex]] : null;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? const Color(0xFF65B88D).withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isFilled
                              ? const Color(0xFF65B88D)
                              : Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: isFilled
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFF65B88D).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: isFilled
                            ? TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.elasticOut,
                                builder: (context, scale, child) =>
                                    Transform.scale(
                                        scale: scale, child: child),
                                child: Text(
                                  optionData?.text ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            : Text(
                                '${slotIndex + 1}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 24),

        // ── Direction hint ──────────────────────────────
        Icon(Icons.arrow_upward_rounded,
            color: const Color(0xFF64748B).withValues(alpha: 0.5), size: 28),
        const SizedBox(height: 4),
        Text(
          'Tap to place!',
          style: TextStyle(
            color: const Color(0xFF64748B).withValues(alpha: 0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // ── Available items ─────────────────────────────
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < options.length; i++)
                    if (!placed.contains(i)) _buildItem(options[i], i),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildItem(GameOptionData option, int index) {
    return GestureDetector(
      onTap: () {
        context.read<GameBloc>().add(GameSequenceTappedEvent(index));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          option.text ?? '',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Question Banner
// ─────────────────────────────────────────────

class _QuestionBanner extends StatelessWidget {
  final GameQuestion question;
  const _QuestionBanner({required this.question});

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
