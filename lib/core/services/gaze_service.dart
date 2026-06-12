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

  GazeData({
    required this.x,
    required this.y,
    required this.blink,
    required this.confidence,
  });

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
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("EduFocus GazeService: No cameras available.");
        return;
      }

      final frontCameras = cameras.where(
        (c) => c.lensDirection == CameraLensDirection.front,
      );
      if (frontCameras.isEmpty) {
        print("EduFocus GazeService: No front camera found.");
        return;
      }
      final front = frontCameras.first;

      _camera = CameraController(
        front,
        ResolutionPreset.low,
        enableAudio: false,
      );
      await _camera!.initialize();

      _channel = WebSocketChannel.connect(Uri.parse(serverUrl));

      _channel!.sink.add(
        jsonEncode({
          'type': 'configure',
          'screen_width': screenWidth.toInt(),
          'screen_height': screenHeight.toInt(),
        }),
      );

      _channel!.stream.listen(
        (msg) {
          try {
            final data = GazeData.fromJson(jsonDecode(msg));
            if (data.confidence > 0.5) {
              _gazeController.add(data);
            }
          } catch (e) {
            print("EduFocus error parsing gaze message: $e");
          }
        },
        onError: (error) {
          print("EduFocus WebSocket stream error: $error");
        },
        onDone: () {
          print("EduFocus WebSocket stream closed");
        },
      );

      _isRunning = true;
      _camera!.startImageStream((CameraImage image) async {
        if (!_isRunning) return;
        final jpeg = await _convertToJpeg(image);
        if (jpeg == null) return;
        if (_channel != null) {
          _channel!.sink.add(
            jsonEncode({
              'type': 'frame',
              'data': base64Encode(jpeg),
              'timestamp': DateTime.now().millisecondsSinceEpoch,
            }),
          );
        }
      });
    } catch (e) {
      print("EduFocus GazeService error starting: $e");
      _isRunning = false;
      try {
        _camera?.dispose();
      } catch (_) {}
      _camera = null;
      try {
        _channel?.sink.close();
      } catch (_) {}
      _channel = null;
    }
  }

  Future<Uint8List?> _convertToJpeg(CameraImage image) async {
    try {
      img.Image decoded;
      final plane = image.planes[0];
      final bytes = plane.bytes;

      if (image.format.group == ImageFormatGroup.yuv420) {
        decoded = img.Image.fromBytes(
          width: image.width,
          height: image.height,
          bytes: bytes.buffer,
          rowStride: plane.bytesPerRow,
          bytesOffset: bytes.offsetInBytes,
          format: img.Format.uint8,
          numChannels: 1,
        );
      } else if (image.format.group == ImageFormatGroup.bgra8888) {
        decoded = img.Image.fromBytes(
          width: image.width,
          height: image.height,
          bytes: bytes.buffer,
          rowStride: plane.bytesPerRow,
          bytesOffset: bytes.offsetInBytes,
          format: img.Format.uint8,
          numChannels: 4,
          order: img.ChannelOrder.bgra,
        );
      } else {
        decoded = img.Image.fromBytes(
          width: image.width,
          height: image.height,
          bytes: bytes.buffer,
          rowStride: plane.bytesPerRow,
          bytesOffset: bytes.offsetInBytes,
          format: img.Format.uint8,
          numChannels: 1,
        );
      }

      return Uint8List.fromList(img.encodeJpg(decoded, quality: 75));
    } catch (e) {
      print("EduFocus error converting image: $e");
      return null;
    }
  }

  void stop() {
    _isRunning = false;
    try {
      _camera?.stopImageStream();
    } catch (_) {}
    try {
      _camera?.dispose();
    } catch (_) {}
    _camera = null;
    try {
      _channel?.sink.close();
    } catch (_) {}
    _channel = null;
  }

  void dispose() {
    stop();
    _gazeController.close();
  }
}
