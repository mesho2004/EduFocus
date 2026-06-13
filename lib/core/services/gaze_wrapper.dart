import 'package:flutter/material.dart';
import 'gaze_service.dart';
import 'gaze_overlay.dart';
import 'package:edufocus/main.dart';

class GazeWrapper extends StatefulWidget {
  final Widget child;
  const GazeWrapper({super.key, required this.child});

  @override
  State<GazeWrapper> createState() => _GazeWrapperState();
}

class _GazeWrapperState extends State<GazeWrapper> with WidgetsBindingObserver {
  final _gazeService = GazeService();
  bool _isServiceRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    isEyeTrackingEnabled.addListener(_onEyeTrackingChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndStartGaze();
    });
  }

  void _onEyeTrackingChanged() {
    _checkAndStartGaze();
    if (mounted) {
      setState(() {});
    }
  }

  void _checkAndStartGaze() {
    if (isEyeTrackingEnabled.value) {
      if (!_isServiceRunning) {
        _startGaze();
        _isServiceRunning = true;
      }
    } else {
      if (_isServiceRunning) {
        _gazeService.stop();
        _isServiceRunning = false;
      }
    }
  }

  void _startGaze() {
    final size = MediaQuery.of(context).size;
    _gazeService.start(
      serverUrl: 'ws://192.168.1.82:8000/ws/gaze/client1',
      screenWidth: size.width,
      screenHeight: size.height,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isEyeTrackingEnabled.value) {
        _startGaze();
        _isServiceRunning = true;
      }
    } else if (state == AppLifecycleState.paused) {
      _gazeService.stop();
      _isServiceRunning = false;
    }
  }

  @override
  void dispose() {
    isEyeTrackingEnabled.removeListener(_onEyeTrackingChanged);
    WidgetsBinding.instance.removeObserver(this);
    _gazeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isEyeTrackingEnabled.value) {
      return widget.child;
    }
    return GazeOverlay(gazeService: _gazeService, child: widget.child);
  }
}
