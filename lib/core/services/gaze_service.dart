import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image/image.dart' as img;

class GazeData {
  final double x, y;
  final bool blink;
  final double confidence;

  GazeData({required this.x, required this.y, 
             required this.blink, required this.confidence});

  factory GazeData.fromJson(Map<String, dynamic> json) => GazeData(
    x: (json['x'] ?? 0).toDouble(),
    y: (json['y'] ?? 0).toDouble(),
    blink: json['blink'] ?? false,
    confidence: (json['confidence'] ?? 0).toDouble(),
  );
}

class GazeService {
  CameraController? _camera;
  WebSocketChannel? _channel;
  final _gazeController = StreamController<GazeData>.broadcast();
  bool _isRunning = false;

  Stream<GazeData> get gazeStream => _gazeController.stream;

  Future<void> start({
    required String serverUrl,
    required double screenWidth,
    required double screenHeight,
  }) async {
    // الكاميرا الأمامية
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );

    _camera = CameraController(front, ResolutionPreset.low, 
                                enableAudio: false);
    await _camera!.initialize();

    // WebSocket
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));

    // إخبار السيرفر بحجم الشاشة
    _channel!.sink.add(jsonEncode({
      'type': 'configure',
      'screen_width': screenWidth.toInt(),
      'screen_height': screenHeight.toInt(),
    }));

    // استقبال الـ gaze data
    _channel!.stream.listen((msg) {
      try {
        final data = GazeData.fromJson(jsonDecode(msg));
        if (data.confidence > 0.5) {
          _gazeController.add(data);
        }
      } catch (_) {}
    });

    // إرسال الـ frames
    _isRunning = true;
    _camera!.startImageStream((CameraImage image) async {
      if (!_isRunning) return;
      final jpeg = await _convertToJpeg(image);
      if (jpeg == null) return;
      _channel!.sink.add(jsonEncode({
        'type': 'frame',
        'data': base64Encode(jpeg),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }));
    });
  }

  Future<Uint8List?> _convertToJpeg(CameraImage image) async {
    try {
      final bytes = image.planes[0].bytes;
      final decoded = img.Image.fromBytes(
        width: image.width,
        height: image.height,
        bytes: bytes.buffer,
        format: img.Format.uint8,
        numChannels: 1,
      );
      return Uint8List.fromList(img.encodeJpg(decoded, quality: 75));
    } catch (_) {
      return null;
    }
  }

  void stop() {
    _isRunning = false;
    _camera?.stopImageStream();
    _camera?.dispose();
    _channel?.sink.close();
  }

  void dispose() {
    stop();
    _gazeController.close();
  }
}