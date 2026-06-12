import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/lesson_content.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

class SelectorGame extends StatefulWidget {
  final GameInProgressState gameState;
  final FlutterTts? tts;
  final Offset? eyeTrackingData;

  const SelectorGame({
    super.key,
    required this.gameState,
    this.tts,
    this.eyeTrackingData,
  });

  @override
  State<SelectorGame> createState() => _SelectorGameState();
}

class _SelectorGameState extends State<SelectorGame>
    with TickerProviderStateMixin {
  int? _selectedIndex;
  bool _answered = false;

  late List<AnimationController> _scaleControllers;
  late List<Animation<double>> _scaleAnims;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    final count = widget.gameState.currentQuestion.options.length;
    _scaleControllers = List.generate(count, (_) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 120),
        lowerBound: 0.94,
        upperBound: 1.0,
        value: 1.0,
      );
    });
    _scaleAnims = _scaleControllers.map((c) => c).toList();
  }

  @override
  void didUpdateWidget(SelectorGame old) {
    super.didUpdateWidget(old);
    if (old.gameState.questionIndex != widget.gameState.questionIndex) {
      for (final c in _scaleControllers) {
        c.dispose();
      }
      setState(() {
        _selectedIndex = null;
        _answered = false;
      });
      _initAnimations();
    }
    if (widget.gameState is GameCorrectAnswerState ||
        widget.gameState is GameWrongAnswerState) {
      _answered = true;
      _selectedIndex =
          (widget.gameState as dynamic).answeredOptionIndex as int?;
    }
  }

  @override
  void dispose() {
    for (final c in _scaleControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    if (_answered) return;
    _scaleControllers[index].reverse().then((_) {
      _scaleControllers[index].forward();
      setState(() {
        _selectedIndex = index;
        _answered = true;
      });
      context.read<GameBloc>().add(GameOptionSelectedEvent(index));
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.gameState.currentQuestion;
    final options = question.options;
    final hasImages = options.any(
      (o) => o.imagePath != null && o.imagePath!.isNotEmpty,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            question.questionIsImage
                ? 'What do you see?'
                : _instructionFor(question),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.colors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),

        if (question.questionIsImage)
          _QuestionImage(path: question.question)
        else
          _CharacterBubble(text: question.question),

        const SizedBox(height: 16),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: hasImages ? 0.95 : 1.6,
              ),
              itemCount: options.length,
              itemBuilder: (context, i) {
                return ScaleTransition(
                  scale: _scaleAnims[i],
                  child: _OptionCard(
                    option: options[i],
                    index: i,
                    selectedIndex: _selectedIndex,
                    answered: _answered,
                    onTap: _answered ? null : _handleTap,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String _instructionFor(GameQuestion q) {
    if (q.question.length < 30) return 'Choose the correct translation';
    return q.question;
  }
}

class _QuestionImage extends StatelessWidget {
  final String path;

  const _QuestionImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 64, color: Colors.grey),
        ),
      ),
    );
  }
}

class _CharacterBubble extends StatelessWidget {
  final String text;

  const _CharacterBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Text('🧠', style: const TextStyle(fontSize: 52)),
              const SizedBox(height: 2),
              Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B59A7).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: context.colors.cardBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF8B59A7).withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatefulWidget {
  final GameOptionData option;
  final int index;
  final int? selectedIndex;
  final bool answered;
  final void Function(int)? onTap;

  const _OptionCard({
    required this.option,
    required this.index,
    required this.selectedIndex,
    required this.answered,
    this.onTap,
  });

  @override
  State<_OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
    ]).animate(_shakeCtrl);
  }

  @override
  void didUpdateWidget(_OptionCard old) {
    super.didUpdateWidget(old);
    if (widget.answered &&
        widget.selectedIndex == widget.index &&
        !widget.option.isCorrect) {
      _shakeCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  Color _bg() {
    if (!widget.answered || widget.selectedIndex != widget.index) {
      return context.colors.cardBackground;
    }
    return widget.option.isCorrect
        ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
        : const Color(0xFFEF5350).withValues(alpha: 0.12);
  }

  Color _border() {
    if (!widget.answered) return context.colors.border;
    if (widget.option.isCorrect) return const Color(0xFF4CAF50);
    if (widget.selectedIndex == widget.index) return const Color(0xFFEF5350);
    return context.colors.border;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (_, child) => Transform.translate(
        offset: Offset(_shakeAnim.value, 0),
        child: child,
      ),
      child: GestureDetector(
        onTap: () => widget.onTap?.call(widget.index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _bg(),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border(), width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.option.imagePath != null &&
                      widget.option.imagePath!.isNotEmpty)
                    Flexible(
                      child: Image.asset(
                        widget.option.imagePath!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (widget.option.text != null &&
                      widget.option.text!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        widget.option.text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: widget.answered && widget.option.isCorrect
                              ? const Color(0xFF4CAF50)
                              : widget.answered &&
                                    widget.selectedIndex == widget.index
                              ? const Color(0xFFEF5350)
                              : context.colors.textPrimary,
                        ),
                      ),
                    ),
                  if (widget.answered && widget.selectedIndex == widget.index)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(
                        widget.option.isCorrect
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: widget.option.isCorrect
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFEF5350),
                        size: 26,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
