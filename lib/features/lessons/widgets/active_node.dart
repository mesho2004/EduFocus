import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/lessons/widgets/node_label.dart';
import 'package:flutter/material.dart';

class ActiveNode extends StatefulWidget {
  final LessonData lesson;
  final double offset;
  final Color color;
  final VoidCallback onTap;

  const ActiveNode({
    super.key,
    required this.lesson,
    required this.offset,
    required this.color,
    required this.onTap,
  });

  @override
  State<ActiveNode> createState() => _ActiveNodeState();
}

class _ActiveNodeState extends State<ActiveNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scaleAnim = Tween(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.offset, 0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _scaleAnim,
                  builder: (_, __) => Transform.scale(
                    scale: _scaleAnim.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.18),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 4,
                    ),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            NodeLabel(
              text: widget.lesson.title,
              color: widget.color,
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}
