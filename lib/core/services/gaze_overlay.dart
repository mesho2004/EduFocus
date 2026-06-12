import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
  bool _wasBlinking = false;

  void _simulateClick(double x, double y) {
    final position = Offset(x, y);
    GestureBinding.instance.handlePointerEvent(
      PointerAddedEvent(pointer: 0, position: position),
    );
    GestureBinding.instance.handlePointerEvent(
      PointerDownEvent(pointer: 0, position: position),
    );
    GestureBinding.instance.handlePointerEvent(
      PointerUpEvent(pointer: 0, position: position),
    );
    GestureBinding.instance.handlePointerEvent(
      PointerRemovedEvent(pointer: 0, position: position),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.gazeService.gazeStream.listen((data) {
      if (data.blink && !_wasBlinking) {
        _simulateClick(data.x, data.y);
      }
      _wasBlinking = data.blink;

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
                  border: Border.all(color: Colors.white, width: 2),
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
