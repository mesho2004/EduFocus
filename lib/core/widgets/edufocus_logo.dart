import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';

class EduFocusLogo extends StatefulWidget {
  final double fontSize;

  final bool animate;

  const EduFocusLogo({super.key, this.fontSize = 48, this.animate = true});

  @override
  State<EduFocusLogo> createState() => _EduFocusLogoState();
}

class _EduFocusLogoState extends State<EduFocusLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  static const _letters = [
    ('E', AppColors.brandRed),
    ('D', AppColors.brandGreen),
    ('U', AppColors.brandYellow),
    ('F', AppColors.brandCyan),
    ('O', AppColors.brandBlue),
    ('C', AppColors.brandRed),
    ('U', AppColors.brandBlue),
    ('S', AppColors.brandOrange),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.animate) _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < _letters.length; i++)
          _AnimatedLetter(
            letter: _letters[i].$1,
            color: _letters[i].$2,
            index: i,
            controller: _ctrl,
            fontSize: widget.fontSize,
            animate: widget.animate,
          ),
      ],
    );
  }
}

class _AnimatedLetter extends StatelessWidget {
  final String letter;
  final Color color;
  final int index;
  final AnimationController controller;
  final double fontSize;
  final bool animate;

  const _AnimatedLetter({
    required this.letter,
    required this.color,
    required this.index,
    required this.controller,
    required this.fontSize,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    final letterWidget = Text(
      letter,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Lexend',
        color: color,
      ),
    );

    if (!animate) return letterWidget;

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        final t = controller.value * 2 * math.pi;
        final waveOffset = index * (math.pi / 4);
        final jump = math.sin(t - waveOffset);
        final yOffset = jump > 0 ? -jump * 20.0 : 0.0;
        return Transform.translate(offset: Offset(0, yOffset), child: child);
      },
      child: letterWidget,
    );
  }
}
