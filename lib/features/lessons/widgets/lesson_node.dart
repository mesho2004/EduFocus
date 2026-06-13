import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/lessons/widgets/active_node.dart';
import 'package:edufocus/features/lessons/widgets/compeletd_node.dart';
import 'package:edufocus/features/lessons/widgets/locked_node.dart';
import 'package:flutter/material.dart';

class LessonNode extends StatelessWidget {
  final LessonData lesson;
  final int index;
  final double offset;
  final SubjectData subject;
  final VoidCallback? onTap;
  final bool isLocked;

  const LessonNode({
    super.key,
    required this.lesson,
    required this.index,
    required this.offset,
    required this.subject,
    this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return LockedNode(
        lesson: lesson,
        offset: offset,
      );
    } else if (lesson.isCompleted) {
      return CompletedNode(
        lesson: lesson,
        offset: offset,
        color: subject.color,
      );
    } else {
      return ActiveNode(
        lesson: lesson,
        offset: offset,
        color: subject.color,
        onTap: onTap!,
      );
    }
  }
}
