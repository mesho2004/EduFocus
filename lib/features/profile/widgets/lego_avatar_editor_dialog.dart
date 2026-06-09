import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';
import 'package:edufocus/core/utils/widgets/lego_character_widget.dart';

class LegoConfig {
  final int headIndex;
  final int hairIndex;
  final int bodyIndex;
  final int legIndex;
  final int hatIndex;
  final Color? torsoColor;
  final Color? pantsColor;
  final Color? hairColor;

  LegoConfig({
    required this.headIndex,
    required this.hairIndex,
    required this.bodyIndex,
    required this.legIndex,
    required this.hatIndex,
    this.torsoColor,
    this.pantsColor,
    this.hairColor,
  });

  LegoConfig copyWith({
    int? headIndex,
    int? hairIndex,
    int? bodyIndex,
    int? legIndex,
    int? hatIndex,
    Color? torsoColor,
    Color? pantsColor,
    Color? hairColor,
    bool clearTorso = false,
    bool clearPants = false,
    bool clearHair = false,
  }) {
    return LegoConfig(
      headIndex: headIndex ?? this.headIndex,
      hairIndex: hairIndex ?? this.hairIndex,
      bodyIndex: bodyIndex ?? this.bodyIndex,
      legIndex: legIndex ?? this.legIndex,
      hatIndex: hatIndex ?? this.hatIndex,
      torsoColor: clearTorso ? null : (torsoColor ?? this.torsoColor),
      pantsColor: clearPants ? null : (pantsColor ?? this.pantsColor),
      hairColor: clearHair ? null : (hairColor ?? this.hairColor),
    );
  }
}

class LegoAvatarEditorDialog extends StatefulWidget {
  final LegoConfig initialConfig;

  const LegoAvatarEditorDialog({
    super.key,
    required this.initialConfig,
  });

  @override
  State<LegoAvatarEditorDialog> createState() => _LegoAvatarEditorDialogState();
}

class _LegoAvatarEditorDialogState extends State<LegoAvatarEditorDialog> {
  late List<LegoConfig> _history;
  late int _historyIndex;
  int _selectedTab = 0; // 0: Face, 1: Hair, 2: Shirt, 3: Pants, 4: Hat
  late final Future<void> _prefetchFuture;

  final List<Color> _shirtColors = [
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
  ];

  final List<Color> _pantsColors = [
    Colors.black87,
    Colors.blueGrey,
    Colors.brown,
    Colors.indigo,
    Colors.green,
    Colors.orangeAccent,
    Colors.deepPurple,
  ];

  final List<Color> _hairColors = [
    const Color(0xFFE6C229), // Blonde
    const Color(0xFF8B5A2B), // Brown
    const Color(0xFFD62246), // Red
    const Color(0xFF4A90E2), // Blue
    const Color(0xFF9B59B6), // Purple
    const Color(0xFF2ECC71), // Green
  ];

  @override
  void initState() {
    super.initState();
    _history = [widget.initialConfig];
    _historyIndex = 0;
    _prefetchFuture = LegoCharacterHelper.prefetch();
  }

  LegoConfig get _currentConfig => _history[_historyIndex];

  void _pushState(LegoConfig newConfig) {
    if (_historyIndex < _history.length - 1) {
      _history = _history.sublist(0, _historyIndex + 1);
    }
    _history.add(newConfig);
    _historyIndex = _history.length - 1;
    setState(() {});
  }

  void _undo() {
    if (_historyIndex > 0) {
      setState(() {
        _historyIndex--;
      });
    }
  }

  void _redo() {
    if (_historyIndex < _history.length - 1) {
      setState(() {
        _historyIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Preview area
          Stack(
            children: [
              CustomPaint(
                painter: SearchlightPainter(),
                child: Container(
                  height: 280 + topPadding,
                  padding: EdgeInsets.only(top: topPadding),
                  alignment: Alignment.center,
                  child: LegoCharacterWidget(
                    headIndex: _currentConfig.headIndex,
                    hairIndex: _currentConfig.hairIndex,
                    bodyIndex: _currentConfig.bodyIndex,
                    legIndex: _currentConfig.legIndex,
                    hatIndex: _currentConfig.hatIndex,
                    torsoColor: _currentConfig.torsoColor,
                    pantsColor: _currentConfig.pantsColor,
                    hairColor: _currentConfig.hairColor,
                    size: 110,
                  ),
                ),
              ),
              // Close (X) button
              Positioned(
                left: 16,
                top: 16 + topPadding,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/character/icons/Close.svg',
                      colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              // Save button
              Positioned(
                right: 16,
                top: 16 + topPadding,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.brandBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () async {
                    await LegoCharacterHelper.saveConfig(
                      headIndex: _currentConfig.headIndex,
                      hairIndex: _currentConfig.hairIndex,
                      bodyIndex: _currentConfig.bodyIndex,
                      legIndex: _currentConfig.legIndex,
                      hatIndex: _currentConfig.hatIndex,
                      torsoColor: _currentConfig.torsoColor,
                      pantsColor: _currentConfig.pantsColor,
                      hairColor: _currentConfig.hairColor,
                    );
                    if (context.mounted) {
                      Navigator.pop(context, _currentConfig);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              // Undo/Redo buttons
              Positioned(
                left: 16,
                bottom: 16,
                child: Row(
                  children: [
                    _buildHistoryButton(
                      iconPath: 'assets/images/character/icons/Undo.svg',
                      onPressed: _historyIndex > 0 ? _undo : null,
                    ),
                    const SizedBox(width: 12),
                    _buildHistoryButton(
                      iconPath: 'assets/images/character/icons/Redo.svg',
                      onPressed: _historyIndex < _history.length - 1 ? _redo : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 2. Tabs selector
          _buildCategoryTabs(),
          // 3. Selection grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: context.colors.cardBackground,
              child: _buildGridContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton({
    required String iconPath,
    VoidCallback? onPressed,
  }) {
    final enabled = onPressed != null;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white70 : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            enabled ? Colors.black87 : Colors.black26,
            BlendMode.srcIn,
          ),
          width: 20,
          height: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: context.colors.background,
        border: Border(
          bottom: BorderSide(color: context.colors.border, width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(0, 'assets/images/character/icons/Head.svg', 'Face'),
          _buildTabItem(1, 'assets/images/character/icons/Hair.svg', 'Hair'),
          _buildTabItem(2, 'assets/images/character/icons/Body.svg', 'Shirt'),
          _buildTabItem(3, 'assets/images/character/icons/Leg.svg', 'Pants'),
          _buildTabItem(4, 'assets/images/character/icons/Hat.svg', 'Hat'),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String iconPath, String label) {
    final isSelected = _selectedTab == index;
    final color = isSelected ? context.colors.brandBlue : context.colors.textTertiary;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridContent() {
    switch (_selectedTab) {
      case 0: // Face/Head
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Face',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<void>(
                future: _prefetchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 13,
                    itemBuilder: (context, index) {
                      final headNum = index + 1;
                      final isSelected = _currentConfig.headIndex == headNum;
                      final headBytes = LegoCharacterHelper.getHeadBytes(headNum);
                      return GestureDetector(
                        onTap: () {
                          if (!isSelected) {
                            _pushState(_currentConfig.copyWith(headIndex: headNum));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colors.brandBlue.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? context.colors.brandBlue : context.colors.border,
                              width: 2.2,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Image.memory(
                            headBytes,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );

      case 1: // Hair Styles & Colors
        return _buildStyleAndColorSelector(
          itemCount: 8,
          selectedIndex: _currentConfig.hairIndex,
          getStyleBytes: LegoCharacterHelper.getHairBytes,
          selectedColor: _currentConfig.hairColor,
          colors: _hairColors,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(hairIndex: styleNum));
          },
          onColorSelected: (color) {
            _pushState(
              color == null
                  ? _currentConfig.copyWith(clearHair: true)
                  : _currentConfig.copyWith(hairColor: color),
            );
          },
          previewColor: _currentConfig.hairColor,
          blendMode: BlendMode.color,
        );

      case 2: // Shirt/Torso Styles & Colors
        return _buildStyleAndColorSelector(
          itemCount: 8,
          selectedIndex: _currentConfig.bodyIndex,
          getStyleBytes: LegoCharacterHelper.getBodyBytes,
          selectedColor: _currentConfig.torsoColor,
          colors: _shirtColors,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(bodyIndex: styleNum));
          },
          onColorSelected: (color) {
            _pushState(
              color == null
                  ? _currentConfig.copyWith(clearTorso: true)
                  : _currentConfig.copyWith(torsoColor: color),
            );
          },
          previewColor: _currentConfig.torsoColor,
          blendMode: BlendMode.modulate,
        );

      case 3: // Pants/Legs Styles & Colors
        return _buildStyleAndColorSelector(
          itemCount: 9,
          selectedIndex: _currentConfig.legIndex,
          getStyleBytes: LegoCharacterHelper.getLegBytes,
          selectedColor: _currentConfig.pantsColor,
          colors: _pantsColors,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(legIndex: styleNum));
          },
          onColorSelected: (color) {
            _pushState(
              color == null
                  ? _currentConfig.copyWith(clearPants: true)
                  : _currentConfig.copyWith(pantsColor: color),
            );
          },
          previewColor: _currentConfig.pantsColor,
          blendMode: BlendMode.modulate,
        );

      case 4: // Hat
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Hat',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<void>(
                future: _prefetchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 9, // index 0 (None) + styles 1 to 8
                    itemBuilder: (context, index) {
                      final hatNum = index; // 0 represents None
                      final isSelected = _currentConfig.hatIndex == hatNum;
                      return GestureDetector(
                        onTap: () {
                          if (!isSelected) {
                            _pushState(_currentConfig.copyWith(hatIndex: hatNum));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colors.brandBlue.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? context.colors.brandBlue : context.colors.border,
                              width: 2.2,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: hatNum == 0
                              ? SvgPicture.asset(
                                  'assets/images/character/hats/None.svg',
                                  fit: BoxFit.contain,
                                )
                              : Image.memory(
                                  LegoCharacterHelper.getHatBytes(hatNum),
                                  fit: BoxFit.contain,
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStyleAndColorSelector({
    required int itemCount,
    required int selectedIndex,
    required Uint8List Function(int) getStyleBytes,
    required Color? selectedColor,
    required List<Color> colors,
    required ValueChanged<int> onStyleSelected,
    required ValueChanged<Color?> onColorSelected,
    Color? previewColor,
    BlendMode? blendMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Style',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final styleNum = index + 1;
              final isSelected = selectedIndex == styleNum;
              final bytes = getStyleBytes(styleNum);
              return GestureDetector(
                onTap: () => onStyleSelected(styleNum),
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.brandBlue.withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? context.colors.brandBlue : context.colors.border,
                      width: 2.2,
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                    color: previewColor,
                    colorBlendMode: previewColor != null ? blendMode : null,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Choose Color',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: colors.length + 1, // +1 for None/Original
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = selectedColor == null;
                return GestureDetector(
                  onTap: () => onColorSelected(null),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? context.colors.brandBlue : context.colors.border,
                        width: isSelected ? 3.0 : 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.block_rounded,
                        color: isSelected ? context.colors.brandBlue : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                );
              }
              final color = colors[index - 1];
              final isSelected = selectedColor == color;
              return GestureDetector(
                onTap: () => onColorSelected(color),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: isSelected ? 8.0 : 2.0,
                        spreadRadius: isSelected ? 1.0 : 0.0,
                      ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw background color
    final bgPaint = Paint()..color = const Color(0xFFCBE3FF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Draw searchlight sunbeams radiating from the top center
    final beamPaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, -30);
    final count = 12;
    final maxRadius = size.height * 1.5;

    for (int i = 0; i < count; i++) {
      if (i % 2 == 0) continue;
      final startAngle = (3.14159 / count) * i;
      final endAngle = (3.14159 / count) * (i + 0.8);

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: maxRadius),
          startAngle,
          endAngle - startAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, beamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
