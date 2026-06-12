import 'package:flutter/material.dart';

class PathLinePainter extends CustomPainter {
  final Color color;

  const PathLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(size.width / 2, 0);

    for (double i = 0; i <= size.height; i += 100) {
      path.quadraticBezierTo(
        size.width / 2 + (i % 200 == 0 ? 50 : -50),
        i + 50,
        size.width / 2,
        i + 100,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
