import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Fullscreen overlay that fires a confetti/star explosion from the center
/// when triggered. Wrap the game screen in a [Stack] and place this on top.
class RewardOverlay extends StatefulWidget {
  /// Called when the overlay has finished its animation (≈ 2 seconds).
  final VoidCallback? onComplete;

  const RewardOverlay({super.key, this.onComplete});

  @override
  State<RewardOverlay> createState() => RewardOverlayState();
}

class RewardOverlayState extends State<RewardOverlay>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Call this to trigger the reward explosion.
  void trigger() {
    setState(() => _visible = true);
    _confettiController.play();
    _scaleController.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() => _visible = false);
        _scaleController.reverse();
        widget.onComplete?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Semi-transparent flash ────────────────────
            Container(color: Colors.white.withOpacity(0.15)),

            // ── Confetti from top-center ──────────────────
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: math.pi / 2, // downward
                emissionFrequency: 0.08,
                numberOfParticles: 25,
                gravity: 0.3,
                colors: const [
                  Color(0xFFF3C344),
                  Color(0xFFE55A54),
                  Color(0xFF65B88D),
                  Color(0xFF3B81B5),
                  Color(0xFF8B59A7),
                ],
                createParticlePath: _starPath,
              ),
            ),

            // ── Central "⭐ Excellent!" badge ─────────────
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF3C344).withOpacity(0.5),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 52)),
                    const SizedBox(height: 8),
                    Text(
                      'Excellent! 🎉',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFE88A34),
                        shadows: [
                          Shadow(
                            color: const Color(0xFFF3C344).withOpacity(0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Draws a simple 5-pointed star path for confetti particles.
  Path _starPath(Size size) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    const points = 5;
    const outerRadius = 8.0;
    const innerRadius = 4.0;

    for (var i = 0; i < points * 2; i++) {
      final angle = (math.pi / points) * i - math.pi / 2;
      final r = i.isEven ? outerRadius : innerRadius;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    return path;
  }
}
