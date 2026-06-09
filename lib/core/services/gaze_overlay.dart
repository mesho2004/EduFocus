import 'package:flutter/material.dart';
import 'gaze_service.dart';

class GazeOverlay extends StatefulWidget {
  final Widget child;
  final GazeService gazeService;

  const GazeOverlay({
    super.key,
    required this.child,
    required this.gazeService,
  });

  @override
  State<GazeOverlay> createState() => _GazeOverlayState();
}

class _GazeOverlayState extends State<GazeOverlay> {
  double _x = 0, _y = 0;
  bool _blink = false;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.gazeService.gazeStream.listen((data) {
      setState(() {
        _x = data.x;
        _y = data.y;
        _blink = data.blink;
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_visible)
          Positioned(
            left: _x - 20,
            top: _y - 20,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 80),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _blink
                      ? Colors.red.withOpacity(0.6)
                      : Colors.yellow.withOpacity(0.5),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}