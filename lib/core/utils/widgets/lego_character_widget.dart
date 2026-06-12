import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';

class LegoCharacterWidget extends StatefulWidget {
  final int headIndex;
  final int hairIndex;
  final int bodyIndex;
  final int legIndex;
  final int hatIndex;
  final double size;

  const LegoCharacterWidget({
    super.key,
    required this.headIndex,
    required this.hairIndex,
    required this.bodyIndex,
    required this.legIndex,
    required this.hatIndex,
    required this.size,
  });

  @override
  State<LegoCharacterWidget> createState() => _LegoCharacterWidgetState();
}

class _LegoCharacterWidgetState extends State<LegoCharacterWidget> {
  late Future<List<Uint8List>> _layersFuture;

  @override
  void initState() {
    super.initState();
    _layersFuture = LegoCharacterHelper.getCharacterLayers(
      headIndex: widget.headIndex,
      hairIndex: widget.hairIndex,
      bodyIndex: widget.bodyIndex,
      legIndex: widget.legIndex,
      hatIndex: widget.hatIndex,
    );
  }

  @override
  void didUpdateWidget(LegoCharacterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.headIndex != widget.headIndex ||
        oldWidget.hairIndex != widget.hairIndex ||
        oldWidget.bodyIndex != widget.bodyIndex ||
        oldWidget.legIndex != widget.legIndex ||
        oldWidget.hatIndex != widget.hatIndex) {
      _layersFuture = LegoCharacterHelper.getCharacterLayers(
        headIndex: widget.headIndex,
        hairIndex: widget.hairIndex,
        bodyIndex: widget.bodyIndex,
        legIndex: widget.legIndex,
        hatIndex: widget.hatIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.size / 91.0;
    final height = widget.size * (173.0 / 91.0);

    return FutureBuilder<List<Uint8List>>(
      future: _layersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: widget.size,
            height: height,
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            ),
          );
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.length < 5) {
          return SizedBox(
            width: widget.size,
            height: height,
            child: const Center(
              child: Icon(Icons.error_outline, color: Colors.red),
            ),
          );
        }

        final layers = snapshot.data!;

        return SizedBox(
          width: widget.size,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 1.0 * scale,
                top: 83.0 * scale,
                width: 90.0 * scale,
                height: 90.0 * scale,
                child: Image.memory(layers[0], fit: BoxFit.contain),
              ),

              Positioned(
                left: 1.0 * scale,
                top: 38.0 * scale,
                width: 90.0 * scale,
                height: 90.0 * scale,
                child: Image.memory(layers[1], fit: BoxFit.contain),
              ),

              Positioned(
                left: 1.0 * scale,
                top: 38.0 * scale,
                width: 90.0 * scale,
                height: 90.0 * scale,
                child: Image.memory(layers[2], fit: BoxFit.contain),
              ),

              Positioned(
                left: 1.0 * scale,
                top: 3.0 * scale,
                width: 90.0 * scale,
                height: 90.0 * scale,
                child: Image.memory(layers[3], fit: BoxFit.contain),
              ),

              Positioned(
                left: 0.0 * scale,
                top: 0.0 * scale,
                width: 90.0 * scale,
                height: 90.0 * scale,
                child: Image.memory(layers[4], fit: BoxFit.contain),
              ),

              if (widget.hatIndex > 0 && layers.length > 5)
                Positioned(
                  left: 0.0 * scale,
                  top: 0.0 * scale,
                  width: 90.0 * scale,
                  height: 90.0 * scale,
                  child: Image.memory(layers[5], fit: BoxFit.contain),
                ),
            ],
          ),
        );
      },
    );
  }
}
