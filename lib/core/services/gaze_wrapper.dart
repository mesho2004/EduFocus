import 'package:flutter/material.dart';
import 'gaze_service.dart';
import 'gaze_overlay.dart';

class GazeWrapper extends StatefulWidget {
  final Widget child;
  const GazeWrapper({super.key, required this.child});

  @override
  State<GazeWrapper> createState() => _GazeWrapperState();
}

class _GazeWrapperState extends State<GazeWrapper>
    with WidgetsBindingObserver {
  final _gazeService = GazeService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGaze();
    });
  }

  void _startGaze() {
    final size = MediaQuery.of(context).size;
    _gazeService.start(
      serverUrl: 'ws://192.168.1.13:8000/ws/gaze/client1',
      screenWidth: size.width,
      screenHeight: size.height,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startGaze();
    } else if (state == AppLifecycleState.paused) {
      _gazeService.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _gazeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GazeOverlay(
      gazeService: _gazeService,
      child: widget.child,
    );
  }
}