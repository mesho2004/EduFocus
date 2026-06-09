import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class UnitCard extends StatefulWidget {
  final UnitData unit;
  final int index;
  final SubjectData subject;
  final VoidCallback? onTap;

  const UnitCard({super.key, 
    required this.unit,
    required this.index,
    required this.subject,
    this.onTap,
  });

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.unit;
    final subject = widget.subject;
    final locked = false; // OVERRIDE to unlock everything
    final pct = (unit.progress * 100).round();

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: context.colors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: subject.color.withValues(alpha: 0.25),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: subject.color.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // ── Unit number circle ─────────────────
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode ? subject.color.withOpacity(0.15) : subject.colorLight,
                    border: Border.all(
                      color: subject.color.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: subject.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // ── Unit info ──────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Unit label + subtitle
                      Text(
                        unit.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: subject.color,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        unit.subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Lesson progress bar
                      if (!locked) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: LinearProgressIndicator(
                            value: unit.progress,
                            minHeight: 6,
                            backgroundColor: context.colors.border,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              subject.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${unit.completedLessons} / ${unit.lessons.length} درس  ($pct%)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: subject.color.withValues(alpha: 0.8),
                          ),
                        ),
                      ] else
                        // ignore: dead_code
                        Text(
                          '🔒 أكمل الوحدة السابقة أولاً',
                          style: TextStyle(
                            fontSize: 11,
                            color: context.colors.textTertiary,
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Arrow ──────────────────────────────
                if (!locked)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: subject.color.withValues(alpha: 0.5),
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}