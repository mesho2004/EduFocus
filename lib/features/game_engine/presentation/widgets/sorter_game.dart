import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// "Drag to Sort" game — items are draggable, buckets are drop targets.
///
/// For Primary 1 use-cases each question has exactly ONE correct option;
/// the player drags it to the highlighted bucket.
class SorterGame extends StatefulWidget {
  final GameInProgressState gameState;
  final FlutterTts? tts;
  final Offset? eyeTrackingData;

  const SorterGame({
    super.key,
    required this.gameState,
    this.tts,
    this.eyeTrackingData,
  });
  @override
  State<SorterGame> createState() => _SorterGameState();
}

class _SorterGameState extends State<SorterGame> {
  int? _draggingIndex;
  final Set<int> _sortedIndices = {};
  bool _answered = false;

  @override
  void didUpdateWidget(SorterGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameState.questionIndex != widget.gameState.questionIndex) {
      setState(() {
        _draggingIndex = null;
        _sortedIndices.clear();
        _answered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final options = question.options;

    final List<String> categories = options
        .map((e) => e.category)
        .whereType<String>()
        .toSet()
        .toList();

    final List<String> displayCategories = categories.isNotEmpty
        ? categories
        : const ['✅ Correct', '❌ Wrong'];

    final bucketColors = const [
      Color(0xFF65B88D),
      Color(0xFF5B9BD5),
      Color(0xFFE55A54),
    ];

    return Column(
      children: [
        // ── Question text ────────────────────────────────────────────────────
        if (question.question.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: Text(
                question.question,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1E3A5F)),
              ),
            ),
          ),

        // ── Instruction ─────────────────────────────────────────────────────
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 4),
          child: Text(
            'Drag each item to the correct box!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
          ),
        ),
        const SizedBox(height: 12),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Draggable tokens row
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(options.length, (i) {
                    if (_sortedIndices.contains(i)) {
                      return const SizedBox.shrink();
                    }
                    return _DraggableToken(
                      option: options[i],
                      index: i,
                      onDragStarted: () => setState(() => _draggingIndex = i),
                      onDragEnd: () => setState(() => _draggingIndex = null),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Drop bucket row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: displayCategories.map((catLabel) {
                    final idx = displayCategories.indexOf(catLabel);
                    final color = bucketColors[idx % bucketColors.length];
                    return _DropBucket(
                      label: catLabel,
                      color: color,
                      isDragging: _draggingIndex != null,
                      onAccept: (itemIdx) =>
                          _handleDrop(context, itemIdx, bucketLabel: catLabel),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _handleDrop(
    BuildContext context,
    int itemIndex, {
    required String bucketLabel,
  }) {
    if (_answered) return;

    final option = widget.gameState.currentQuestion.options[itemIndex];
    bool isCorrect = false;
    if (option.category != null) {
      isCorrect = (option.category == bucketLabel);
    } else {
      isCorrect = (option.isCorrect && bucketLabel == '✅ Correct') || 
                  (!option.isCorrect && bucketLabel == '❌ Wrong');
    }

    if (isCorrect) {
      setState(() {
        _sortedIndices.add(itemIndex);
        // If all items placed, emit completion
        if (_sortedIndices.length ==
            widget.gameState.currentQuestion.options.length) {
          _answered = true;
          context.read<GameBloc>().add(const GameStepCompleteEvent());
        }
      });
    } else {
      context.read<GameBloc>().add(GameWrongAttemptEvent(itemIndex: itemIndex));
    }
  }
}


// ─────────────────────────────────────────────
//  Draggable Token
// ─────────────────────────────────────────────

class _DraggableToken extends StatelessWidget {
  final GameOptionData option;
  final int index;
  final VoidCallback onDragStarted;
  final VoidCallback onDragEnd;

  const _DraggableToken({
    required this.option,
    required this.index,
    required this.onDragStarted,
    required this.onDragEnd,
  });

  Widget _buildCard({double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
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
            color: Color(0xFF1E3A5F),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: index,
      onDragStarted: onDragStarted,
      onDragEnd: (_) => onDragEnd(),
      feedback: Material(color: Colors.transparent, child: _buildCard()),
      childWhenDragging: _buildCard(opacity: 0.3),
      child: _buildCard(),
    );
  }
}

// ─────────────────────────────────────────────
//  Drop Bucket
// ─────────────────────────────────────────────

class _DropBucket extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDragging;
  final void Function(int) onAccept;

  const _DropBucket({
    required this.label,
    required this.color,
    required this.isDragging,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 140,
          height: 110,
          decoration: BoxDecoration(
            color: isHovered
                ? color.withValues(alpha: 0.2)
                : color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDragging ? color : const Color(0xFFE2E8F0),
              width: isHovered ? 3 : 2,
            ),
            boxShadow: isHovered
                ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 14)]
                : [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}
