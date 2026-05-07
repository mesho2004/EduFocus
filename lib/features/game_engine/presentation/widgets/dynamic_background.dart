import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/models/lesson_content.dart';

/// Renders a fullscreen animated background that matches the lesson theme.
class DynamicBackground extends StatefulWidget {
  final GameTheme theme;
  final Widget child;

  const DynamicBackground({
    super.key,
    required this.theme,
    required this.child,
  });

  @override
  State<DynamicBackground> createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _twinkleController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Gradient background ───────────────────────────
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: _gradientFor(widget.theme),
            ),
          ),
        ),

        // ── Decorative floating elements ─────────────────
        ..._buildFloatingElements(widget.theme),

        // ── Content ──────────────────────────────────────
        Positioned.fill(child: widget.child),
      ],
    );
  }

  LinearGradient _gradientFor(GameTheme theme) {
    switch (theme) {
      case GameTheme.beach:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFF98D8C8), Color(0xFFFFE0A3)],
          stops: [0.0, 0.6, 1.0],
        );
      case GameTheme.jungle:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
          stops: [0.0, 0.5, 1.0],
        );
      case GameTheme.space:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D0630), Color(0xFF1A1060), Color(0xFF0D47A1)],
          stops: [0.0, 0.6, 1.0],
        );
    }
  }

  List<Widget> _buildFloatingElements(GameTheme theme) {
    switch (theme) {
      case GameTheme.beach:
        return _buildBeachElements();
      case GameTheme.jungle:
        return _buildJungleElements();
      case GameTheme.space:
        return _buildSpaceElements();
    }
  }

  List<Widget> _buildBeachElements() {
    final emojis = ['🌴', '🌊', '⭐', '🐚', '☀️'];
    return List.generate(emojis.length, (i) {
      final x = (i + 1) / (emojis.length + 1);
      return AnimatedBuilder(
        animation: _floatController,
        builder: (context, _) {
          final offset = math.sin(_floatController.value * math.pi * 2 + i) * 8;
          return Positioned(
            left: MediaQuery.of(context).size.width * x - 20,
            top: 40 + i * 60.0 + offset,
            child: Opacity(
              opacity: 0.35,
              child: Text(emojis[i], style: const TextStyle(fontSize: 36)),
            ),
          );
        },
      );
    });
  }

  List<Widget> _buildJungleElements() {
    final emojis = ['🌿', '🍃', '🌺', '🦋', '🌱'];
    return List.generate(emojis.length, (i) {
      final x = (i + 1) / (emojis.length + 1);
      return AnimatedBuilder(
        animation: _floatController,
        builder: (context, _) {
          final offset = math.sin(_floatController.value * math.pi * 2 + i * 0.7) * 10;
          return Positioned(
            left: MediaQuery.of(context).size.width * x - 20,
            top: 30 + i * 70.0 + offset,
            child: Opacity(
              opacity: 0.4,
              child: Text(emojis[i], style: const TextStyle(fontSize: 32)),
            ),
          );
        },
      );
    });
  }

  List<Widget> _buildSpaceElements() {
    final rng = math.Random(42);
    return List.generate(20, (i) {
      final x = rng.nextDouble();
      final y = rng.nextDouble();
      final size = rng.nextDouble() * 4 + 2;
      return AnimatedBuilder(
        animation: _twinkleController,
        builder: (context, _) {
          final opacity = 0.3 + 0.7 * math.sin(_twinkleController.value * math.pi + i);
          return Positioned(
            left: MediaQuery.of(context).size.width * x,
            top: MediaQuery.of(context).size.height * y,
            child: Opacity(
              opacity: opacity.clamp(0.0, 1.0),
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
